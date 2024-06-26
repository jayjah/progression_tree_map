import 'package:flutter/material.dart';
import 'classes/node_container.dart';
import 'classes/tree_node.dart';
import 'enums/node_position.dart';
import 'extensions/nums.dart';
import 'extensions/colors.dart';
import 'package:collection/collection.dart';
import 'dart:math' as math;
import 'package:vector_math/vector_math.dart' as vector;
import 'enums/nodes_placement.dart';
import 'helpers/helpers.dart';
import 'widgets/circular_boundaries.dart';
import 'widgets/connecting_line.dart';
import 'widgets/hole_clipper.dart';
import 'widgets/pop_up_widget.dart';

/// The tree map circular UI
class ProgressionTreeMap extends StatefulWidget {
  const ProgressionTreeMap(
      {super.key,
      required this.treeNodes,
      this.spacingFactor = 0,
      this.maxDepthToShow = 0,
      this.circleBoundaryColor = Colors.grey,
      this.circleBoundaryShade = true,
      this.circleBoundaryPaintingStyle = PaintingStyle.stroke,
      this.nodePlacement = NodesPlacement.border,
      this.nodeSeparationAngleFac = 1.0,
      this.globalNodeSize,
      this.centerNodeSize,
      this.linesStrokeColor = Colors.white,
      this.linesStrokeWidth = 1,
      this.linesStartFromOrigin,
      this.circleBoundaryStrokeWidth = 5,
      this.nodeDecoration =
          const BoxDecoration(color: Colors.white, shape: BoxShape.circle),
      this.interactiveViewClipBehavior = Clip.hardEdge,
      this.activeDepth,
      this.outerCircleColor = Colors.grey,
      this.transformationController});

  @override
  State<ProgressionTreeMap> createState() => _ProgressionTreeMapState();

  ///  The list of [TreeNode] to plot to the Ui
  final Map<TreeNode?, List<TreeNode>> treeNodes;

  /// How far apart to space the circle borders
  final double spacingFactor;

  /// Color for the outer circle
  final Color? outerCircleColor;

  /// Max number of circle borders to show
  final int maxDepthToShow;

  /// The color of the circle bounder
  final Color circleBoundaryColor;

  /// Whether to apply shade to the boundaries
  final bool circleBoundaryShade;

  /// How to paint the circle borders
  final PaintingStyle circleBoundaryPaintingStyle;

  /// Configures where the nodes are placed either in relation to circle border line
  final NodesPlacement nodePlacement;

  /// How far apart the nodes to be
  final double nodeSeparationAngleFac;

  /// Configures the sizes of all the nodes
  final double? globalNodeSize;

  /// Configures the size of the main/center node
  final double? centerNodeSize;

  /// Whether to draw node connection lines from the origin
  final bool? linesStartFromOrigin;

  /// The color of the connecting lines
  final Color linesStrokeColor;

  /// The width of the connecting lines
  final double linesStrokeWidth;

  /// Configures the decoration of all the nodes
  final BoxDecoration? nodeDecoration;

  /// The width of the stroke for the circle borders
  final double circleBoundaryStrokeWidth;

  /// If set to Clip.none, the child may extend beyond the size of the InteractiveViewer,
  /// but it will not receive gestures in these areas. Be sure that the InteractiveViewer
  /// is the desired size when using Clip.none
  final Clip interactiveViewClipBehavior;

  /// This is controller that links to the Interactive viewer of this widget.
  final TransformationController? transformationController;

  /// Use this to control the current visible nodes/active nodes.
  final int? activeDepth;
}

class _ProgressionTreeMapState extends State<ProgressionTreeMap> {
  final List<Map<NodeContainer, TreeNode>> _uiNodesRaw = [];
  List<Map<TreeNode, List<TreeNode>>> _uiNodesPrep = [];

  double _nodePositionFactor = 0;
  double _defaultNodeSize = 0;
  double _centerNodeSize = 0;
  bool _linesStartFromOrigin = true;

  TreeNode? _centerTreeNode;
  TreeNode? _popUpNode;
  double _activeDepthRadius = -1;
  late BoxConstraints _viewportConstraints;

  @override
  void initState() {
    super.initState();

    if (widget.transformationController != null) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        final x = Offset(_viewportConstraints.maxWidth * 0.8,
            _viewportConstraints.maxHeight / 2);
        final offset1 = widget.transformationController!.toScene(x);
        widget.transformationController!.value.scale(0.9);
        final offset2 = widget.transformationController!.toScene(x);
        final dx = offset1.dx - offset2.dx;
        final dy = offset1.dy - offset2.dy;
        widget.transformationController!.value.translate(dx, dy);
        if (mounted) setState(() {});
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final Size mediaQueryData = MediaQuery.sizeOf(context);
    final int treeNodeDepth = _treeNodeDepth(widget.treeNodes.values.first);
    final int nodeDepth = widget.maxDepthToShow > treeNodeDepth
        ? treeNodeDepth
        : (widget.maxDepthToShow < 1 ? treeNodeDepth : widget.maxDepthToShow);

    return InteractiveViewer(
      minScale: 0.8,
      boundaryMargin: const EdgeInsets.all(42),
      maxScale: 2.0,
      transformationController: widget.transformationController,
      clipBehavior: widget.interactiveViewClipBehavior,
      constrained: false,
      alignment: Alignment.center,
      child: SizedBox(
        width: mediaQueryData.width * 2,
        height: mediaQueryData.height,
        child: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints viewportConstraints) {
            _viewportConstraints = viewportConstraints;
            final double spacing = (viewportConstraints.maxWidth / nodeDepth);

            _centerNodeSize = widget.centerNodeSize == null
                ? (spacing / 2)
                : widget.centerNodeSize!;
            _defaultNodeSize = widget.globalNodeSize == null
                ? _centerNodeSize / 2
                : widget.globalNodeSize!;

            _getNodePlacementFactor(spacing);

            _prepareUiNodes(
                widget.treeNodes.values.first, viewportConstraints, spacing);
            _centerTreeNode = widget.treeNodes.keys.first;

            _linesStartFromOrigin = widget.linesStartFromOrigin == null
                ? (_centerTreeNode == null ? false : true)
                : widget.linesStartFromOrigin!;

            _activeDepthRadius =
                (spacing * (widget.activeDepth ?? nodeDepth)) / 2 +
                    _defaultNodeSize / 2;

            return Center(
              child: SizedBox(
                width: viewportConstraints.maxWidth,
                height: viewportConstraints.maxHeight,
                child: Stack(
                  children: [
                    Stack(
                        clipBehavior: Clip.none,
                        alignment: Alignment.center,
                        children: [
                          ...List.generate(nodeDepth, (index) {
                            final looper = nodeDepth - index;

                            return CustomPaint(
                              painter: CircularBoundaries(
                                  radius: (looper * spacing) / 2,
                                  strokeWidth: widget.circleBoundaryStrokeWidth,
                                  paintingStyle:
                                      widget.circleBoundaryPaintingStyle,
                                  color: widget.circleBoundaryColor.tintOrShade(
                                      widget.circleBoundaryShade
                                          ? ((100 * (looper / nodeDepth))
                                              .clampRange(min: 30, max: 0))
                                          : 0,
                                      darken: false)),
                            );
                          }),
                          CustomPaint(
                            painter: ConnectingLine(
                                uiNodesPrep: _uiNodesPrep,
                                color: widget.linesStrokeColor,
                                strokeWidth: widget.linesStrokeWidth,
                                startFromCenter: _linesStartFromOrigin),
                            size: viewportConstraints.biggest,
                          ),
                          if (_centerTreeNode != null)
                            Container(
                              alignment: Alignment.center,
                              width: _centerNodeSize,
                              height: _centerNodeSize,
                              decoration: _centerTreeNode!.decoration ??
                                  widget.nodeDecoration,
                              child: _centerTreeNode!.child,
                            ),
                          ..._displayUiNodesWidgets(),
                          if (widget.outerCircleColor != null)
                            ClipPath(
                                clipper:
                                    HoleClipper(radius: _activeDepthRadius),
                                clipBehavior: Clip.antiAlias,
                                child: Container(
                                  width: viewportConstraints.maxWidth,
                                  height: viewportConstraints.maxHeight,
                                  decoration: BoxDecoration(
                                    color: widget.outerCircleColor,
                                    backgroundBlendMode: BlendMode.saturation,
                                  ),
                                ))
                        ]),
                    if (_popUpNode != null && _popUpNode?.popUpWidget != null)
                      PopUpWidget(popUpNode: _popUpNode!)
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  int _treeNodeDepth(List<TreeNode> nd) {
    Map<int, int> pathDepth = {};
    int count = 0;
    nodeDepthTraverse(List<TreeNode> nodes) {
      count++;
      int count2 = count;
      for (TreeNode node in nodes) {
        if (node.nodes.isNotEmpty) {
          nodeDepthTraverse(node.nodes);
        } else {
          count = count2;
        }
      }
    }

    nd.forEachIndexed((index, node) {
      count = node.nodes.isEmpty ? 0 : 1;
      nodeDepthTraverse(node.nodes);
      pathDepth[index] = count;
    });
    return pathDepth.values.max;
  }

  int _nodeDepth = 0;

  void _prepareUiNodes(List<TreeNode> treeNodes,
      BoxConstraints viewportConstraints, double spacing) {
    _uiNodesRaw.clear();
    _uiNodesPrep.clear();

    for (TreeNode tNode in treeNodes) {
      // Reset the depth of the index node
      _nodeDepth = 1;
      tNode = tNode.copyWith(
          depth: _nodeDepth, size: tNode.size ?? _defaultNodeSize);
      _nodeTraverse(tNode);
    }

    double baseAngle = -360 /
        _uiNodesRaw
            .where((uiR) =>
                uiR.keys.first.treeNode.depth == 1 &&
                uiR.keys.first.nodePosition == NodePosition.start)
            .length;
    double increment = -0.5;
    _uiNodesRaw.forEachIndexed((index, nodeMap) {
      // Filter only the end nodes
      List<Map<NodeContainer, TreeNode>> mUiNodesRaw = _uiNodesRaw
          .where((uiNode) =>
              uiNode.keys.first.nodePosition == NodePosition.end &&
              uiNode.keys.first.treeNode == nodeMap.keys.first.treeNode)
          .toList();

      if (nodeMap.keys.first.nodePosition == NodePosition.start) {
        TreeNode keyNode = nodeMap.keys.first.treeNode;
        if (keyNode.depth == 1) {
          keyNode = keyNode.copyWith(
              angle: baseAngle * increment,
              offset: Offset(
                ((viewportConstraints.maxWidth / 2 - (keyNode.size! / 2)) +
                    ((keyNode.depth * spacing / 2) - _nodePositionFactor) *
                        math.sin(vector.radians(baseAngle * increment))),
                ((viewportConstraints.maxHeight / 2 - (keyNode.size! / 2)) +
                    ((keyNode.depth * spacing / 2) - _nodePositionFactor) *
                        math.cos(vector.radians(baseAngle * increment))),
              ));
          increment++;
        }
        List<TreeNode> valueNodes =
            mUiNodesRaw.map((e) => e.values.first).toList();

        _uiNodesPrep.add({keyNode: valueNodes});
      }
    });
    //Loop depth
    int maxDepth = _uiNodesPrep.map((uiN) => uiN.keys.first.depth).max;
    List<Map<TreeNode, List<TreeNode>>> total = [];
    for (int depthCount = 1; depthCount <= maxDepth; depthCount++) {
      List<Map<TreeNode, List<TreeNode>>> mUiNodesPrepDepth = _uiNodesPrep
          .where((uiR) => uiR.keys.first.depth == depthCount)
          .mapIndexed((index3, mUnDepth) {
        TreeNode keyNode = mUnDepth.keys.first;
        List<TreeNode> valueNodes = mUnDepth.values.first;
        if (depthCount != 1) {
          // Other depth depends on the previous bias.
          Map<TreeNode, List<TreeNode>>? mp = total
              .firstWhereOrNull((uiP) => uiP.values.first.contains(keyNode));
          mp ??= _uiNodesPrep
              .where((uiP) => uiP.values.first.contains(keyNode))
              .first;

          List<TreeNode> keyNodes = mp.values.first.map((e) => e).toList();
          keyNodes.forEachIndexed((ind, vNode) {
            double vnAngle = (mp!.keys.first.angle -
                (15 * widget.nodeSeparationAngleFac) * ind);
            if (keyNodes.length > 1) {
              vnAngle = MathHelpers.clampRange(
                  percentage: (((ind + 1) / keyNodes.length) * 100),
                  min: (mp.keys.first.angle) -
                      ((15 * widget.nodeSeparationAngleFac) *
                          (keyNodes.length / 2)),
                  max: (mp.keys.first.angle) +
                      ((15 * widget.nodeSeparationAngleFac) *
                          (keyNodes.length / 2)));
            }

            if (vNode == keyNode) {
              keyNode = vNode.copyWith(
                  angle: vnAngle,
                  offset: Offset(
                    ((viewportConstraints.maxWidth / 2 - (vNode.size! / 2)) +
                        (((vNode.depth) * spacing / 2) - _nodePositionFactor) *
                            math.sin(vector.radians(vnAngle))),
                    ((viewportConstraints.maxHeight / 2 - (vNode.size! / 2)) +
                        (((vNode.depth) * spacing / 2) - _nodePositionFactor) *
                            math.cos(vector.radians(vnAngle))),
                  ));
            }
          });
        }

        mUnDepth = {keyNode: valueNodes};
        return mUnDepth;
      }).toList();
      total.addAll(mUiNodesPrepDepth);
    }
    _uiNodesPrep = total;

    _uiNodesPrep = _uiNodesPrep.mapIndexed((index, uiNode) {
      TreeNode keyNode = uiNode.keys.first;
      List<TreeNode> valueNodes = uiNode.values.first.map((e) => e).toList();
      valueNodes = valueNodes.mapIndexed((ind, vNode) {
        double vnAngle =
            (keyNode.angle - (15 * widget.nodeSeparationAngleFac) * ind);

        if (valueNodes.length > 1) {
          vnAngle = MathHelpers.clampRange(
              percentage: (((ind + 1) / valueNodes.length) * 100),
              min: keyNode.angle -
                  ((15 * widget.nodeSeparationAngleFac) *
                      (valueNodes.length / 2)),
              max: keyNode.angle +
                  ((15 * widget.nodeSeparationAngleFac) *
                      (valueNodes.length / 2)));
        }

        return vNode.copyWith(
            angle: vnAngle,
            offset: Offset(
              ((viewportConstraints.maxWidth / 2 - (vNode.size! / 2)) +
                  (((vNode.depth) * spacing / 2) - _nodePositionFactor) *
                      math.sin(vector.radians(vnAngle))),
              ((viewportConstraints.maxHeight / 2 - (vNode.size! / 2)) +
                  (((vNode.depth) * spacing / 2) - _nodePositionFactor) *
                      math.cos(vector.radians(vnAngle))),
            ));
      }).toList();

      return {keyNode: valueNodes};
    }).toList();
  }

  void _nodeTraverse(TreeNode tNode) {
    _uiNodesRaw.add({NodeContainer(tNode, NodePosition.start): tNode});
    tNode.nodes.forEachIndexed((index, tNode2) {
      _nodeDepth = tNode.depth + 1;
      tNode2 = tNode2.copyWith(
          depth: _nodeDepth, size: tNode2.size ?? _defaultNodeSize);

      _uiNodesRaw.add({NodeContainer(tNode, NodePosition.end): tNode2});
      if (tNode2.nodes.isNotEmpty) {
        _nodeTraverse(tNode2);
      }
    });
  }

  List<Widget> _displayUiNodesWidgets() {
    List<Widget> w = [];
    for (Map<TreeNode, List<TreeNode>> uiN in _uiNodesPrep) {
      if (uiN.keys.first.partnerWidget != null) {
        Offset offset = uiN.keys.first.partnerWidgetOffset ??
            Offset(uiN.keys.first.size ?? 0, uiN.keys.first.size ?? 0);
        w.add(Positioned(
            top: uiN.keys.first.offset.dy - offset.dy,
            left: uiN.keys.first.offset.dx + offset.dx,
            child: uiN.keys.first.partnerWidget!));
      }

      w.add(Positioned(
        top: uiN.keys.first.offset.dy,
        left: uiN.keys.first.offset.dx,
        child: GestureDetector(
          onTap: () => _showPopUp(uiN.keys.first),
          child: Container(
              alignment: Alignment.center,
              width: uiN.keys.first.size,
              height: uiN.keys.first.size,
              decoration: uiN.keys.first.decoration ?? widget.nodeDecoration,
              child: uiN.keys.first.child),
        ),
      ));

      for (TreeNode tNode in uiN.values.first) {
        if (tNode.partnerWidget != null) {
          Offset offset = tNode.partnerWidgetOffset ??
              Offset((tNode.size ?? 0), (tNode.size ?? 0));
          w.add(Positioned(
              top: tNode.offset.dy - offset.dy,
              left: tNode.offset.dx + offset.dx,
              child: tNode.partnerWidget!));
        }
        w.add(Positioned(
          top: tNode.offset.dy,
          left: tNode.offset.dx,
          child: GestureDetector(
            onTap: () => _showPopUp(tNode),
            child: Container(
                alignment: Alignment.center,
                width: tNode.size,
                height: tNode.size,
                decoration: tNode.decoration ?? widget.nodeDecoration,
                child: tNode.child),
          ),
        ));
      }
    }
    return w;
  }

  void _getNodePlacementFactor(double spacing) {
    switch (widget.nodePlacement) {
      case NodesPlacement.centerIn:
        _nodePositionFactor = (spacing / 2) / 2;
      case NodesPlacement.centerOut:
        _nodePositionFactor = -(spacing / 2) / 2;
      default:
        _nodePositionFactor = 0;
    }
  }

  void _showPopUp(TreeNode node) =>
      setState(() => _popUpNode = _popUpNode == null ? node : null);
}

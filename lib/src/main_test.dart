import 'package:flutter/material.dart';
import 'package:progression_tree_map/progression_tree_map.dart';

void main() {
  runApp(
    MaterialApp(
      home: Material(
        child: SkillTreeWidget(
          subCategoryName: 'test',
          onItemTap: () {},
        ),
      ),
    ),
  );
}

class SkillTreeWidget extends StatefulWidget {
  const SkillTreeWidget({
    super.key,
    //  required this.tree,
    required this.subCategoryName,
    required this.onItemTap,
  });
  //final SkillTree tree;
  final String subCategoryName;
  final VoidCallback onItemTap;
  @override
  State<SkillTreeWidget> createState() => _SkillTreeWidgetState();
}

class _SkillTreeWidgetState extends State<SkillTreeWidget> {
  final TransformationController _controller = TransformationController();
  //late Map<int, Widget> _skills = _buildSkillTree();

  @override
  void didUpdateWidget(covariant SkillTreeWidget oldWidget) {
    //if (oldWidget.tree != widget.tree) _skills = _buildSkillTree();
    super.didUpdateWidget(oldWidget);
  }

  @override
  void dispose() {
    _controller.dispose();
    //_skills.clear();
    super.dispose();
  }

  /*@override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);

    return InteractiveViewer(
      constrained: true,
      trackpadScrollCausesScale: true,
      transformationController: _controller,
      //boundaryMargin: const EdgeInsets.all(42),
      alignment: Alignment.bottomCenter,
      //maxScale: 5.0,
      //minScale: 0.1,
      child: ArrowContainer(
        listenables: <Listenable>[_controller],
        child: Column(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            for (int i = _skills.keys.length - 1; i >= 0; i--) _skills[i]!,
            Center(child: _buildSkillWidget(widget.tree.firstNode)),
            Center(child: HeaderContent(content: widget.subCategoryName)),
          ],
        ),
      ),
    );
  }*/

  /*
  Widget _buildSkillWidget(SkillNode node) => _SkillWidget(
        key: ValueKey<String>(node.value.content),
        node: node,
        onItemTap: widget.onItemTap,
      );

  Map<int, Widget> _buildSkillTree() {
    final result = <int, Widget>{};
    final List<SkillNode> currentNodes = widget.tree.firstNode.afterSuccess;
    final List<SkillNode> childNodes = [];
    for (int i = 0; i < widget.tree.steps; i++) {
      final widgetChildren = <Widget>[];
      for (int j = 0; j < currentNodes.length; j++) {
        final nextNode = currentNodes[j];
        final maxLength = currentNodes.length - 1;
        final middleLength = maxLength / 2;
        childNodes.addAll(nextNode.afterSuccess);

        double topPadding = 10;
        // first and end widgets should appear most radial
        if (j == 0 || j == maxLength)
          topPadding = 100;
        else if (j != middleLength) {
          final differenceToTheMiddle = (j - middleLength).abs();
          topPadding = max(differenceToTheMiddle * 40, 90);
        }

        widgetChildren.add(
          Padding(
            padding: EdgeInsets.only(top: topPadding),
            child: _buildSkillWidget(nextNode),
          ),
        );
      }
      result[i] = Expanded(
        child: Row(
          //  crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: widgetChildren,
        ),
      );
      currentNodes
        ..clear()
        ..addAll(childNodes);
      childNodes.clear();
    }
    return result;
  }*/

  final Map<TreeNode?, List<TreeNode>> nodes = {
    TreeNode(
      child: Material(
        color: Colors.black,
        borderRadius: const BorderRadius.all(Radius.circular(36)),
        child: InkWell(
            borderRadius: const BorderRadius.all(Radius.circular(36)),
            onTap: () {
              print('tapped');
            },
            child: Image(image: AssetImage('assets/images/katze_main.png'))),
      ),
    ): [
      TreeNode(
        firstChildPos: 1,
        child: Image(image: AssetImage('assets/images/katze_main.png')),
        nodes: [
          TreeNode(
            child: Image(image: AssetImage('assets/images/katze_main.png')),
            nodes: [
              TreeNode(
                child: Image(image: AssetImage('assets/images/katze_main.png')),
              )
            ],
          )
        ],
      ),
      TreeNode(
        firstChildPos: 2,
        child: Image(image: AssetImage('assets/images/katze_main.png')),
        nodes: [
          TreeNode(
            child: Image(image: AssetImage('assets/images/katze_main.png')),
            nodes: [
              TreeNode(
                child: Image(image: AssetImage('assets/images/katze_main.png')),
                nodes: [
                  TreeNode(
                    child: Image(
                        image: AssetImage('assets/images/katze_main.png')),
                  ),
                ],
              ),
            ],
          )
        ],
      ),
      TreeNode(
        firstChildPos: 3,
        child: Image(image: AssetImage('assets/images/katze_main.png')),
        nodes: [
          TreeNode(
            child: Image(
              image: AssetImage('assets/images/katze_main.png'),
            ),
            nodes: [
              TreeNode(
                child: Image(
                  image: AssetImage('assets/images/katze_main.png'),
                ),
              ),
            ],
          ),
          TreeNode(
            child: Image(
              image: AssetImage('assets/images/katze_main.png'),
            ),
            nodes: [
              TreeNode(
                child: Image(
                  image: AssetImage('assets/images/katze_main.png'),
                ),
              ),
            ],
          ),
          TreeNode(
            child: Image(
              image: AssetImage('assets/images/katze_main.png'),
            ),
            nodes: [
              TreeNode(
                child: Image(
                  image: AssetImage('assets/images/katze_main.png'),
                ),
              ),
              TreeNode(
                child: Image(
                  image: AssetImage('assets/images/katze_main.png'),
                ),
              ),
            ],
          ),
        ],
      ),
    ],
  };

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    return ProgressionTreeMap(
      treeNodes: nodes,
      makeLineLighter: (TreeNode? lineFrom, TreeNode lineTo) => true,
      circleBoundaryColor: Colors.grey.shade900,
      circleBoundaryShade: false,
      spacingFactor: 1.0,
      nodeSeparationAngleFac: 2.0,
      linesStartFromOrigin: true,
      outerCircleColor: null,
      globalNodeSize: 40,
      centerNodeSize: 45,
      linesStrokeWidth: 3,
      linesStrokeColor: Colors.grey,
      nodePlacement: NodesPlacement.centerOut,
      interactiveViewClipBehavior: Clip.none,
      nodeDecoration: const BoxDecoration(shape: BoxShape.circle),
      activeDepth: 5,
      maxDepthToShow: 5,
    );
  }
}

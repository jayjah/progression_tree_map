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

  late final _togetherNode = TreeNode(
    id: 'tester',
    combiner: true,
    child: GestureDetector(
        onTap: () {
          print('TAP ON TESTER');
        },
        child: Image(image: AssetImage('assets/images/katze_main.png'))),
    nodes: [
      _togetherNode2,
    ],
  );
  final _togetherNode2 = TreeNode(
    id: 'tester2',
    combiner: true,
    child: GestureDetector(
        onTap: () {
          print('TAP ON TESTER2');
        },
        child: Image(image: AssetImage('assets/images/katze_main.png'))),
    /*nodes: [
    TreeNode(
      child: Image(image: AssetImage('assets/images/katze_main.png')),
    ),
  ],*/
  );

  late final Map<TreeNode?, List<TreeNode>> turnVaultMove = {
    TreeNode(
      depth: 10,
      id: 'main',
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
        firstChildPos: 4,
        child: Image(image: AssetImage('assets/images/katze_main.png')),
        nodes: [
          TreeNode(
            child: Image(image: AssetImage('assets/images/katze_main.png')),
            nodes: [
              _togetherNode,
            ],
          ),
          TreeNode(
            child: Image(image: AssetImage('assets/images/katze_main.png')),
            nodes: [
              TreeNode(
                child: Image(image: AssetImage('assets/images/katze_main.png')),
                nodes: [_togetherNode2],
              ),
              _togetherNode,
            ],
          ),
        ],
      ),
      TreeNode(
        firstChildPos: 22,
        child: Image(image: AssetImage('assets/images/katze_main.png')),
        nodes: [],
      ),
      TreeNode(
        firstChildPos: -14,
        child: Image(image: AssetImage('assets/images/katze_main.png')),
        nodes: [],
      ),
      TreeNode(
        firstChildPos: 40,
        child: Image(image: AssetImage('assets/images/katze_main.png')),
        nodes: [],
      ),
      TreeNode(
        firstChildPos: 49,
        child: Image(image: AssetImage('assets/images/katze_main.png')),
        nodes: [],
      ),
    ],
  };

  final Map<TreeNode?, List<TreeNode>> nodes = {
    TreeNode(
      id: 'main',
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
        firstChildPos: -6,
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
        firstChildPos: 6,
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
        firstChildPos: 35,
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

  final Map<TreeNode?, List<TreeNode>> catNewMove = {
    TreeNode(
      uniqueId: 'main',
      id: 'main',
      name: 'Katze',
      content:
          r'Beide Hände stützen schulterbreit auf dem Hindernis, beim Absprung nach vorne lehnen, das Gesäß wird nach oben gezogen, dann werden beide Beine zur Brust geführt und die Hände stoßen vom Kasten ab, um den Körper aufzurichten, die Hände werden nicht nochmal aufgesetzt',
      child: buildTreeNodeWidget(
        id: 'main',
        activeImagePath: 'assets/images/skills/cat/basis.png',
        inactiveImagePath: 'assets/images/skills/cat/basis.png',
        subCategoryName: 'Katze',
      ),
    ): [
      TreeNode(
        firstChildPos: -20,
        id: 'vortex',
        nodes: [
          TreeNode(
            childPos: -20,
            id: 'vortex',
            nodes: [
              TreeNode(
                childPos: -20,
                id: 'vortex',
                nodes: [
                  TreeNode(
                    childPos: -20,
                    uniqueId: 'vortex',
                    id: 'vortex',
                    child: buildTreeNodeWidget(
                      id: 'vortex',
                      activeImagePath:
                          'assets/images/skills/cat/active/vortex.png',
                      inactiveImagePath:
                          'assets/images/skills/cat/inactive/vortex.png',
                      subCategoryName: 'Katze',
                    ),
                    nodes: [],
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
      TreeNode(
        firstChildPos: -16,
        id: 'wormcat',
        nodes: [
          TreeNode(
            childPos: -16,
            id: 'wormcat',
            nodes: [
              TreeNode(
                childPos: -16,
                uniqueId: 'wormcat',
                id: 'wormcat',
                child: buildTreeNodeWidget(
                  id: 'wormcat',
                  activeImagePath:
                      'assets/images/skills/cat/active/wormcat.png',
                  inactiveImagePath:
                      'assets/images/skills/cat/inactive/wormcat.png',
                  subCategoryName: 'Katze',
                ),
              ),
            ],
          ),
        ],
      ),
      TreeNode(
        firstChildPos: -12,
        id: 'rocket',
        nodes: [
          TreeNode(
            childPos: -12,
            uniqueId: 'rocket',
            id: 'rocket',
            child: buildTreeNodeWidget(
              id: 'rocket',
              activeImagePath: 'assets/images/skills/cat/active/rocket.png',
              inactiveImagePath: 'assets/images/skills/cat/inactive/rocket.png',
              subCategoryName: 'Katze',
            ),
          ),
        ],
      ),
      TreeNode(
        firstChildPos: 31,
        uniqueId: 'dive_kong',
        id: 'dive_kong',
        child: buildTreeNodeWidget(
          id: 'dive_kong',
          activeImagePath: 'assets/images/skills/cat/active/dive_kong.png',
          inactiveImagePath: 'assets/images/skills/cat/inactive/dive_kong.png',
          subCategoryName: 'Katze',
        ),
        nodes: [
          // _catNewCombiner,
          TreeNode(
            childPos: 31,
            id: 'handstand_kong',
            nodes: [
              TreeNode(
                childPos: 31,
                uniqueId: 'handstand_kong',
                id: 'handstand_kong',
                child: buildTreeNodeWidget(
                  id: 'handstand_kong',
                  activeImagePath:
                      'assets/images/skills/cat/active/handstand_kong.png',
                  inactiveImagePath:
                      'assets/images/skills/cat/inactive/handstand_kong.png',
                  subCategoryName: 'Katze',
                ),
              ),
            ],
          ),
          TreeNode(
            childPos: 26,
            uniqueId: 'rolle',
            id: 'rolle',
            child: buildTreeNodeWidget(
              id: 'rolle',
              activeImagePath: 'assets/images/skills/cat/active/rolle.png',
              inactiveImagePath: 'assets/images/skills/cat/inactive/rolle.png',
              subCategoryName: 'Katze',
            ),
          ),
        ],
      ),
      TreeNode(
        firstChildPos: 40,
        uniqueId: 'long',
        id: 'long',
        child: buildTreeNodeWidget(
          id: 'long',
          activeImagePath: 'assets/images/skills/cat/active/long.png',
          inactiveImagePath: 'assets/images/skills/cat/inactive/long.png',
          subCategoryName: 'Ka tze',
        ),
        // nodes: [_catNewCombiner],
      ),
      TreeNode(
        firstChildPos: 48,
        id: 'reverse',
        nodes: [
          TreeNode(
            childPos: 48,
            uniqueId: 'reverse',
            id: 'reverse',
            child: buildTreeNodeWidget(
              id: 'reverse',
              activeImagePath: 'assets/images/skills/cat/active/reverse.png',
              inactiveImagePath:
                  'assets/images/skills/cat/inactive/reverse.png',
              subCategoryName: 'Katze',
            ),
          ),
        ],
      ),
      TreeNode(
        firstChildPos: 14,
        uniqueId: 'stuetz_praezi',
        id: 'stuetz_praezi',
        child: buildTreeNodeWidget(
          id: 'stuetz_praezi',
          activeImagePath: 'assets/images/skills/cat/active/stuetz_praezi.png',
          inactiveImagePath:
              'assets/images/skills/cat/inactive/stuetz_praezi.png',
          subCategoryName: 'Katze',
        ),
        nodes: [
          TreeNode(
            childPos: 14,
            uniqueId: 'stuetz_rueber',
            id: 'stuetz_rueber',
            child: buildTreeNodeWidget(
              id: 'stuetz_rueber',
              activeImagePath:
                  'assets/images/skills/cat/active/stuetz_rueber.png',
              inactiveImagePath:
                  'assets/images/skills/cat/inactive/stuetz_rueber.png',
              subCategoryName: 'Katze',
            ),
          ),
          TreeNode(
            childPos: 20,
            uniqueId: 'stuetz_rauf',
            id: 'stuetz_rauf',
            child: buildTreeNodeWidget(
              id: 'stuetz_rauf',
              activeImagePath:
                  'assets/images/skills/cat/active/stuetz_rauf.png',
              inactiveImagePath:
                  'assets/images/skills/cat/inactive/stuetz_rauf.png',
              subCategoryName: 'Katze',
            ),
          ),
        ],
      ),
      TreeNode(
        firstChildPos: -4,
        uniqueId: 'praezi',
        id: 'praezi',
        child: buildTreeNodeWidget(
          id: 'praezi',
          activeImagePath: 'assets/images/skills/cat/active/praezi.png',
          inactiveImagePath: 'assets/images/skills/cat/inactive/praezi.png',
          subCategoryName: 'Katze',
        ),
        nodes: [
          TreeNode(
            firstChildPos: -4,
            uniqueId: 'praezi_180',
            id: 'praezi_180',
            child: buildTreeNodeWidget(
              id: 'praezi_180',
              activeImagePath: 'assets/images/skills/cat/active/praezi_180.png',
              inactiveImagePath:
                  'assets/images/skills/cat/inactive/praezi_180.png',
              subCategoryName: 'Katze',
            ),
          ),
        ],
      ),
      TreeNode(
        firstChildPos: 4,
        uniqueId: 'stride',
        id: 'stride',
        child: buildTreeNodeWidget(
          id: 'stride',
          activeImagePath: 'assets/images/skills/cat/active/stride.png',
          inactiveImagePath: 'assets/images/skills/cat/inactive/stride.png',
          subCategoryName: 'Katze',
        ),
        nodes: [
          TreeNode(
            childPos: 4,
            uniqueId: 'cat_plus_move',
            id: 'cat_plus_move',
            child: buildTreeNodeWidget(
              id: 'cat_plus_move',
              activeImagePath:
                  'assets/images/skills/cat/active/cat_plus_move.png',
              inactiveImagePath:
                  'assets/images/skills/cat/inactive/cat_plus_move.png',
              subCategoryName: 'Katze',
            ),
          ),
        ],
      ),
    ],
  };

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    return ProgressionTreeMap(
      makeLineLighter: (TreeNode lineFrom, TreeNode lineTo) {
        print('make line lighter called ${lineFrom.id} ${lineTo.id}');
        if ((lineFrom.id == 'main' && lineTo.id == 'vortex') ||
            (lineFrom.id == 'vortex' && lineTo.id == 'vortex')) return true;
        return false;
      },
      treeNodes: catNewMove,
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

Widget buildTreeNodeWidget({
  required String id,
  required String activeImagePath,
  required String inactiveImagePath,
  required String subCategoryName,
}) =>
    Material(
      color: Colors.black,
      borderRadius: const BorderRadius.all(Radius.circular(36)),
      child: _IconAnimation(
        key: ValueKey(id),
        id: id,
        activeImagePath: activeImagePath,
        inactiveImagePath: inactiveImagePath,
        subCategoryName: subCategoryName,
      ),
    );

class _IconAnimation extends StatefulWidget {
  const _IconAnimation({
    super.key,
    required this.id,
    required this.activeImagePath,
    required this.inactiveImagePath,
    required this.subCategoryName,
  });
  final String id;
  final String activeImagePath;
  final String inactiveImagePath;
  final String subCategoryName;
  @override
  State<_IconAnimation> createState() => _IconAnimationState();
}

class _IconAnimationState extends State<_IconAnimation>
    with AutomaticKeepAliveClientMixin<_IconAnimation> {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);

    final Widget child = Image(
      image:
          AssetImage(false ? widget.activeImagePath : widget.inactiveImagePath),
    );

    return Builder(
      builder: (context) {
        return InkWell(
          borderRadius: const BorderRadius.all(Radius.circular(36)),
          onTap: () {},
          child: child,
        );
      },
    );
  }
}

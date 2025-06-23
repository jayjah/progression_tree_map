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

  @override
  void didUpdateWidget(covariant SkillTreeWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ProgressionTreeMap(
      treeNodes: defaultMove,
      makeLineLighter: (TreeNode lineFrom, TreeNode lineTo) {
        if (lineFrom.id == 'main') return true;
        return false;
      },
      transformationController: _controller,
      circleBoundaryColor: Colors.grey.shade900,
      circleBoundaryShade: false,
      spacingFactor: 1.0,
      nodeSeparationAngleFac: 2.0,
      linesStartFromOrigin: true,
      outerCircleColor: null,
      globalNodeSize: 120,
      centerNodeSize: 155,
      linesStrokeWidth: 3,
      linesStrokeColor: Colors.grey,
      nodePlacement: NodesPlacement.centerOut,
      interactiveViewClipBehavior: Clip.none,
      nodeDecoration: const BoxDecoration(shape: BoxShape.circle),
      activeDepth: 3,
      maxDepthToShow: 8,
    );
  }
}

final Map<TreeNode?, List<TreeNode>> defaultMove = {
  TreeNode(
    depth: 4,
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
      firstChildPos: 14,
      child: Image(image: AssetImage('assets/images/katze_main.png')),
      nodes: [
        TreeNode(
          child: Image(image: AssetImage('assets/images/katze_main.png')),
          nodes: [],
          childPos: 10,
        ),
        TreeNode(
          child: Image(image: AssetImage('assets/images/katze_main.png')),
          nodes: [],
          childPos: -28,
        ),
      ],
    ),
    /*TreeNode(
      firstChildPos: 4,
      child: Image(image: AssetImage('assets/images/katze_main.png')),
      nodes: [
        TreeNode(
          child: Image(image: AssetImage('assets/images/katze_main.png')),
          nodes: [
            TreeNode(
              child: Image(image: AssetImage('assets/images/katze_main.png')),
              nodes: [
                TreeNode(
                  child:
                      Image(image: AssetImage('assets/images/katze_main.png')),
                  nodes: [],
                ),
              ],
            ),
            TreeNode(
              child: Image(image: AssetImage('assets/images/katze_main.png')),
              nodes: [
                TreeNode(
                  child:
                      Image(image: AssetImage('assets/images/katze_main.png')),
                  nodes: [],
                ),
              ],
            ),
            TreeNode(
              child: Image(image: AssetImage('assets/images/katze_main.png')),
              nodes: [
                TreeNode(
                  child:
                      Image(image: AssetImage('assets/images/katze_main.png')),
                  nodes: [],
                ),
              ],
            ),
          ],
        ),
      ],
    ),
    TreeNode(
      firstChildPos: -5,
      child: Image(image: AssetImage('assets/images/katze_main.png')),
      nodes: [
        TreeNode(
          child: Image(image: AssetImage('assets/images/katze_main.png')),
          nodes: [],
        ),
      ],
    ),
    TreeNode(
      firstChildPos: 31,
      child: Image(image: AssetImage('assets/images/katze_main.png')),
      nodes: [
        TreeNode(
          child: Image(image: AssetImage('assets/images/katze_main.png')),
          nodes: [],
        ),
      ],
    ),
    TreeNode(
      firstChildPos: 23,
      child: Image(image: AssetImage('assets/images/katze_main.png')),
      nodes: [
        TreeNode(
          child: Image(image: AssetImage('assets/images/katze_main.png')),
          nodes: [
            TreeNode(
              child: Image(image: AssetImage('assets/images/katze_main.png')),
              nodes: [
                TreeNode(
                  child:
                      Image(image: AssetImage('assets/images/katze_main.png')),
                  nodes: [],
                ),
              ],
            ),
            TreeNode(
              child: Image(image: AssetImage('assets/images/katze_main.png')),
              nodes: [
                TreeNode(
                  child:
                      Image(image: AssetImage('assets/images/katze_main.png')),
                  nodes: [],
                ),
              ],
            ),
            TreeNode(
              child: Image(image: AssetImage('assets/images/katze_main.png')),
              nodes: [
                TreeNode(
                  child:
                      Image(image: AssetImage('assets/images/katze_main.png')),
                  nodes: [],
                ),
              ],
            ),
          ],
        ),
      ],
    ),
    TreeNode(
      firstChildPos: -13,
      child: Image(image: AssetImage('assets/images/katze_main.png')),
      nodes: [
        TreeNode(
          child: Image(image: AssetImage('assets/images/katze_main.png')),
          nodes: [
            TreeNode(
              child: Image(image: AssetImage('assets/images/katze_main.png')),
              nodes: [
                TreeNode(
                  child:
                      Image(image: AssetImage('assets/images/katze_main.png')),
                  nodes: [],
                ),
              ],
            ),
            TreeNode(
              child: Image(image: AssetImage('assets/images/katze_main.png')),
              nodes: [
                TreeNode(
                  child:
                      Image(image: AssetImage('assets/images/katze_main.png')),
                  nodes: [],
                ),
              ],
            ),
            TreeNode(
              child: Image(image: AssetImage('assets/images/katze_main.png')),
              nodes: [
                TreeNode(
                  child:
                      Image(image: AssetImage('assets/images/katze_main.png')),
                  nodes: [],
                ),
              ],
            ),
          ],
        ),
      ],
    ),
    TreeNode(
      firstChildPos: 40,
      child: Image(image: AssetImage('assets/images/katze_main.png')),
      nodes: [
        TreeNode(
          child: Image(image: AssetImage('assets/images/katze_main.png')),
          nodes: [
            TreeNode(
              child: Image(image: AssetImage('assets/images/katze_main.png')),
              nodes: [
                TreeNode(
                  child:
                      Image(image: AssetImage('assets/images/katze_main.png')),
                  nodes: [],
                ),
              ],
            ),
            TreeNode(
              child: Image(image: AssetImage('assets/images/katze_main.png')),
              nodes: [
                TreeNode(
                  child:
                      Image(image: AssetImage('assets/images/katze_main.png')),
                  nodes: [],
                ),
              ],
            ),
            TreeNode(
              child: Image(image: AssetImage('assets/images/katze_main.png')),
              nodes: [
                TreeNode(
                  child:
                      Image(image: AssetImage('assets/images/katze_main.png')),
                  nodes: [],
                ),
              ],
            ),
          ],
        ),
      ],
    ),
    TreeNode(
      firstChildPos: 49,
      child: Image(image: AssetImage('assets/images/katze_main.png')),
      nodes: [
        TreeNode(
          child: Image(image: AssetImage('assets/images/katze_main.png')),
          nodes: [],
        ),
      ],
    ),*/
  ],
};

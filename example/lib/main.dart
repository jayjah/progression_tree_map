import 'package:flutter/material.dart';
import 'package:progression_tree_map/progression_tree_map.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: ProgressionTreeHome(),
    );
  }
}

class ProgressionTreeHome extends StatelessWidget {
  ProgressionTreeHome({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Progression TreeMap Demo",
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ..._titleAndMapWidgets(
                title: "Colored Nodes & Outlines",
                map: ProgressionTreeMap(
                  makeLineLighter: (TreeNode lineFrom, TreeNode lineTo) {
                    if (lineFrom.id == 'main') return true;
                    return false;
                  },
                  treeNodes: _tNodeColoredNodesAndOutlines,
                  circleBoundaryColor: Colors.grey.shade300,
                  circleBoundaryShade: false,
                  nodeSeparationAngleFac: 1.3,
                  globalNodeSize: 20,
                  centerNodeSize: 40,
                  circleBoundaryStrokeWidth: 1.5,
                  linesStrokeWidth: 2,
                  linesStrokeColor: Colors.blueAccent,
                  nodeDecoration: BoxDecoration(
                      shape: BoxShape.circle, color: Colors.blueAccent),
                )),
            ..._titleAndMapWidgets(
                title: "Colored Nodes & Icons",
                map: ProgressionTreeMap(
                  makeLineLighter: (TreeNode lineFrom, TreeNode lineTo) {
                    if (lineFrom.id == 'main') return true;
                    return false;
                  },
                  treeNodes: _tNodeColoredNodesAndIcons,
                  circleBoundaryPaintingStyle: PaintingStyle.fill,
                  circleBoundaryColor: Colors.deepPurpleAccent,
                  nodePlacement: NodesPlacement.border,
                  nodeSeparationAngleFac: 3,
                  globalNodeSize: 30,
                  centerNodeSize: 60,
                  linesStartFromOrigin: true,
                  linesStrokeWidth: 2,
                  linesStrokeColor: Colors.cyanAccent,
                  nodeDecoration: BoxDecoration(
                      shape: BoxShape.circle, color: Colors.cyanAccent),
                )),
            ..._titleAndMapWidgets(
                title: "Glowing Nodes & Background Text",
                map: ProgressionTreeMap(
                  makeLineLighter: (TreeNode lineFrom, TreeNode lineTo) {
                    if (lineFrom.id == 'main') return true;
                    return false;
                  },
                  treeNodes: _tNodeGlowingNodesBackgroundTexts,
                  circleBoundaryPaintingStyle: PaintingStyle.fill,
                  circleBoundaryColor: Colors.red,
                  nodePlacement: NodesPlacement.centerOut,
                  nodeSeparationAngleFac: 1.2,
                  globalNodeSize: 20,
                  centerNodeSize: 40,
                  linesStrokeWidth: 3,
                  nodeDecoration: BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: RadialGradient(
                        colors: [Colors.white, Colors.white30],
                      )),
                )),
            ..._titleAndMapWidgets(
                title: "Collection  & Ui Items",
                map: ProgressionTreeMap(
                  makeLineLighter: (TreeNode lineFrom, TreeNode lineTo) {
                    if (lineFrom.id == 'main') return true;
                    return false;
                  },
                  treeNodes: _collectionAndUiItems,
                  circleBoundaryPaintingStyle: PaintingStyle.fill,
                  circleBoundaryColor: Colors.deepOrangeAccent,
                  nodePlacement: NodesPlacement.centerIn,
                  nodeSeparationAngleFac: 1.3,
                  centerNodeSize: 60,
                  linesStartFromOrigin: false,
                  linesStrokeWidth: 3,
                  linesStrokeColor: Colors.white10,
                )),
          ],
        ),
      ),
    );
  }

  Map<TreeNode?, List<TreeNode>> get _tNodeColoredNodesAndOutlines => {
        TreeNode(): [
          TreeNode(
              partnerWidget: Text(
                "HEALTH",
                style: TextStyle(
                    color: Colors.grey,
                    fontWeight: FontWeight.w400,
                    fontSize: 12),
              ),
              partnerWidgetOffset: Offset(0, 20),
              popUpWidget: Column(
                children: [
                  Text("Widget title is here"),
                ],
              ),
              decoration: BoxDecoration(color: Colors.red),
              nodes: [
                TreeNode(nodes: [
                  TreeNode(size: 15),
                  TreeNode(
                      nodes: [
                        TreeNode(
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.blue.shade300))
                      ],
                      decoration: BoxDecoration(
                          shape: BoxShape.circle, color: Colors.blue.shade300)),
                  TreeNode()
                ])
              ]),
          TreeNode(size: 15, nodes: [
            TreeNode(nodes: [TreeNode()]),
            TreeNode(nodes: [
              TreeNode(
                  size: 15,
                  decoration: BoxDecoration(
                      shape: BoxShape.circle, color: Colors.blue.shade300))
            ])
          ]),
          TreeNode(
              partnerWidget: Text(
                "SLEEP",
                style: TextStyle(
                    color: Colors.grey,
                    fontWeight: FontWeight.w400,
                    fontSize: 12),
              ),
              partnerWidgetOffset: Offset(0, 20),
              nodes: [
                TreeNode(size: 15, nodes: [
                  TreeNode(nodes: [TreeNode(nodes: [])]),
                  TreeNode(),
                  TreeNode(nodes: [
                    TreeNode(
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.blue.shade300))
                  ], size: 15),
                  TreeNode(size: 15)
                ])
              ]),
          TreeNode(
              partnerWidget: Text(
                "PRODUCTIVITY",
                style: TextStyle(
                    color: Colors.grey,
                    fontWeight: FontWeight.w400,
                    fontSize: 12),
              ),
              partnerWidgetOffset: Offset(-70, 20),
              nodes: [
                TreeNode(nodes: [
                  TreeNode(nodes: [
                    TreeNode(
                        nodes: [],
                        size: 10,
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.blue.shade300))
                  ]),
                  TreeNode()
                ])
              ]),
          TreeNode(
              partnerWidget: Text(
                "MENTALITY ",
                style: TextStyle(
                    color: Colors.grey,
                    fontWeight: FontWeight.w400,
                    fontSize: 12),
              ),
              partnerWidgetOffset: Offset(20, -20),
              size: 15,
              nodes: [
                TreeNode(nodes: [TreeNode()])
              ]),
        ]
      };

  Map<TreeNode?, List<TreeNode>> get _tNodeColoredNodesAndIcons => {
        TreeNode(
            child: Icon(
          Icons.restaurant_menu,
          color: Colors.black,
          size: 32,
        )): [
          TreeNode(child: Icon(Icons.local_pizza_outlined), nodes: [
            TreeNode(
              child: Icon(Icons.lunch_dining_rounded),
            ),
            TreeNode(
              child: Icon(Icons.ramen_dining),
            )
          ]),
          TreeNode(child: Icon(Icons.liquor_outlined), nodes: [
            TreeNode(
                child: Icon(Icons.nightlife),
                partnerWidget: Text(
                  "DRINKS",
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w400,
                      fontSize: 14),
                ),
                partnerWidgetOffset: Offset(-24, -36))
          ]),
          TreeNode(child: Icon(Icons.cake_outlined), nodes: [
            TreeNode(child: Icon(Icons.microwave_outlined), nodes: [
              TreeNode(
                size: 32,
                child: Icon(Icons.add),
                partnerWidget: Text(
                  "ADD MEAL",
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w400,
                      fontSize: 14),
                ),
              )
            ])
          ])
        ]
      };

  Map<TreeNode?, List<TreeNode>> get _tNodeGlowingNodesBackgroundTexts => {
        TreeNode(): [
          TreeNode(nodes: [
            TreeNode(),
            TreeNode(
                size: 30,
                child: Text(
                  'A',
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 12,
                      fontWeight: FontWeight.bold),
                ),
                nodes: [
                  TreeNode(
                      nodes: [TreeNode(), TreeNode(), TreeNode(), TreeNode()])
                ]),
            TreeNode(nodes: [TreeNode(), TreeNode()]),
          ]),
          TreeNode(
              partnerWidgetOffset: Offset(14, 18),
              partnerWidget: Text(
                "GOING UP",
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                    letterSpacing: 0,
                    color: Colors.black),
              ),
              nodes: [
                TreeNode(nodes: [
                  TreeNode(nodes: [
                    TreeNode(nodes: []),
                  ]),
                  TreeNode(),
                ]),
              ]),
          TreeNode(nodes: [
            TreeNode(),
            TreeNode(nodes: [
              TreeNode(),
              TreeNode(),
              TreeNode(nodes: [
                TreeNode(nodes: [
                  TreeNode(),
                ]),
              ]),
            ]),
          ]),
          TreeNode(
              partnerWidgetOffset: Offset(-120, -20),
              partnerWidget: Text(
                "COMING DOWN",
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                    letterSpacing: 0,
                    color: Colors.black),
              ),
              nodes: [TreeNode()]),
        ]
      };

  Map<TreeNode?, List<TreeNode>> get _collectionAndUiItems => {
        TreeNode(
            decoration: BoxDecoration(),
            child: Image.asset("assets/images/sun.png")): [
          TreeNode(
              decoration: BoxDecoration(color: Colors.white30),
              size: 60,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 4),
                child: Text(
                  'School',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                      fontWeight: FontWeight.bold),
                ),
              ),
              nodes: [
                TreeNode(
                  decoration: BoxDecoration(color: Colors.black12),
                  size: 60,
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 4),
                    child: Text(
                      'Book',
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 12,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                )
              ]),
          TreeNode(
              decoration: BoxDecoration(color: Colors.white30),
              size: 60,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 4),
                child: Text(
                  'Animals',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                      fontWeight: FontWeight.bold),
                ),
              ),
              nodes: [
                TreeNode(
                  decoration: BoxDecoration(color: Colors.black12),
                  size: 60,
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 4),
                    child: Text(
                      'Cat',
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                TreeNode(
                  decoration: BoxDecoration(color: Colors.black12),
                  size: 60,
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 4),
                    child: Text(
                      'Dog',
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ]),
          TreeNode(
              decoration: BoxDecoration(color: Colors.white30),
              size: 60,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 4),
                child: Text(
                  'Tech',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                      fontWeight: FontWeight.bold),
                ),
              ),
              nodes: [
                TreeNode(
                  decoration: BoxDecoration(color: Colors.black12),
                  size: 60,
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 4),
                    child: Text(
                      'Phone',
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 12,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                TreeNode(
                  decoration: BoxDecoration(color: Colors.black12),
                  size: 60,
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 4),
                    child: Text(
                      'Radio',
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 12,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                TreeNode(
                  decoration: BoxDecoration(color: Colors.black12),
                  size: 60,
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 4),
                    child: Text(
                      'TV',
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 12,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ]),
          TreeNode(
              decoration: BoxDecoration(color: Colors.white30),
              size: 60,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 4),
                child: Text(
                  'Cloth',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                      fontWeight: FontWeight.bold),
                ),
              ),
              nodes: [
                TreeNode(
                  decoration: BoxDecoration(color: Colors.black12),
                  size: 60,
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 4),
                    child: Text(
                      'Jacket',
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 12,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ]),
          TreeNode(
              decoration: BoxDecoration(color: Colors.white30),
              size: 60,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 4),
                child: Text(
                  'Weather',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                      fontWeight: FontWeight.bold),
                ),
              ),
              nodes: [
                TreeNode(
                  decoration: BoxDecoration(color: Colors.black12),
                  size: 60,
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 4),
                    child: Text(
                      'Rainy',
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 12,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                TreeNode(
                  decoration: BoxDecoration(color: Colors.black12),
                  size: 60,
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 4),
                    child: Text(
                      'Sunny',
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 12,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                TreeNode(
                  decoration: BoxDecoration(color: Colors.black12),
                  size: 60,
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 4),
                    child: Text(
                      'Windy',
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 12,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ]),
        ]
      };

  List<Widget> _titleAndMapWidgets(
          {required String title, required Widget map}) =>
      [
        Container(
          alignment: Alignment.centerLeft,
          padding: EdgeInsets.symmetric(vertical: 18),
          child: Text(
            title,
            maxLines: 1,
            style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w500, //
                letterSpacing: 0,
                color: Colors.black),
          ),
        ),
        SizedBox(
          width: 400,
          height: 400,
          child: map,
        ),
        SizedBox(
          height: 48,
        ),
      ];
}

import 'package:flutter/material.dart';
import 'package:progression_tree_map/src/extensions/colors.dart';

import '../classes/tree_node.dart';

typedef MakeLineLighter = bool Function(TreeNode lineFrom, TreeNode lineTo);

class ConnectingLine extends CustomPainter {
  ConnectingLine({
    required this.uiNodesPrep,
    required this.color,
    required this.strokeWidth,
    required this.startFromCenter,
    required this.makeLineLighter,
  });

  final List<Map<TreeNode, List<TreeNode>>> uiNodesPrep;
  final double strokeWidth;
  final Color color;
  final bool startFromCenter;
  final MakeLineLighter makeLineLighter;

  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..color = color
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke;
    final Paint lightPainter = Paint()
      ..color = color.tintOrShade(25, darken: false)
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke;

    final Offset center = size.center(Offset.zero);

    for (Map<TreeNode, List<TreeNode>> uiN in uiNodesPrep) {
      final Path path = Path();
      TreeNode keyNode = uiN.keys.first;
      if (startFromCenter && keyNode.depth == 1) {
        path.moveTo(center.dx, center.dy);
        path.lineTo(keyNode.offset.dx + (keyNode.size!) / 2,
            keyNode.offset.dy + (keyNode.size!) / 2);
        if (makeLineLighter(TreeNode(id: 'main'), keyNode)) {
          canvas.drawPath(
            path,
            lightPainter,
          );
        } else
          canvas.drawPath(path, paint);
      }
      if (uiN.values.first.isNotEmpty) {
        final Path path = Path();

        for (TreeNode tNode in uiN.values.first) {
          path.moveTo(keyNode.offset.dx + (keyNode.size!) / 2,
              keyNode.offset.dy + (keyNode.size!) / 2);
          TreeNode valueNode = tNode;
          path.lineTo(valueNode.offset.dx + (valueNode.size!) / 2,
              valueNode.offset.dy + (valueNode.size!) / 2);
          if (makeLineLighter(keyNode, valueNode)) {
            canvas.drawPath(path, lightPainter);
          } else
            canvas.drawPath(path, paint);
        }
      } /*else {
        canvas.drawPath(path, paint);
      }*/
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}

import 'package:flutter/material.dart';

/// This is the individual node that forms the tree
class TreeNode {
  final bool useCustomAngleCalculation;
  final String? uniqueId;
  final String? id;
  final bool combiner;
  final String? name;
  final String? content;
  final Widget? icon;

  /// The [Widget] the node contains
  final Widget? child;

  /// The children of the node
  final List<TreeNode> nodes;

  /// The offset of the node
  Offset offset;

  /// The [Size] of the node
  final double? size;

  /// The angle to rotate the node
  double angle;

  /// The position of the node in relation to the center node
  final int depth;

  final int? firstChildPos;
  final int? childPos;

  /// Configures the node decoration
  final BoxDecoration? decoration;

  /// [Widget] that runs alongside the node
  final Widget? partnerWidget;

  /// The [Offset] of the [Widget] that runs alongside the node
  final Offset? partnerWidgetOffset;

  /// The popup widget to show when the node is tapped
  final Widget? popUpWidget;

  TreeNode({
    this.child,
    this.nodes = const [],
    this.offset = Offset.zero,
    this.angle = 0,
    this.depth = 0,
    this.decoration,
    this.partnerWidget,
    this.partnerWidgetOffset,
    this.size,
    this.firstChildPos,
    this.popUpWidget,
    this.useCustomAngleCalculation = true,
    this.name,
    this.content,
    this.icon,
    this.id,
    this.combiner = false,
    this.childPos,
    this.uniqueId,
  });

  TreeNode updateWith({
    Offset? offset,
    double? angle,
  }) {
    if (angle != null) this.angle = angle;
    if (offset != null) this.offset = offset;
    return this;
  }

  TreeNode copyWith({
    Widget? child,
    List<TreeNode>? nodes,
    Offset? offset,
    String? id,
    int? depth,
    double? size,
    double? angle,
    Widget? partnerWidget,
    Offset? partnerWidgetOffset,
    BoxDecoration? decoration,
    int? firstChildPos,
    Widget? popUpWidget,
    Widget? icon,
    String? name,
    String? content,
    bool? combiner,
    bool? useCustomAngleCalculation,
    int? childPos,
    String? uniqueId,
  }) {
    return TreeNode(
      useCustomAngleCalculation:
          useCustomAngleCalculation ?? this.useCustomAngleCalculation,
      child: child ?? this.child,
      nodes: nodes ?? this.nodes,
      depth: depth ?? this.depth,
      offset: offset ?? this.offset,
      size: size ?? this.size,
      partnerWidget: partnerWidget ?? this.partnerWidget,
      partnerWidgetOffset: partnerWidgetOffset ?? this.partnerWidgetOffset,
      angle: angle ?? this.angle,
      decoration: decoration ?? this.decoration,
      firstChildPos: firstChildPos ?? this.firstChildPos,
      popUpWidget: popUpWidget ?? this.popUpWidget,
      name: name ?? this.name,
      content: content ?? this.content,
      icon: icon ?? this.icon,
      combiner: combiner ?? this.combiner,
      id: id ?? this.id,
      childPos: childPos ?? this.childPos,
      uniqueId: uniqueId ?? this.uniqueId,
    );
  }

  @override
  String toString() {
    return 'TreeNode{id: $id, combiner: $combiner, name: $name, content: $content, angle: $angle, offset: $offset}';
  }
}

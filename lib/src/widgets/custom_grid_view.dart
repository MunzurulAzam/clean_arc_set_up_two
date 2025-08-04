import 'package:flutter/material.dart';

class CustomGridView extends StatelessWidget {
  final int itemCount;
  final IndexedWidgetBuilder itemBuilder;
  final double cellHeight;
  final double cellWidth;
  final int crossAxisCount;
  final double crossAxisSpacing;
  final double mainAxisSpacing;
  final ScrollController? controller;
  final ScrollPhysics? physics;
  final bool shrinkWrap;
  final EdgeInsetsGeometry padding;
  final bool primary;
  final Axis scrollDirection;
  final bool reverse;

  CustomGridView({
    required this.itemCount,
    required this.itemBuilder,
    required this.cellHeight,
    required this.cellWidth,
    required this.crossAxisCount,
    this.crossAxisSpacing = 0.0,
    this.mainAxisSpacing = 0.0,
    this.controller,
    this.physics,
    this.shrinkWrap = false,
    this.padding = EdgeInsets.zero,
    this.primary = false,
    this.scrollDirection = Axis.vertical,
    this.reverse = false,
  });

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      controller: controller,
      physics: physics,
      shrinkWrap: shrinkWrap,
      padding: padding,
      primary: primary,
      scrollDirection: scrollDirection,
      reverse: reverse,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: crossAxisCount,
        crossAxisSpacing: crossAxisSpacing,
        mainAxisSpacing: mainAxisSpacing,
        childAspectRatio: cellWidth / cellHeight,
      ),
      itemCount: itemCount,
      itemBuilder: itemBuilder,
    );
  }
}
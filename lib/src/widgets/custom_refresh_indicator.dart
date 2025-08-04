import 'package:flutter/material.dart';

class CustomRefreshIndicator extends StatelessWidget {
  const CustomRefreshIndicator({
    super.key,
    this.onRefresh,
    this.controller,
    required this.child,
  });

  final Widget child;
  final ScrollController? controller;
  final Future<void> Function()? onRefresh;

  Widget c(Widget c, {double height = 0}) {
    return SingleChildScrollView(
      controller: controller,
      child: Container(
        width: double.infinity,
        constraints: BoxConstraints(minHeight: height),
        child: child,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (onRefresh == null) return c(child);

    return LayoutBuilder(
      builder: (context, box) {
        return RefreshIndicator(     
          onRefresh: onRefresh!,
          child: c(child, height: box.maxHeight + 0.001),
        );
      },
    );
  }
}

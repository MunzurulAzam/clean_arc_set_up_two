import 'package:loanapp/core/utils/size_config.dart';
import 'package:flutter/material.dart';

class CustomDropdown<T> extends StatelessWidget {
  final int initialValue;
  final List<T> selectionList;
  final String tooltip;
  final double elevation;
  final BoxConstraints? mainConstraints;
  final EdgeInsetsGeometry? mainPadding;
  final EdgeInsetsGeometry? containPadding;
  final Widget? child;
  final PopupMenuPosition position;

  final Widget Function(int index, T item) itemBuilder;
  final void Function(int)? onSelected;
  const CustomDropdown({
    super.key,
    this.initialValue = 0,
    required this.selectionList,
    this.tooltip = "",
    this.elevation = 2,
    this.mainConstraints,
    this.mainPadding,
    this.containPadding,
    this.child,
    required this.itemBuilder,
    this.onSelected,
    this.position = PopupMenuPosition.under,
  });

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<int>(
      position: position,
      initialValue: initialValue,
      onSelected: onSelected,
      elevation: elevation,
      tooltip: tooltip,
      padding: EdgeInsets.zero,
      surfaceTintColor: Colors.transparent,
      itemBuilder: (BuildContext context) {
        return [
          for (int i = 0; i < selectionList.length; i++)
            PopupMenuItem<int>(
              value: i,
              padding: EdgeInsets.zero,
              height: 0,
              child: Container(
                width: double.infinity,
                padding: containPadding ?? EdgeInsets.symmetric(horizontal: getScreenWidth(24.0) / 4),
                color: Theme.of(context).colorScheme.background,
                child: itemBuilder(i, selectionList.elementAt(i)),
              ),
            )
        ];
      },
      child: child == null
          ? null
          : Container(
              constraints: mainConstraints ?? BoxConstraints(minWidth: getScreenWidth(24.0) * 3),
              padding: mainPadding ?? EdgeInsets.symmetric(vertical: getScreenHeight(24.0), horizontal: getScreenWidth(24.0) / 2),
              child: child,
            ),
    );
  }
}

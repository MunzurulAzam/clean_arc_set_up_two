import 'package:flutter/material.dart';
import 'package:loanapp/core/utils/size_config.dart';

class CustomListModal<T> extends StatelessWidget {
  final List<T> items;
  final String Function(T) titleBuilder;
  final Function(T) onItemSelected;
  final EdgeInsetsGeometry? padding;

  const CustomListModal({
    super.key,
    required this.items,
    required this.titleBuilder,
    required this.onItemSelected,
    this.padding,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding ?? EdgeInsets.all(getScreenWidth(16)),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: items.map((item) {
            return ListTile(
              title: Text(titleBuilder(item)),
              onTap: () {
                onItemSelected(item);
                Navigator.pop(context);
              },
            );
          }).toList(),
        ),
      ),
    );
  }
}

// Usage function with generics
void showGenericListModal<T>({
  required BuildContext context,
  required List<T> items,
  required String Function(T) titleBuilder,
  required Function(T) onItemSelected,
  EdgeInsetsGeometry? padding,
}) {
  showModalBottomSheet(
    context: context,
    builder: (context) => CustomListModal<T>(
      items: items,
      titleBuilder: titleBuilder,
      onItemSelected: onItemSelected,
      padding: padding,
    ),
  );
}
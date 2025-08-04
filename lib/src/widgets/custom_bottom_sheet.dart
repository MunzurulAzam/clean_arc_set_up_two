import 'package:flutter/material.dart';

Future customBottomSheet({
 required BuildContext context,
  required Widget child,
  ShapeBorder? shape,
  Color? backgroundColor,
  bool isDismissible = true,
}) {
  return showModalBottomSheet<void>(
    shape: shape ??
        RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(6),
            topRight: Radius.circular(6),
          ),
        ),
    backgroundColor: backgroundColor,
    clipBehavior: Clip.antiAlias,
    context: context,
    isDismissible: isDismissible,
    isScrollControlled: true,
    builder: (BuildContext context) {
      return child;
    },
  );
}

import 'package:loanapp/core/constants/colors/app_colors.dart';
import 'package:loanapp/core/utils/size_config.dart';
import 'package:loanapp/src/widgets/common/custom_drop_down_menu.dart';

import 'package:flutter/material.dart';

class DropdownMenue extends StatelessWidget {
  final List<String> items;
  final int initialValue;
  final String? selectedValue;
  final void Function(int)? onChange;
  final Widget? child;
  final EdgeInsetsGeometry? padding;
  final TextStyle? textStyle;
  final double? boderWidth;

  const DropdownMenue(
      {Key? key,
      required this.items,
      this.selectedValue,
      this.onChange,
      required this.initialValue,
      this.child,
      this.padding,
      this.textStyle,
      this.boderWidth})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    // If your screen width and height functions are part of a class, ensure to include that.
    // For example: screenSize.getScreenWidth(14.0) if it's in a class called ScreenSize.

    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(getBorderRadius(8)),
        border: Border.all(color: AppColors.kGrayIconColor.withOpacity(0.3), width: boderWidth ?? 1.0),
      ),
      child: CustomDropdown<String>(
        initialValue: initialValue,
        selectionList: items,
        tooltip: 'Select an option',
        elevation: 4,
        mainConstraints: BoxConstraints(minWidth: getScreenWidth(40)),
        mainPadding: padding ?? EdgeInsets.symmetric(horizontal: getScreenHeight(10), vertical: getScreenHeight(10)),
        itemBuilder: (index, item) {
          return Padding(
            padding: EdgeInsets.symmetric(vertical: getScreenHeight(13), horizontal: getScreenWidth(10)),
            child: Text(
              item,
              style: textStyle,
            ),
          );
        },
        onSelected: onChange,
        // containPadding: EdgeInsets.symmetric(horizontal: getScreenWidth(50)),
        child: child,
      ),
    );
  }
}

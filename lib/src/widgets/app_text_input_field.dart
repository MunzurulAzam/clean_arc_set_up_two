import 'package:flutter/material.dart';
import 'package:loanapp/core/constants/colors/app_colors.dart';
import 'package:loanapp/core/utils/size_config.dart';
import 'package:loanapp/src/widgets/common/custom_text_from_field.dart';



class AppInputTextField extends StatelessWidget {
  const AppInputTextField({
    super.key,
    required this.hintText,
    this.prefixIcon,
    this.textEditingController,
    this.errorBuilder,
    this.focusNode,
    this.keyboardType,
    this.validator,
    this.labelText,
    this.onChanged,
    this.obscureText = false,
    this.suffixIcon,
    this.maxLines = 1,
    this.onChangedProcessing,
    this.initialValue,
    this.errorText,
    this.fillColor,
  });

  final String hintText;
  final Widget? prefixIcon;
  final TextEditingController? textEditingController;
  final Widget Function(String)? errorBuilder;
  final FocusNode? focusNode;
  final TextInputType? keyboardType;
  final String? Function(String?)? validator;
  final String? labelText;
  final void Function(String)? onChanged;
  final bool obscureText;
  final Widget? suffixIcon;
  final int? maxLines;
  final Future<void>? Function(String)? onChangedProcessing;
  final String? initialValue;
  final String? errorText;
  final Color? fillColor;
  @override
  Widget build(BuildContext context) {
    return CustomTextFormField(
      autofocus: false,
      fillColor: fillColor,
      errorText: errorText,
      initialValue: initialValue,
      onChangedProcessing: onChangedProcessing,
      maxLines: maxLines,
      suffixIcon:suffixIcon ,
      obscureText: obscureText,
      onChanged: onChanged,
      labelText: labelText,
      key: key,
      validator: validator,
      keyboardType: keyboardType ?? TextInputType.text,
      focusNode: focusNode,
      errorBuilder: errorBuilder,
      textEditingController: textEditingController,
      prefixIcon: prefixIcon,
      style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: AppColors.kBlackColor, fontSize: getFontSize(14)),
      cursorColor: AppColors.kPrimaryColor,
      hintText: hintText,
      hintStyle:
          Theme.of(context).textTheme.bodyMedium?.copyWith(color: AppColors.kBlackColor.withValues(alpha: 0.3), fontSize: getFontSize(10)),
      contentPadding: EdgeInsets.symmetric(horizontal: getScreenWidth(10.0), vertical: getScreenHeight(15.0)),
      enableBoderColor: AppColors.kBlackColor.withValues(alpha: 0.3),
      focusBoderColor: AppColors.kPrimaryColor,
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(getBorderRadius(10)),
      ),
      borderRadius: BorderRadius.circular(getBorderRadius(10)),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(getBorderRadius(10)),
      ),
    );
  }
}

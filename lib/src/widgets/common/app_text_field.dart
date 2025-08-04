import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:loanapp/core/constants/colors/app_colors.dart';
import 'package:loanapp/core/utils/size_config.dart';

class CustomTextField extends StatefulWidget {
  final TextEditingController controller;
  final String label;
  final IconData icon;
  final int maxLines;
  final TextInputType? keyboardType;
  final List<TextInputFormatter>? inputFormatters;
  final String? Function(String?)? validator;
  final int? maxLength;
  final void Function(String)? onChanged;
  final void Function(String)? onProcessing;
  final Duration debounceDuration;

  const CustomTextField({
    super.key,
    required this.controller,
    required this.label,
    required this.icon,
    this.maxLines = 1,
    this.keyboardType,
    this.inputFormatters,
    this.validator,
    this.maxLength,
    this.onChanged,
    this.onProcessing,
    this.debounceDuration = const Duration(milliseconds: 500),
  });

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  Timer? _debounce;

  @override
  void dispose() {
    _debounce?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onChanged: (String value) {
        widget.onChanged?.call(value);

        if (_debounce?.isActive ?? false) {
          _debounce!.cancel();
        }
        _debounce = Timer(widget.debounceDuration, () {
          widget.onProcessing?.call(value);
        });
      },
      controller: widget.controller,
      maxLines: widget.maxLines,
      keyboardType: widget.keyboardType,
      inputFormatters: widget.inputFormatters,
      maxLength: widget.maxLength,
      validator: widget.validator,
      decoration: InputDecoration(
        labelText: widget.label,
        prefixIcon: Icon(widget.icon, color: AppColors.kAccentColor),
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(getBorderRadius(12)),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(getBorderRadius(12)),
          borderSide: BorderSide(
            color: AppColors.kPrimaryColor,
            width: getScreenWidth(2),
          ),
        ),
        contentPadding: EdgeInsets.symmetric(
          vertical: getScreenHeight(15),
          horizontal: getScreenWidth(20),
        ),
        floatingLabelBehavior: FloatingLabelBehavior.never,
      ),
    );
  }
}
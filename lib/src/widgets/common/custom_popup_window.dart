import 'package:loanapp/core/utils/size_config.dart';
import 'package:loanapp/src/widgets/custom_animated_size_widget.dart';
import 'package:flutter/material.dart';

typedef RetailerSelectedCallback = void Function(
    String retailerName, String? shopName, int? retailerId); //?............................. only for this project modification

class CustomPopUpWindow extends StatelessWidget {
  final Widget? headerAction;
  final Widget? title;
  final Widget? child;
  final Widget? footer;
  final EdgeInsetsGeometry padding;
  final CrossAxisAlignment crossAxisAlignment;
  final double indentIndex;
  final Color? backgroundColor;
  final RetailerSelectedCallback? onRetailerSelected;
  final double? maxHeight; //?>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>for define height
  const CustomPopUpWindow({
    super.key,
    this.child,
    this.headerAction,
    this.title,
    this.crossAxisAlignment = CrossAxisAlignment.start,
    this.footer,
    this.padding = const EdgeInsets.all(0),
    this.indentIndex = 0,
    this.onRetailerSelected,
    this.backgroundColor,
    this.maxHeight,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      insetPadding: EdgeInsets.zero,
      elevation: 0,
      backgroundColor: Colors.transparent,
      child: Container(
        constraints: BoxConstraints(maxWidth: getScreenWidth(400)),
        child: Padding(
          padding: padding,
          child: Padding(
            padding: EdgeInsets.all(24 * indentIndex),
            child: Container(
              clipBehavior: Clip.antiAlias,
              margin: EdgeInsets.all(24), //?.......................default value is 24.sp
              decoration:
                  BoxDecoration(color: backgroundColor ?? Theme.of(context).canvasColor, borderRadius: BorderRadius.circular(getBorderRadius(24))),
              constraints: BoxConstraints(maxHeight: MediaQuery.of(context).size.height),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    if (headerAction != null) headerAction!,
                    Container(
                      padding: EdgeInsets.symmetric(vertical: getScreenHeight(24)),
                      child: SingleChildScrollView(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: crossAxisAlignment,
                          children: [
                            if (title != null) Padding(padding: EdgeInsets.symmetric(horizontal: getScreenWidth(24)), child: title!),
                            if (title != null) SizedBox(height: getScreenHeight(24)),
                            CustomAnimatedSize(
                              widthFactor: 1,
                              alignment: Alignment.topCenter,
                              child: Container(
                                constraints:
                                    BoxConstraints(maxHeight: maxHeight ?? (MediaQuery.of(context).size.height / 2) - (getScreenHeight(24) * 2)),
                                child: SingleChildScrollView(
                                  child: Padding(padding: EdgeInsets.symmetric(horizontal: getScreenWidth(24)), child: child),
                                ),
                              ),
                            ),
                            if (footer != null) SizedBox(height: getScreenHeight(24)),
                            if (footer != null)
                              Container(
                                constraints: BoxConstraints(maxHeight: (MediaQuery.of(context).size.height / 4)),
                                child: SingleChildScrollView(
                                  child: Padding(padding: EdgeInsets.symmetric(horizontal: getScreenWidth(24)), child: footer),
                                ),
                              ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

import 'package:loanapp/core/utils/size_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../constants/colors/app_colors.dart';

ThemeData darkTheme = ThemeData(
  fontFamily: 'Poppins',
  appBarTheme: AppBarTheme(
    toolbarHeight: getScreenHeight(65),
    titleTextStyle: const TextStyle(
      color: AppColors.kWhiteColor,
      fontSize: 18,
      fontWeight: FontWeight.w600,
    ),
    backgroundColor: AppColors.kCardDarkColor,
    elevation: 0.0,
    iconTheme: const IconThemeData(
      color: AppColors.kWhiteColor,
    ),
    actionsIconTheme: const IconThemeData(
      color: AppColors.kBlackColor,
    ),
    centerTitle: false,
    systemOverlayStyle: const SystemUiOverlayStyle(
      statusBarColor: AppColors.kCardDarkColor,
      statusBarIconBrightness: Brightness.light,
      systemNavigationBarIconBrightness: Brightness.light,
      statusBarBrightness: Brightness.dark,
      systemNavigationBarColor: AppColors.kWhiteColor,
      systemNavigationBarDividerColor: AppColors.kWhiteColor,
    ),
  ),
  iconTheme: IconThemeData(
    color: AppColors.kWhiteColor,
    size: getBorderRadius(24),
  ),
  primaryColor: AppColors.kPrimaryColor,
  secondaryHeaderColor: AppColors.kSecondaryColor,
  disabledColor: const Color(0xffa2a7ad),
  scaffoldBackgroundColor: AppColors.kBgDarkColor,
  brightness: Brightness.dark,
  hintColor: const Color(0xFFbebebe),
  cardColor: AppColors.kCardDarkColor,
  cardTheme: CardTheme(
    clipBehavior: Clip.antiAlias,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(getBorderRadius(12)),
    ),
    color: AppColors.kCardDarkColor,
    margin: EdgeInsets.zero,
  ),
  inputDecorationTheme: InputDecorationTheme(
    border: OutlineInputBorder(
      borderSide: const BorderSide(color: AppColors.dark40),
      borderRadius: BorderRadius.circular(8.0),
    ),
    enabledBorder: OutlineInputBorder(
      borderSide: const BorderSide(color: AppColors.dark40),
      borderRadius: BorderRadius.circular(8.0),
    ),
    focusedBorder: OutlineInputBorder(
      borderSide: const BorderSide(color: AppColors.dark40),
      borderRadius: BorderRadius.circular(8.0),
    ),
    errorBorder: OutlineInputBorder(
      borderSide: const BorderSide(color: AppColors.kErrorColor),
      borderRadius: BorderRadius.circular(8.0),
    ),
    fillColor: AppColors.kBlackColor,
    filled: true,
    contentPadding: EdgeInsets.symmetric(horizontal: getScreenWidth(20), vertical: getScreenHeight(16)),
    suffixIconColor: AppColors.dark20,
    prefixIconColor: AppColors.dark20,
    hintStyle: TextStyle(
      color: AppColors.dark10,
      fontSize: getFontSize(14),
      fontWeight: FontWeight.w400,
    ),
    labelStyle: TextStyle(
      color: AppColors.kWhiteColor,
      fontSize: getFontSize(14),
      fontWeight: FontWeight.w400,
    ),
  ),
  textButtonTheme: TextButtonThemeData(
    style: TextButton.styleFrom(
      foregroundColor: AppColors.kPrimaryColor,
    ),
  ),
  textTheme: TextTheme(
    displayLarge: TextStyle(
      color: AppColors.kWhiteColor,
      fontSize: getFontSize(24),
      fontWeight: FontWeight.w500,
    ),
    displayMedium: TextStyle(
      color: AppColors.kWhiteColor,
      fontSize: getFontSize(20),
      fontWeight: FontWeight.w600,
    ),
    displaySmall: TextStyle(
      color: AppColors.kWhiteColor,
      fontSize: getFontSize(18),
      fontWeight: FontWeight.w600,
    ),
    headlineLarge: TextStyle(
      color: AppColors.kWhiteColor,
      fontSize: getFontSize(18),
      fontWeight: FontWeight.w700,
    ),
    headlineMedium: TextStyle(
      color: AppColors.kWhiteColor,
      fontSize: getFontSize(16),
      fontWeight: FontWeight.w600,
    ),
    headlineSmall: TextStyle(
      color: AppColors.kWhiteColor,
      fontSize: getFontSize(14),
      fontWeight: FontWeight.w500,
    ),
    bodyLarge: TextStyle(
      color: AppColors.kWhiteColor,
      fontSize: getFontSize(16),
      fontWeight: FontWeight.w400,
    ),
    bodyMedium: TextStyle(
      color: AppColors.kWhiteColor,
      fontSize: getFontSize(14),
      fontWeight: FontWeight.w400,
    ),
    bodySmall: TextStyle(
      color: AppColors.kWhiteColor,
      fontSize: getFontSize(12),
      fontWeight: FontWeight.w300,
    ),
    titleLarge: TextStyle(
      color: AppColors.kWhiteColor,
      fontSize: getFontSize(14),
      fontWeight: FontWeight.w500,
    ),
    titleMedium: TextStyle(
      color: AppColors.kWhiteColor,
      fontSize: getFontSize(12),
      fontWeight: FontWeight.w400,
    ),
    titleSmall: TextStyle(
      color: AppColors.kWhiteColor,
      fontSize: getFontSize(10),
      fontWeight: FontWeight.w400,
    ),
    labelSmall: TextStyle(color: AppColors.kWhiteColor, fontSize: getFontSize(12), fontWeight: FontWeight.w400, height: 1.0),
    labelMedium: TextStyle(color: AppColors.kWhiteColor, fontSize: getFontSize(14), fontWeight: FontWeight.w500, height: 1.0),
    labelLarge: TextStyle(color: AppColors.kWhiteColor, fontSize: getFontSize(16), fontWeight: FontWeight.w600, height: 1.0),
  ),
  colorScheme: const ColorScheme.dark(
    primary: AppColors.kPrimaryColor,
    secondary: AppColors.kSecondaryColor,
  ).copyWith(surface: AppColors.kBgDarkColor).copyWith(error: AppColors.kErrorColor),
);

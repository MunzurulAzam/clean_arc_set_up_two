

import 'package:loanapp/src/features/auth/domain/entities/before_login_entity.dart';

class BeforeLogInResponseModel extends BeforeLogInEntity {
  final ResultResponseModel? result;

   BeforeLogInResponseModel({
    this.result,
    int? isProduction,
  }) : super(
          accessToken: result?.accessToken,
          isSuccess: result?.isSuccess,
          errors: result?.errors,
          expireDate: result?.expireDate,
          message: result?.message,
          role: result?.role,
          refreshToken: result?.refreshToken,
          modules: result?.modules,
          menus: result?.menus,
          subMenus: result?.subMenus,
          isProduction: isProduction,
        );

  factory BeforeLogInResponseModel.fromJson(Map<String, dynamic> json) {
    return BeforeLogInResponseModel(
      result: json['result'] != null
          ? ResultResponseModel.fromJson(json['result'])
          : null,
      isProduction: json['isProduction'] as int?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'result': result?.toJson(),
      'isProduction': isProduction,
    };
  }
}

class ResultResponseModel {
  final String? accessToken;
  final bool? isSuccess;
  final dynamic errors;
  final DateTime? expireDate;
  final dynamic message;
  final String? role;
  final String? refreshToken;
  final List<dynamic>? modules;
  final List<dynamic>? menus;
  final List<dynamic>? subMenus;

  ResultResponseModel({
    this.accessToken,
    this.isSuccess,
    this.errors,
    this.expireDate,
    this.message,
    this.role,
    this.refreshToken,
    this.modules,
    this.menus,
    this.subMenus,
  });

  factory ResultResponseModel.fromJson(Map<String, dynamic> json) {
    return ResultResponseModel(
      accessToken: json['accessToken'] as String?,
      isSuccess: json['isSuccess'] as bool?,
      errors: json['errors'],
      expireDate: json['expireDate'] != null
          ? DateTime.parse(json['expireDate'])
          : null,
      message: json['message'],
      role: json['role'] as String?,
      refreshToken: json['refreshToken'] as String?,
      modules: json['modules'] as List<dynamic>?,
      menus: json['menus'] as List<dynamic>?,
      subMenus: json['subMenus'] as List<dynamic>?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'accessToken': accessToken,
      'isSuccess': isSuccess,
      'errors': errors,
      'expireDate': expireDate?.toIso8601String(),
      'message': message,
      'role': role,
      'refreshToken': refreshToken,
      'modules': modules,
      'menus': menus,
      'subMenus': subMenus,
    };
  }
}
import 'package:flutter/foundation.dart';

@immutable
class BeforeLogInEntity {
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
  final int? isProduction;

  const BeforeLogInEntity({
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
    this.isProduction,
  });
}
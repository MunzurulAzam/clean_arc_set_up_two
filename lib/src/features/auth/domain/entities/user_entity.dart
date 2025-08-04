import 'package:flutter/foundation.dart';

@immutable
class UserEntity {
  final bool userExists;
  final String? message;

  const UserEntity({required this.userExists, this.message});
}

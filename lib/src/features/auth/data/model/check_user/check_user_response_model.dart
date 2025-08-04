
import 'package:loanapp/src/features/auth/domain/entities/user_entity.dart';


class CheckUserResponseModel extends UserEntity {
  const CheckUserResponseModel({
    required bool userExists,
    required String? message,
  }) : super(userExists: userExists, message: message);

  factory CheckUserResponseModel.fromJson(Map<String, dynamic> json) {
    return CheckUserResponseModel(
      userExists: json['user_exists'] ?? false,
      message: json['message'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'user_exists': userExists,
      'message': message,
    };
  }
}
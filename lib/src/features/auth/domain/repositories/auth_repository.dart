import 'package:dartz/dartz.dart';
import 'package:loanapp/src/features/auth/domain/entities/before_login_entity.dart';
import '../entities/user_entity.dart';

abstract class AuthRepository {
  Future<Either<String, UserEntity>> checkUser({
    String? token,
    required String phoneNumber,
    required Map<String, String> body,
  });
  //! for log in
    Future<Either<String, BeforeLogInEntity>> logIn({
    String? token,
    required Map<String, String> body,
  });
  //! for sign up
  Future<Either<String, UserEntity>> signUp({
    String? token,
    required Map<String, String> body,
  });
}
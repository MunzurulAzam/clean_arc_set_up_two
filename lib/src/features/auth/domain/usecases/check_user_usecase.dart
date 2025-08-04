import 'package:dartz/dartz.dart';
import 'package:loanapp/src/features/auth/domain/entities/before_login_entity.dart';
import '../entities/user_entity.dart';
import '../repositories/auth_repository.dart';

class CheckUser {
  final AuthRepository repository;

  CheckUser(this.repository);

  Future<Either<String, UserEntity>> call({
    String? token,
    required String phoneNumber,
    required Map<String, String> body,
  }) async {
    return await repository.checkUser(
      token: token,
      phoneNumber: phoneNumber,
      body: body,
    );
  }
  //! for log in
  Future<Either<String, BeforeLogInEntity>> logIn({
    String? token,
    required Map<String, String> body,
  }) async {
    return await repository.logIn(
      token: token,
      body: body,
    );
  }
  //! for sign up
  Future<Either<String, UserEntity>> signUp({
    String? token,
    required Map<String, String> body,
  }) async {
    return await repository.signUp(
      token: token,
      body: body,
    );
  }


}
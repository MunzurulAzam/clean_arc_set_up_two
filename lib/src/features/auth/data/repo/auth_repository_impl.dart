import 'package:dartz/dartz.dart';
import 'package:loanapp/src/features/auth/data/data_source/auth_remote_datasource.dart';
import 'package:loanapp/src/features/auth/domain/entities/before_login_entity.dart';
import 'package:loanapp/src/features/auth/domain/entities/user_entity.dart';
import 'package:loanapp/src/features/auth/domain/repositories/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource remoteDataSource;

  AuthRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<String, UserEntity>> checkUser({
    String? token,
    required String phoneNumber,
    required Map<String, String> body,
  }) async {
    return await remoteDataSource.checkUser(
      token: token,
      phoneNumber: phoneNumber,
      body: body,
    );
  }
  
  @override
  Future<Either<String, BeforeLogInEntity>> logIn({String? token, required Map<String, String> body}) async {
    return await remoteDataSource.logIn(
      token: token,
      body: body,
    );
    
  }
  
  @override
  Future<Either<String, UserEntity>> signUp({String? token, required Map<String, String> body}) async {
    return await remoteDataSource.signUp(
      token: token,
      body: body,
    );
    
  }
}
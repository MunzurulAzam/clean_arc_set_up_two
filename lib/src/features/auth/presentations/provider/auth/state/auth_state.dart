
import 'package:loanapp/src/features/auth/domain/entities/before_login_entity.dart';
import 'package:loanapp/src/features/auth/domain/entities/user_entity.dart';

class AuthState {
  final bool isLoading;
  final String? errorMessage;
  final UserEntity? userEntity;
  final BeforeLogInEntity? beforeLogInEntity;
   bool? isReformVisible;

  AuthState({this.isLoading = false, this.errorMessage, this.userEntity, this.beforeLogInEntity, this.isReformVisible});

  AuthState copyWith({
    bool? isLoading,
    String? errorMessage,
    UserEntity? userEntity,
    bool? isReformVisible,
    BeforeLogInEntity? beforeLogInEntity,
  }) {
    return AuthState(
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
      userEntity: userEntity ?? this.userEntity,
      isReformVisible: isReformVisible ?? this.isReformVisible,
      beforeLogInEntity: beforeLogInEntity ?? this.beforeLogInEntity,
    );
  }
}
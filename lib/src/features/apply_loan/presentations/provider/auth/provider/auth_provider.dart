import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:loanapp/core/helper/log_message.dart';
import 'package:loanapp/core/network/api_client.dart';
import 'package:loanapp/src/features/auth/data/data_source/auth_remote_datasource.dart';
import 'package:loanapp/src/features/auth/data/repo/auth_repository_impl.dart';
import 'package:loanapp/src/features/auth/domain/repositories/auth_repository.dart';
import 'package:loanapp/src/features/auth/domain/usecases/check_user_usecase.dart';
import 'package:loanapp/src/features/auth/presentations/provider/auth/state/auth_state.dart';

class CheckUserNotifier extends StateNotifier<AuthState> {
  final CheckUser _checkUserUseCase;
  CheckUserNotifier(this._checkUserUseCase) : super(AuthState());

//! for call check user useCase

  Future<bool> checkUser({
    String? token,
    required String phoneNumber,
    required Map<String, String> body,
  }) async {
    state = state.copyWith(isLoading: true);
    final result = await _checkUserUseCase.call(
      token: token,
      phoneNumber: phoneNumber,
      body: body,
    );

    return result.fold(
      (failureMessage) {
        state = state.copyWith(
          isLoading: false,
          errorMessage: failureMessage,
          isReformVisible: false,
        );
        logMessage('errorLog: ${state.errorMessage.toString()}');
        return false;
      },
      (userEntity) {
        state = state.copyWith(
          isLoading: false,
          userEntity: userEntity,
          isReformVisible: true,
        );
        return true;
      },
    );
  }

//! for log in
  Future<bool> logIn({
    String? token,
    required Map<String, String> body,
  }) async {
    state = state.copyWith(isLoading: true);
    final result = await _checkUserUseCase.logIn(
      token: token,
      body: body,
    );

    return result.fold(
      (failureMessage) {
        state = state.copyWith(
          isLoading: false,
          errorMessage: failureMessage,
        );
        logMessage('errorLog: ${state.errorMessage.toString()}');
        return false;
      },
      (beforeLogInEntity) {
        state = state.copyWith(
          isLoading: false,
          beforeLogInEntity: beforeLogInEntity
        );
        return true;
      },
    );
  }

//! for sign up
  Future<bool> signUp({
    String? token,
    required Map<String, String> body,
  }) async {
    state = state.copyWith(isLoading: true);
    final result = await _checkUserUseCase.signUp(
      token: token,
      body: body,
    );

    return result.fold(
      (failureMessage) {
        state = state.copyWith(
          isLoading: false,
          errorMessage: failureMessage,
        );
        logMessage('errorLog: ${state.errorMessage.toString()}');
        return false;
      },
      (userEntity) {
        state = state.copyWith(
          isLoading: false,
          userEntity: userEntity,
        );
        return true;
      },
    );
  }
  //! for clear state
  void clearState() {
    state = AuthState(
      userEntity: state.userEntity,
    );
  }
}

// Data Layer Providers
final apiClientProvider = Provider<ApiClient>((ref) => ApiClient());

final authRemoteDataSourceProvider = Provider<AuthRemoteDataSource>((ref) {
  return AuthRemoteDataSourceImpl(apiClient: ref.watch(apiClientProvider));
});

final authRepositoryProvider = Provider<AuthRepository>((ref) {
  return AuthRepositoryImpl(remoteDataSource: ref.watch(authRemoteDataSourceProvider));
});
// Domain Layer Providers
final checkUserUseCaseProvider = Provider<CheckUser>((ref) {
  return CheckUser(ref.watch(authRepositoryProvider));
});
// Presentation Layer Providers
final authNotifierProvider = StateNotifierProvider<CheckUserNotifier, AuthState>((ref) {
  return CheckUserNotifier(ref.watch(checkUserUseCaseProvider));
});

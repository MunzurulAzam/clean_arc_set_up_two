import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:loanapp/core/network/api_client.dart';
import 'package:loanapp/src/features/apply_loan/data/data_source/apply_loan_remote_datasource.dart';
import 'package:loanapp/src/features/apply_loan/data/repo/apply_loan_repository_impl.dart';
import 'package:loanapp/src/features/apply_loan/domain/repositories/apply_loan_repository.dart';
import 'package:loanapp/src/features/apply_loan/domain/usecases/apply_loan_usecase.dart';
import 'package:loanapp/src/features/apply_loan/presentations/provider/apply_loan_provider/state/apply_loan_state.dart';

// final applyLoanProvider =
//     StateNotifierProvider<ApplyLoanNotifier, ApplyLoanState>(
//         (ref) => ApplyLoanNotifier());

class ApplyLoanNotifier extends StateNotifier<ApplyLoanState> {
  final ApplyLoanUseCase applyLoanUseCase;
  ApplyLoanNotifier(this.applyLoanUseCase) : super(ApplyLoanState());
  final List<Map<String, dynamic>> loanPurpose = [
    {'name': 'Personal Loan', 'id': 1},
    {'name': 'Business Loan', 'id': 2},
    {'name': 'Education Loan', 'id': 3},
  ];
  final List<Map<String, dynamic>> loanRepaymentOption = [
    {'name': '4 Weeks', 'id': 1},
    {'name': '6 Weeks', 'id': 2},
    {'name': '8 Weeks', 'id': 3},
  ];
  final List<Map<String, dynamic>> chargeApplicable = [
    {'name': 'Bank', 'id': 1},
    {'name': 'Phone', 'id': 2},
  ];
  final List<Map<String, dynamic>> isDailyIncome = [
    {'name': 'Yes', 'id': 1},
    {'name': 'No', 'id': 2},
  ];
  final List<Map<String, dynamic>> isOtherLoanPurpose = [
    {'name': 'Yes', 'id': 1},
    {'name': 'No', 'id': 2},
  ];
  //! for set loan purpose
  void setLoanPurpose(String purpose) {
    state = state.copyWith(loanPurpose: purpose);
  }
  //! for set loan repayment option
  void setLoanRepaymentOption(String option) {
    state = state.copyWith(loanRepaymentOption: option);
  }
  //! for set charge applicable
  void setChargeApplicable(String charge) {
    state = state.copyWith(chargeApplicable: charge);
  }
  //! for set daily income
  void setDailyIncome(String income) {
    state = state.copyWith(dailyIncome: income);
  }
  //! for set other loan purpose
  void setOtherLoanPurpose(String purpose) {
    state = state.copyWith(otherLoanPurpose: purpose);
  }

  //! for reset all fields
  void resetFields() {
    state = ApplyLoanState();
  }

  //! for apply loan
  Future<bool> applyLoan({
    String? token,
    required Map<String, String> body,
  }) async {
    state = state.copyWith(isLoading: true);
    final result = await applyLoanUseCase.applyLoan(token: token, body: body);

    return result.fold(
      (failureMessage) {
        state = state.copyWith(
          isLoading: false,
          errorMessage: failureMessage,
        );
        return false;
      },
      (applyLoanEntity) {
        state = state.copyWith(
          isLoading: false,
          applyLoanEntity: applyLoanEntity,
        );
        return true;
      },
    );
  }

}
// Data Layer Providers
final apiClientProvider = Provider<ApiClient>((ref) => ApiClient());

final applyLoanRemoteDataSourceProvider = Provider<ApplyLoanRemoteDatasource>((ref) {
  return ApplyLoanRemoteDatasourceImpl(apiClient: ref.watch(apiClientProvider));
});

final applyLoanRepositoryProvider = Provider<ApplyLoanRepository>((ref) {
  return ApplyLoanRepositoryImpl(remoteDataSource: ref.watch(applyLoanRemoteDataSourceProvider));
});
// Domain Layer Providers
final applyLoanUseCaseProvider = Provider<ApplyLoanUseCase>((ref) {
  return ApplyLoanUseCase(ref.watch(applyLoanRepositoryProvider));
});
// Presentation Layer Providers
final applyLoanProvider = StateNotifierProvider<ApplyLoanNotifier, ApplyLoanState>((ref) {
  return ApplyLoanNotifier(ref.watch(applyLoanUseCaseProvider));
});

import 'package:loanapp/src/features/apply_loan/domain/entities/apply_loan_entity.dart';

class ApplyLoanState {
  final bool isLoading;
  final String? errorMessage;
  String? loanPurpose;
  String? loanRepaymentOption;
  String? chargeApplicable;
  String? dailyIncome;
  String? otherLoanPurpose;
  final ApplyLoanEntity? applyLoanEntity;

  ApplyLoanState({
     this.isLoading = false,
    this.errorMessage,
    this.loanPurpose,
    this.loanRepaymentOption,
    this.chargeApplicable,
    this.dailyIncome,
    this.otherLoanPurpose,
    this.applyLoanEntity,
  });

  ApplyLoanState copyWith({
    bool? isLoading,
    String? errorMessage,
    String? loanPurpose,
    String? loanRepaymentOption,
    String? chargeApplicable,
    String? dailyIncome,
    String? otherLoanPurpose,
    ApplyLoanEntity? applyLoanEntity,
  }) {
    return ApplyLoanState(
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
      loanPurpose: loanPurpose ?? this.loanPurpose,
      loanRepaymentOption: loanRepaymentOption ?? this.loanRepaymentOption,
      chargeApplicable: chargeApplicable ?? this.chargeApplicable,
      dailyIncome: dailyIncome ?? this.dailyIncome,
      otherLoanPurpose: otherLoanPurpose ?? this.otherLoanPurpose,
      applyLoanEntity: applyLoanEntity ?? this.applyLoanEntity,
    );
  }
}

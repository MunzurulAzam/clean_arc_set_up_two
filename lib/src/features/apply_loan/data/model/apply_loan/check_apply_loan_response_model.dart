
import 'package:loanapp/src/features/apply_loan/domain/entities/apply_loan_entity.dart';


class CheckApplyLoanResponseModel extends ApplyLoanEntity {
  const CheckApplyLoanResponseModel({
    required String? message,
  }) : super( message: message);

  factory CheckApplyLoanResponseModel.fromJson(Map<String, dynamic> json) {
    return CheckApplyLoanResponseModel(
      message: json['message'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'message': message,
    };
  }
}
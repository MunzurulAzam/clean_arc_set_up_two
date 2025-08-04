import 'package:dartz/dartz.dart';
import '../entities/apply_loan_entity.dart';
import '../repositories/apply_loan_repository.dart';

class ApplyLoanUseCase {
  final ApplyLoanRepository repository;

  ApplyLoanUseCase(this.repository);
  //! for apply loan
  Future<Either<String, ApplyLoanEntity>> applyLoan({
    String? token,
    required Map<String, String> body,
  }) async {
    return await repository.applyLoan(
      token: token,
      body: body,
    );
  }



}
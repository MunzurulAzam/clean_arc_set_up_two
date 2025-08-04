import 'package:dartz/dartz.dart';
import '../entities/apply_loan_entity.dart';

abstract class ApplyLoanRepository {
//! for apply loan
  Future<Either<String, ApplyLoanEntity>> applyLoan({
    String? token,
    required Map<String, String> body,
  });


}
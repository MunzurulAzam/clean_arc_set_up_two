import 'package:dartz/dartz.dart';
import 'package:loanapp/src/features/apply_loan/data/data_source/apply_loan_remote_datasource.dart';
import 'package:loanapp/src/features/apply_loan/domain/entities/apply_loan_entity.dart';
import 'package:loanapp/src/features/apply_loan/domain/repositories/apply_loan_repository.dart';

class ApplyLoanRepositoryImpl implements ApplyLoanRepository {
  final ApplyLoanRemoteDatasource remoteDataSource;

  ApplyLoanRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<String, ApplyLoanEntity>> applyLoan({String? token, required Map<String, String> body}) {
    return remoteDataSource.applyLoan(body: body, token: token);
  }
  

}
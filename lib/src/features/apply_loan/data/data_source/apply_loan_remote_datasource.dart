import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:loanapp/core/constants/strings/api_access.dart';
import 'package:loanapp/core/helper/multipart_file_with_name/multipart_file_with_name.dart';
import 'package:loanapp/core/network/api_client.dart';
import 'package:loanapp/src/features/apply_loan/data/model/apply_loan/check_apply_loan_response_model.dart';

import '../../../../../core/constants/strings/api_request_type.dart';

abstract class ApplyLoanRemoteDatasource {
  //! for apply loan
  Future<Either<String, CheckApplyLoanResponseModel>> applyLoan({
    String? token,
    required Map<String, String> body,
  });
}

class ApplyLoanRemoteDatasourceImpl implements ApplyLoanRemoteDatasource {
  final ApiClient apiClient;

  ApplyLoanRemoteDatasourceImpl({required this.apiClient});

  @override
  Future<Either<String, CheckApplyLoanResponseModel>> applyLoan({String? token, required Map<String, String> body}) async {
    try {
      Map<String, MultipartFileWithName> filePath = {};
      final response = await apiClient.multipartHttpRequest(
        apiRequestType: ApiRequestType.post,
        url: ApiAccess.applyLoanUrl,
        fields: body,
        filePaths: filePath,
        token: token,
      );
      if (response.statusCode == 200) {
        final responseA = jsonDecode(response.body);
        final data = CheckApplyLoanResponseModel.fromJson(responseA);
        return Right(data);
      } else {
        return Left('Error: ${response.body}');
      }
    } catch (e) {
      return Left(e.toString());
    }
  }
}

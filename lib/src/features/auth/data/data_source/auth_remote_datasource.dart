import 'dart:convert';
import 'package:dartz/dartz.dart';
import 'package:loanapp/core/constants/strings/api_access.dart';
import 'package:loanapp/core/helper/multipart_file_with_name/multipart_file_with_name.dart';
import 'package:loanapp/core/network/api_client.dart';
import 'package:loanapp/src/features/auth/data/model/before_login_response_model/before_login_response_model.dart';
import 'package:loanapp/src/features/auth/data/model/check_user/check_user_response_model.dart';

import '../../../../../core/constants/strings/api_request_type.dart'; // আপনার ApiAccess এর সঠিক পাথ



abstract class AuthRemoteDataSource {
  Future<Either<String, CheckUserResponseModel>> checkUser({
    String? token,
    required String phoneNumber,
    required Map<String, String> body,
  });

  //! for log in
  Future<Either<String, BeforeLogInResponseModel>> logIn({
    String? token,
    required Map<String, String> body,
  });

  //! for sign up
  Future<Either<String, CheckUserResponseModel>> signUp({
    String? token,
    required Map<String, String> body,
  });
}


class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final ApiClient apiClient;

  AuthRemoteDataSourceImpl({required this.apiClient});

  @override
  Future<Either<String, CheckUserResponseModel>> checkUser({
    String? token,
    required String phoneNumber,
    required Map<String, String> body,
  }) async {
    try {
  
       Map<String, MultipartFileWithName> filePath = {};

      // final response = await apiClient.apiRequest(
      //   ApiAccess.checkUserUrl, //
      //   method: Method.post,
      //   body: body,
      //   token: token,
      // );
      final response = await ApiClient().multipartHttpRequest(
        apiRequestType: ApiRequestType.post,
        url: ApiAccess.checkUserUrl,
        fields: body,
        filePaths: filePath,
        token: token,
      );

      if (response.statusCode == 200) {
        final responseBody = jsonDecode(response.body);
        final userModel = CheckUserResponseModel.fromJson(responseBody);
        return Right(userModel);
      } else {
        return Left(response.body);
      }
    } catch (e) {
      return Left('Exception occurred: $e');
    }
  }
  
  @override
  Future<Either<String, BeforeLogInResponseModel>> logIn({String? token, required Map<String, String> body}) async {
    try{
      final url = ApiAccess.logInUrl; 
      final response = await apiClient.apiRequest(
        url,
        method: Method.post,
        body: body,
        token: token,
      );
      if (response.statusCode == 200) {
        final responseBody = jsonDecode(response.body);
        final userModel = BeforeLogInResponseModel.fromJson(responseBody);
        return Right(userModel);
      } else {
        return Left('${response.body}');
      }

    }catch (e) {
      return Left('Exception occurred: $e');
    }
  }
  
  @override
  Future<Either<String, CheckUserResponseModel>> signUp({String? token, required Map<String, String> body}) async {
    try {
      final url = ApiAccess.signUpUrl; 
      final response = await apiClient.apiRequest(
        url,
        method: Method.post,
        body: body,
        token: token,
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        final responseBody = jsonDecode(response.body);
        final userModel = CheckUserResponseModel.fromJson(responseBody);
        return Right(userModel);
      } else {
        return Left('${response.body}');
      }
    } catch (e) {
      return Left('Exception occurred: $e');
    }
    
  }




}
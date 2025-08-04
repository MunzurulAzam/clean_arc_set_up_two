import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:loanapp/core/constants/strings/api_access.dart';
import 'package:loanapp/core/constants/strings/app_constants.dart';
import 'package:loanapp/core/constants/strings/error_strings.dart';
import 'package:loanapp/core/helper/log_message.dart';
import 'package:loanapp/core/helper/multipart_file_with_name/multipart_file_with_name.dart';
import 'package:loanapp/core/preferences/preferences.dart';

enum Method { get, post, put, delete, patch }

class ApiClient {
  ApiClient();
  static var client = http.Client();

  final Map<String, String> _mainHeaders = {
    'Content-Type': 'application/json',
    'Vary': 'Accept',
    'Accept': 'application/json',
  };

  ///post http request supported
  Future<http.Response> apiRequest(
    String url, {
    Method method = Method.get,
    dynamic body,
    Map<String, String>? headers,
    int? timeOut,
    String? token,
  }) async {
    //logMessage('check 402 token $token');
    logMessage('Request Body: $body', name: 'apiRequest');
    http.Response response;
    http.Response request;
    Map<String, String> finalHeaders = headers ?? (token != null ? currentUserHeader(token: token) : _mainHeaders);
    dynamic finalBody = jsonEncode(body);
    int finalTimeOut = timeOut ?? AppConstant.timeoutRequest; //! String
    Uri finalUri = Uri.parse(url);
    
    ///check this request url and print log message
    logMessage('====> Http Call: $url');

    if (method == Method.put) {
      request = await client
          .put(
        finalUri,
        body: finalBody,
        headers: finalHeaders,
      )
          .timeout(
        Duration(seconds: finalTimeOut),
        onTimeout: () {
          return http.Response(addedErrorMessage(), 408); // Replace 500 with your http code.
        },
      );
    } else if (method == Method.delete) {
      request = await client
          .delete(
        finalUri,
        body: finalBody,
        headers: finalHeaders,
      )
          .timeout(
        Duration(seconds: finalTimeOut),
        onTimeout: () {
          return http.Response(addedErrorMessage(), 408); // Replace 500 with your http code.
        },
      );
    } else if (method == Method.patch) {
      request = await client
          .patch(
        finalUri,
        body: finalBody,
        headers: finalHeaders,
      )
          .timeout(
        Duration(seconds: finalTimeOut),
        onTimeout: () {
          return http.Response(addedErrorMessage(), 408); // Replace 500 with your http code.
        },
      );
    } else if (method == Method.post) {
      request = await client
          .post(
        finalUri,
        body: finalBody,
        headers: finalHeaders,
      )
          .timeout(
        Duration(seconds: finalTimeOut),
        onTimeout: () {
          return http.Response(addedErrorMessage(), 408); // Replace 500 with your http code.
        },
      );
    } else {
      request = await client
          .get(
        finalUri,
        headers: finalHeaders,
      )
          .timeout(
        Duration(seconds: finalTimeOut),
        onTimeout: () {
          return http.Response(addedErrorMessage(), 408); // Replace 500 with your http code.
        },
      );
    }
    if (request.statusCode == 402) {
      ///refresh token automatic refresh
      /// and create the access token
      String refreshToken = await sharedPrefRefreshToken.value ?? '';
      logMessage('check 402 token ==== $refreshToken');
      if (refreshToken.isEmpty) {
        logMessage('logout;;;;;;;;;;;');
        onLogoutTapped();
      }
      final refreshResponse = await requestRefreshToken(timeOut: finalTimeOut, refreshToken: refreshToken);
      if (refreshResponse.statusCode == 200) {
        Map js = jsonDecode(refreshResponse.body);
        String accessToken = js['access'] ?? '';
        String refreshToken = js['refresh'] ?? '';
        await sharedPrefAccessToken.updateValue(accessToken); //!-------------update access token
        await sharedPrefRefreshToken.updateValue(refreshToken); //!-------------update access token
        logMessage('.................................token updated === ${accessToken}.................................');
        logMessage('.................................token updated === ${refreshToken}.................................');
        // String refreshToken = js['refresh'] ?? '';
        ///save another time of 402 code
        //  UserSharedPreference.putString(SharedPreferenceHelper.refreshToken, refreshToken);
        // VisitorType visitorType = await VisitorHelper().getVisitorType();
        // switch (visitorType) {
        //   case VisitorType.visitorRetailerUser:
        //     //sent data to firebase analytics
        //     UserSharedPreference.putString(SharedPreferenceHelper.accessToken, accessToken);
        //     break;
        //   case VisitorType.visitorSRUser:
        //     UserSharedPreference.putString(SharedPreferenceHelper.srToken, accessToken);

        //     break;
        //   case VisitorType.visitorDeliveryUser:
        //     UserSharedPreference.putString(SharedPreferenceHelper.srToken, accessToken);
        //     break;
        //   case VisitorType.visitorUnknown:
        //     break;
        // }
        response = await apiRequest(url, method: method, body: body, token: accessToken, headers: headers, timeOut: timeOut);
      } else if (refreshResponse.statusCode == 402) {                  //! will be 401
        logMessage('Refresh token expired, logging out.');
        onLogoutTapped();
        response = refreshResponse;
      } else {
        response = refreshResponse;
      }
    } else {
      response = request;
    }

    ///print output result log message
    log('====> Http Response: [${response.statusCode}] $url\n${utf8.decode(response.bodyBytes)}');

    return response;
  }

  ///Multipart http request for image with from data
  Future<http.Response> multipartHttpRequest({
    required String apiRequestType,
    required String url,
    required Map<String, String> fields, //?>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>old is String
    required Map<String, MultipartFileWithName> filePaths,
    required String? token,
    int? timeOut,
  }) async {
    http.Response response;
    int finalTimeOut = timeOut ?? AppConstant.timeoutRequest;
    final multiPartRequest = http.MultipartRequest(apiRequestType, Uri.parse(url));
    logMessage('====> Http Call: $url');
    logMessage('====> Body: $fields');
    fields.forEach((key, value) {
      multiPartRequest.fields[key] = value;
    });

    filePaths.forEach((key, value) async {
      multiPartRequest.files.add(
        await http.MultipartFile.fromPath(
          key,
          value.filePath ?? '', //?...............................................need tobe change according to recuirement.
          filename: value.fileName,
        ),
      );
    });

    multiPartRequest.headers.addAll(
      token != null ? multipartHeaderWithToken(token) : multipartHeaderWithoutToken(),
    );

    var request = await multiPartRequest.send().timeout(
      Duration(seconds: finalTimeOut),
      onTimeout: () {
        return streamTimeOutResponse(
          error: ErrorStrings.kServerTimeoutMessage,
        ); // Replace 500 with your http code.
      },
    );
    if (request.statusCode == 402) {
      ///refresh token automatic refresh
      /// and create the access token
      // String refreshToken = await UserSharedPreference.getString(SharedPreferenceHelper.refreshToken) ?? '';
      String refreshToken = await sharedPrefRefreshToken.value ?? '';
      if (refreshToken.isEmpty) {
        logMessage('logout;;;;;;;;;;;');
        onLogoutTapped();
      }
      final refreshResponse = await requestRefreshToken(timeOut: finalTimeOut, refreshToken: refreshToken);
      if (refreshResponse.statusCode == 200) {
        Map js = jsonDecode(refreshResponse.body);
        String accessToken = js['access'] ?? '';
        String refreshToken = js['refresh'] ?? '';
        await sharedPrefAccessToken.updateValue(accessToken); //!-------------update access token
        await sharedPrefRefreshToken.updateValue(refreshToken); //!-------------update refresh token
        ///save another time of 402 code
        // VisitorType visitorType = await VisitorHelper().getVisitorType();
        // switch (visitorType) {
        //   case VisitorType.visitorRetailerUser:
        //     //sent data to firebase analytics
        //     UserSharedPreference.putString(SharedPreferenceHelper.accessToken, accessToken);
        //     break;
        //   case VisitorType.visitorSRUser:
        //     UserSharedPreference.putString(SharedPreferenceHelper.srToken, accessToken);
        //     break;
        //   case VisitorType.visitorDeliveryUser:
        //     UserSharedPreference.putString(SharedPreferenceHelper.srToken, accessToken);
        //     break;
        //   case VisitorType.visitorUnknown:
        //     break;
        // }
        response = await multipartHttpRequest(
            apiRequestType: apiRequestType, url: url, fields: fields, filePaths: filePaths, token: accessToken, timeOut: timeOut);
      } else if (refreshResponse.statusCode == 402) {
        response = refreshResponse;
        onLogoutTapped();
      } else {
        response = refreshResponse;
      }
    } else {
      response = await http.Response.fromStream(request);
    }
    logMessage('>>>>>>>responseFromAPi = ${response.body}');
    logMessage('>>>>>>>StatusCode = ${response.statusCode}');

    ///var streamToResponse = await http.Response.fromStream(request);
    return response;
  }

//! for multiple image

  Future<http.Response> multipartHttpRequestForMultipleImage({
    required String apiRequestType,
    required String url,
    required Map<String, String> fields,
    required Map<String, List<MultipartFileWithName>> fileList,
    String? token,
  }) async {
    var request = http.MultipartRequest(apiRequestType, Uri.parse(url));

    // Add fields
    request.fields.addAll(fields);

    // Add files
    fileList.forEach((key, files) async {
      for (var file in files) {
        request.files.add(
          http.MultipartFile.fromBytes(
            key,
            await File(file.filePath ?? '').readAsBytes(),
            filename: file.fileName,
          ),
        );
      }
    });

    // Add headers
    if (token != null) {
      request.headers['Authorization'] = 'Bearer $token';
    }

    // Send the request
    var response = await http.Response.fromStream(await request.send());
    return response;
  }

  ///request refresh token and create new access token
  Future<http.Response> requestRefreshToken({
    required int timeOut,
    required String refreshToken,
  }) async {
    final body = {"refresh": refreshToken.toString()};
    logMessage('body...............${body}');
    final url = Uri.parse(ApiAccess.refreshTokenUrl);
    logMessage('====> Http Call: $url');
    http.Response request = await http
        .post(
      // Uri.parse(ApiAccess.refreshTokenUrl), //!-------------------------enter your refresh token url
      url,
      body: jsonEncode(body),
      headers: _mainHeaders,
    )
        .timeout(
      Duration(seconds: timeOut),
      onTimeout: () {
        return http.Response(addedErrorMessage(), 408); // Replace 500 with your http code.
      },
    );

    ///print output result log message
    log('====> Http Response: [${request.statusCode}] $url\n${utf8.decode(request.bodyBytes)}');
    return request;
  }

  ///add server timeout error message
  String addedErrorMessage({String message = ErrorStrings.kServerTimeoutMessage}) {
    return '{"error": "$message"}';
  }

  http.StreamedResponse streamTimeOutResponse({
    required String error,
  }) {
    Map<String, dynamic> body = {
      'any': 'value',
      'error': error,
    };

    int statusCode = 408;
    String json = jsonEncode(body);

    return http.StreamedResponse(
      Stream.value(json.codeUnits),
      statusCode,
    );
  }

  //Get current user header
  static Map<String, String> currentUserHeader({String? token}) {
    Map<String, String> mainHeaders = {
      'Content-Type': 'application/json',
      'Vary': 'Accept',
      'Accept': 'application/json',
      'Authorization': 'Bearer ${token ?? (sharedPrefAccessToken.value ?? '')}',
    };
    return mainHeaders;
  }

  static Map<String, String> multipartHeaderWithToken(String token) {
    Map<String, String> header = {
      'Content-Type': 'multipart/form-data',
      'Authorization': 'Bearer $token',
      'Accept': 'application/json',
    };
    return header;
  }

  static Map<String, String> multipartHeaderWithoutToken() {
    Map<String, String> header = {
      'Content-Type': 'multipart/form-data',
      'Accept': 'application/json',
    };
    return header;
  }

  onLogoutTapped() async {
    // await SharedPreferencesConfig.clearData();

    logMessage('................................data clear successfully................................');

    // Navigate to the login screen
    // Navigator.push(
    //   navigatorKey.currentContext!,
    //   MaterialPageRoute(builder: (context) => const LoginScreen()),  // Replace with your login screen widget
    // );
  }
}

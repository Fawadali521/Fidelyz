import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:fidelyz/src/services/BaseApiClass.dart';
import 'package:fidelyz/src/services/HandleException.dart';
import 'package:fidelyz/src/services/shared_prefs/UserSharedPrefs.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

class NetworkApiClass extends BaseApiClass {
  final _userSharedPrefs = UserSharedPrefs();

  /// Api call
  @override
  Future getApi(String url) async {
    dynamic jsonResponse;
    try {
      String? userToken = await _userSharedPrefs.getUserToken();
      debugPrint(userToken);
      var headers = {'Authorization': 'Bearer $userToken'};

      /// server request
      var request = http.Request('GET', Uri.parse(url));

      request.headers.addAll(headers);
      http.StreamedResponse response =
          await request.send().timeout(const Duration(seconds: 30));
      debugPrint(response.statusCode.toString());
      jsonResponse = returnResponse(response);
    } on SocketException {
      throw InternetException();
    } on TimeoutException {
      throw RequestTimeOut();
    } on http.ClientException {
      throw ClientExceptions('Invalid Url Exception');
    }
    return jsonResponse;
  }

  /// Server request
  @override
  Future postApi(data, String url) async {
    dynamic jsonResponse;
    try {
      var headers = {'Content-Type': 'application/json'};
      final request = http.Request('POST', Uri.parse(url));
      request.body = json.encode(data);
      request.headers.addAll(headers);
      http.StreamedResponse response =
          await request.send().timeout(const Duration(seconds: 30));
      jsonResponse = returnResponse(response);
    } on SocketException {
      throw InternetException();
    } on TimeoutException {
      throw RequestTimeOut();
    } on http.ClientException {
      throw ClientExceptions('Invalid Url Exception');
    }
    if (kDebugMode) print(jsonResponse);
    return jsonResponse;
  }
  /// patch api server call
  @override
  Future patchApi(data, String url, Map<String, String> headers) async {
    dynamic jsonResponse;
    try {
      var request = http.Request('PATCH', Uri.parse(url));
      request.body = json.encode(data);
      request.headers.addAll(headers);

      http.StreamedResponse response =
      await request.send().timeout(const Duration(seconds: 30));
      debugPrint(response.statusCode.toString());
      jsonResponse = returnResponse(response);
      debugPrint(jsonResponse.toString());
    } on SocketException {
      throw InternetException();
    } on TimeoutException {
      throw RequestTimeOut();
    } on http.ClientException {
      throw ClientExceptions('Invalid Url Exception');
    }
    return jsonResponse;
  }

  /// Check Status code and return response body
  returnResponse(http.StreamedResponse response) async {
    switch (response.statusCode) {
      case 200:
        dynamic responseJson =
            json.decode(await response.stream.bytesToString());
        return responseJson;
      case 400:
        dynamic responseJson =
            json.decode(await response.stream.bytesToString());
        return responseJson;
      case 500:
        throw ServerException();
      default:
        dynamic responseJson =
            json.decode(await response.stream.bytesToString());
        throw FetchDataException(
            'Error occurred while fetching data from server, Status code is : ${response.statusCode} $responseJson');
    }
  }
}

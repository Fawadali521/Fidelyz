import 'package:fidelyz/src/resources/app_urls/AppUrls.dart';
import 'package:fidelyz/src/services/NetworkApiClass.dart';
import 'package:flutter/cupertino.dart';

class SearchRepository {
  final _networkApiClass = NetworkApiClass();

  /// Make api call for all sellers
  Future<dynamic> getAllSellers({required String addFilters}) async {
    debugPrint("Url is ${AppUrls.sellerSearch + addFilters}");
    dynamic response =
        await _networkApiClass.getApi(AppUrls.sellerSearch + addFilters);
    debugPrint("rsponse is $response");
    return response;
  }


}

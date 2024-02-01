import 'package:fidelyz/src/modals/SellerSearchModel.dart';
import 'package:fidelyz/src/services/ToastMsg.dart';
import 'package:fidelyz/src/services/repository/SearchRepository.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import '../../utils/Utils.dart';

class CategoryController extends GetxController {
  RxList<Seller> sellers = <Seller>[].obs;
  RxList<Seller> filteredSellers = <Seller>[].obs;

  final _searchRepository = SearchRepository();
  RxString category = ''.obs, markerType = ''.obs, city = ''.obs, pin = ''.obs;
  RxInt size = 20.obs, page = 0.obs;

  Rx<bool> isLoading = false.obs, loadMore = false.obs, isFiltering = false.obs;

  @override
  void onInit() {
    searchSellers();
    super.onInit();
  }

  /// Build app url with filters
  String buildApiUrl({
    required int size,
    required int page,
    String? category,
    String? markerType,
    String? city,
    String? pin,
  }) {
    final List<String> queryParams = [];

    // Add mandatory parameters
    queryParams.add('size=$size');
    queryParams.add('page=$page');

    // Add optional parameters
    if (category != null) {
      queryParams.add('seller_category=$category');
    }
    if (markerType != null) {
      queryParams.add('marker_type=$markerType');
    }
    if (city != null) {
      queryParams.add('city=$city');
    }
    if (pin != null) {
      queryParams.add('pin=$pin');
    }
    // Join all parameters into a single string
    final String queryString = queryParams.join('&');
    return queryString;
  }

  /// Get all sellers
  void searchSellers() async {
    isLoading(true);
    String filters = buildApiUrl(
      size: size.value,
      page: page.value,
      category: category?.value,
      markerType: markerType?.value,
      city: city?.value,
      pin: pin?.value,
    );

    debugPrint(filters);
    await _searchRepository.getAllSellers(addFilters: filters).then(
      (value) {
        if (value != null) {
          if (value["error"] == "INTERNAL_SERVER_ERROR") {
            isLoading(false);
            ToastMsg().sendErrorMsg('Something went wrong');
          } else {
            /// parse the value
            SellerSearchModel searchModel = SellerSearchModel.fromJson(value);

            /// add values in sellers lists,
            if (isFiltering.value) {
              filteredSellers.value =
                  searchModel.sellers.map((seller) => seller).toList();
            } else {
              sellers.value =
                  searchModel.sellers.map((seller) => seller).toList();
            }

            isLoading(false);
          }
        }
      },
    ).onError((error, stackTrace) {
      isLoading(false);
      debugPrint(error.toString());

      /// Check if no internet found
      if (error.toString() == 'No Internet null') {
        Utils.showToastMessage(
          message: 'Make sure you have the internet connection',
          title: 'Network Error',
        );
      }
    });
  }

  /// Perform pagination
  void performPagination() async {
    loadMore(true);

    String filters = buildApiUrl(
      size: size.value,
      page: page.value,
      category: category?.value,
      markerType: markerType?.value,
      city: city?.value,
      pin: pin?.value,
    );

    debugPrint(filters);
    await _searchRepository.getAllSellers(addFilters: filters).then(
      (value) {
        if (value != null) {
          if (value["error"] == "INTERNAL_SERVER_ERROR") {
            loadMore(false);
            ToastMsg().sendErrorMsg('Something went wrong');
          } else {
            /// parse the value
            SellerSearchModel searchModel = SellerSearchModel.fromJson(value);

            if (searchModel.sellers.isNotEmpty) {
              /// add values in sellers lists,
              for (var seller in searchModel.sellers) {
                if (isFiltering.value) {
                  filteredSellers.add(seller);
                } else {
                  sellers.add(seller);
                }
              }
            } else {
              ToastMsg().sendSuccessMsg('No more sellers');
            }

            loadMore(false);
          }
        }
      },
    ).onError((error, stackTrace) {
      loadMore(false);
      debugPrint(error.toString());
    });
  }
}

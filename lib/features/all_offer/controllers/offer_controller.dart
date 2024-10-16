import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pouch/features/all_offer/apis/api.dart';
import 'package:pouch/features/all_offer/models/create_offer_response.dart';
import 'package:pouch/features/all_offer/models/offer.dart';
import 'package:pouch/features/all_offer/models/offer_details_entity.dart';
import 'package:pouch/utils/helpers/controller/helper_function_controller.dart';
import 'package:pouch/utils/responses/handleApiError.dart';
import '../screens/accept_offer_success_page.dart';
import '../screens/offer_details.dart';

class OfferController extends GetxController {
  final helperFunctionsController = Get.put(HelperFunctionsController());
  final isCreatingOfferLoading = false.obs;
  final isAcceptingRejectingOfferLoading = false.obs;
  final isSwappingLoading = false.obs;
  final isNegotiatingOfferLoading = false.obs;
  final isOfferLoading = false.obs;
  final isAllOffersLoading = false.obs;
  final isUsdOffersLoading = false.obs;
  final isEurOffersLoading = false.obs;
  final isCadOffersLoading = false.obs;
  final isGbpOffersLoading = false.obs;
  final isNgnOffersLoading = false.obs;
  final isNewOffersLoading = false.obs;
  final isUsdNewOffersLoading = false.obs;
  final isEurNewOffersLoading = false.obs;
  final isCadNewOffersLoading = false.obs;
  final isGbpNewOffersLoading = false.obs;
  final isNgnNewOffersLoading = false.obs;
  final isTrendingOffersLoading = false.obs;
  final isUsdTrendingOffersLoading = false.obs;
  final isEurTrendingOffersLoading = false.obs;
  final isCadTrendingOffersLoading = false.obs;
  final isGbpTrendingOffersLoading = false.obs;
  final isNgnTrendingOffersLoading = false.obs;
  final showAcceptOfferMsg = false.obs;
  final showRejectOfferMsg = false.obs;
  final isOfferDeleting = false.obs;
  var showErrorText = false.obs;
  var isFetchOfferByIdLoading = false.obs;
  var allOfferIndex = 0.obs;
  var usdOfferIndex = 0.obs;
  var ngnOfferIndex = 0.obs;
  var gbpOfferIndex = 0.obs;
  var cadOfferIndex = 0.obs;
  var eurOfferIndex = 0.obs;
  final createOfferResponse = CreateOfferResponse().obs;
  final offerDetailsEntity = OfferDetailsEntity().obs;
  final offerById = OfferEntity().obs;
  final allOffers = <OfferEntity>[].obs;
  final allUsdOffers = <OfferEntity>[].obs;
  final allNgnOffers = <OfferEntity>[].obs;
  final allCadOffers = <OfferEntity>[].obs;
  final allEurOffers = <OfferEntity>[].obs;
  final allGbpOffers = <OfferEntity>[].obs;
  final newOffers = <OfferEntity>[].obs;
  final newUsdOffers = <OfferEntity>[].obs;
  final newNgnOffers = <OfferEntity>[].obs;
  final newCadOffers = <OfferEntity>[].obs;
  final newEurOffers = <OfferEntity>[].obs;
  final newGbpOffers = <OfferEntity>[].obs;
  final trendingOffers = <OfferEntity>[].obs;
  final trendingUsdOffers = <OfferEntity>[].obs;
  final trendingNgnOffers = <OfferEntity>[].obs;
  final trendingCadOffers = <OfferEntity>[].obs;
  final trendingEurOffers = <OfferEntity>[].obs;
  final trendingGbpOffers = <OfferEntity>[].obs;

  @override
  void onInit() {
    fetchAllOffers();
    super.onInit();
  }

  void showErrorMessage() {
    showErrorText.value = true;
    Timer(Duration(seconds: 3), () {
      showErrorText.value = false;
    });
  }

  Future<void> refreshHomePage() async {
    await fetchAllOffers();
  }

  Future<void> creatingOffer({
    required String debitedCurrency,
    required String creditedCurrency,
    required String amount,
    required String rate,
    String? expireIn,
    required onSuccess
  }) async {
    try {
      isCreatingOfferLoading(true);
      final queryParameters = <String, dynamic>{};
      queryParameters['debitedCurrency'] = debitedCurrency;
      queryParameters['creditedCurrency'] = creditedCurrency;
      queryParameters['amount'] = amount;
      queryParameters['rate'] = rate;
      queryParameters['expireIn'] = expireIn != 'Never' ? int.parse(expireIn.toString()) : 0;

      final response = await OfferService.instance.creatingOffer(queryParameters);
     if (response.statusCode == 200 || response.statusCode == 201) {
       var item = response.data;
       createOfferResponse(CreateOfferResponse(
           id: item['id'],
           debitedCurrency: item['debitedCurrency'],
           creditedCurrency: item['creditedCurrency'],
           amount: item['amount'],
           rate: item['rate'],
           expireIn: item['expireIn'],
           views: item['views'],
           negotiatorRate: item['negotiatorRate'],
           negotiatorAmount: item['negotiatorAmount'],
           negotiationAccepted: item['negotiationAccepted'],
           negotiatorId: item['negotiatorId'],
           isActive: item['isActive'],
           status: item['status'],
           createdDate: item['createdDate'],
           lastModifiedDate: item['lastModifiedDate'],
           expireCountDown: item['expireCountDown']
       ));
       await onSuccess();
       Get.offAndToNamed('/create-success-screen');
     }
    } catch (err) {
      print('Wahala for creating offer');
    } finally {
      isCreatingOfferLoading(false);
    }
  }

  Future<void> acceptingOrRejectingOffer({
    required String id,
    required String currency,
    required bool negotiationAccepted,
    required VoidCallback onSuccess
  }) async {
    try {
      isAcceptingRejectingOfferLoading(true);
      final response = await OfferService.instance.acceptingOrRejectingOffer(
          id: id,
          data: {'negotiationAccepted': negotiationAccepted}
      );
      var item = response.data;
      if (response.statusCode == 200 || response.statusCode == 201) {
        onSuccess();
      }
    } catch (err) {
      print('Wahala dey town');
    } finally {
      isAcceptingRejectingOfferLoading(false);
    }
  }

  Future<void> negotiatingOffer({
    required String id,
    required String currency,
    required String negotiatorRate,
    required String negotiatorAmount,
    required VoidCallback onSuccess,
  }) async {
    try {
      isNegotiatingOfferLoading(true);
      final response = await OfferService.instance.negotiatingOffer(
          id: id,
          data: {
            'negotiatorRate': negotiatorRate,
            'negotiatorAmount': negotiatorAmount
          }
      );
      var item = response.data;
      if (response.statusCode == 200 || response.statusCode == 201) {
        onSuccess();
      }

    } catch (err) {
      print('Wahala dey town');
    } finally {
      isNegotiatingOfferLoading(false);
    }
  }

  Future<void> swappingOffer({
    required String id,
    required String amount,
    required String creditedCurrency
    // required String currency
  }) async {
    try {
      isSwappingLoading(true);
      final response = await OfferService.instance.swappingOffer(id: id);
      if (response.statusCode == 200 || response.statusCode == 201) {
        await fetchAllOffers();
        Get.to(() => AcceptOfferSuccessPage(
          amount: amount,
          creditedCurrency: creditedCurrency,
        ));
      }
    } catch (err) {
      print('Wahala dey town');
    } finally {
      isSwappingLoading(false);
    }
  }

  Future<void> fetchAllOffers() async {
    final queryParameters = <String, dynamic>{};
    queryParameters['sortByAmount'] = 'sortByAmount';
    try {
      allOffers.isEmpty && isAllOffersLoading(true);
      print('checking');
      final response = await OfferService.instance.fetchAllOffers(queryParameters);
      if (response.statusCode == 200 || response.statusCode == 201) {
        var data = response.data;
        var contents = response.data['content'];
        List<OfferEntity> fetchAOffers = (contents as List)
            .map((json) => OfferEntity.fromJson(json)).toList();
        allOffers.assignAll(fetchAOffers);
      } else {
        print('The response from all offer is ${response.statusCode}');
      }
    } catch (err) {
      print('Wahala dey town');
    } finally {
      isAllOffersLoading(false);
    }
  }

  Future<void> fetchAllUsdOffers() async {
    final queryParameters = <String, dynamic>{};
    queryParameters['sortByAmount'] = 'sortByAmount';
    queryParameters['currency'] = 'USD';
    try {
      isUsdOffersLoading(true);
      final response = await OfferService.instance.fetchAllOffers(queryParameters);
      if (response.statusCode == 200 || response.statusCode == 201) {
        var contents = response.data['content'];
        List<OfferEntity> fetchAOffers = (contents as List)
            .map((json) => OfferEntity.fromJson(json)).toList();
        allUsdOffers.assignAll(fetchAOffers);
      }
    } catch (err) {
      print('Wahala dey town');
    } finally {
      isUsdOffersLoading(false);
    }
  }

  Future<void> fetchAllNgnOffers() async {
    final queryParameters = <String, dynamic>{};
    queryParameters['sortByAmount'] = 'sortByAmount';
    queryParameters['currency'] = 'NGN';
    try {
      isNgnOffersLoading(true);
      final response = await OfferService.instance.fetchAllOffers(queryParameters);
      if (response.statusCode == 200 || response.statusCode == 201) {
        var contents = response.data['content'];
        List<OfferEntity> fetchAOffers = (contents as List)
            .map((json) => OfferEntity.fromJson(json)).toList();
        allNgnOffers.assignAll(fetchAOffers);
      }
    } catch (err) {
      print('Wahala dey town');
    } finally {
      isNgnOffersLoading(false);
    }
  }

  Future<void> fetchAllCadOffers() async {
    final queryParameters = <String, dynamic>{};
    queryParameters['sortByAmount'] = 'sortByAmount';
    queryParameters['currency'] = 'CAD';
    try {
      isCadOffersLoading(true);
      final response = await OfferService.instance.fetchAllOffers(queryParameters);
      if (response.statusCode == 200 || response.statusCode == 201) {
        var contents = response.data['content'];
        List<OfferEntity> fetchAOffers = (contents as List)
            .map((json) => OfferEntity.fromJson(json)).toList();
        allCadOffers.assignAll(fetchAOffers);
      }
    } catch (err) {
      print('Wahala dey town');
    } finally {
      isCadOffersLoading(false);
    }
  }

  Future<void> fetchAllEurOffers() async {
    final queryParameters = <String, dynamic>{};
    queryParameters['sortByAmount'] = 'sortByAmount';
    queryParameters['currency'] = 'EUR';
    try {
      isEurOffersLoading(true);
      final response = await OfferService.instance.fetchAllOffers(queryParameters);
      if (response.statusCode == 200 || response.statusCode == 201) {
        var contents = response.data['content'];
        List<OfferEntity> fetchAOffers = (contents as List)
            .map((json) => OfferEntity.fromJson(json)).toList();
        allEurOffers.assignAll(fetchAOffers);
      }
    } catch (err) {
      print('Wahala dey town');
    } finally {
      isEurOffersLoading(false);
    }
  }

  Future<void> fetchAllGbpOffers() async {
    final queryParameters = <String, dynamic>{};
    queryParameters['sortByAmount'] = 'sortByAmount';
    queryParameters['currency'] = 'GBP';
    try {
      isGbpOffersLoading(true);
      final response = await OfferService.instance.fetchAllOffers(queryParameters);
      if (response.statusCode == 200 || response.statusCode == 201) {
        var contents = response.data['content'];
        List<OfferEntity> fetchAOffers = (contents as List)
            .map((json) => OfferEntity.fromJson(json)).toList();
        allGbpOffers.assignAll(fetchAOffers);
      }
    } catch (err) {
      print('Wahala dey town');
    } finally {
      isGbpOffersLoading(false);
    }
  }

  Future<void> fetchNewOffers() async {
    final queryParameters = <String, dynamic>{};
    try {
      isNewOffersLoading(true);
      final response = await OfferService.instance.fetchAllOffers(queryParameters);
      if (response.statusCode == 200 || response.statusCode == 201) {
        var contents = response.data['content'];
        List<OfferEntity> fetchAOffers = (contents as List)
            .map((json) => OfferEntity.fromJson(json)).toList();
        newOffers.assignAll(fetchAOffers);
      }
    } catch (err) {
      print('Wahala dey town');
    } finally {
      isNewOffersLoading(false);
    }
  }

  Future<void> fetchNewUsdOffers() async {
    final queryParameters = <String, dynamic>{};
    queryParameters['currency'] = 'USD';
    try {
      isUsdNewOffersLoading(true);
      final response = await OfferService.instance.fetchAllOffers(queryParameters);
      if (response.statusCode == 200 || response.statusCode == 201) {
        var contents = response.data['content'];
        List<OfferEntity> fetchAllOffers = (contents as List)
            .map((json) => OfferEntity.fromJson(json)).toList();
        newUsdOffers.assignAll(fetchAllOffers);
      }
    } catch (err) {
      print('Wahala dey town');
    } finally {
      isUsdNewOffersLoading(false);
    }
  }

  Future<void> fetchNewNgnOffers() async {
    final queryParameters = <String, dynamic>{};
    queryParameters['currency'] = 'NGN';
    try {
      isNgnNewOffersLoading(true);
      final response = await OfferService.instance.fetchAllOffers(queryParameters);
      if (response.statusCode == 200 || response.statusCode == 201) {
        var contents = response.data['content'];
        List<OfferEntity> fetchAllOffers = (contents as List)
            .map((json) => OfferEntity.fromJson(json)).toList();
        newNgnOffers.assignAll(fetchAllOffers);
      }
    } catch (err) {
      print('Wahala dey town');
    } finally {
      isNgnNewOffersLoading(false);
    }
  }

  Future<void> fetchNewCadOffers() async {
    final queryParameters = <String, dynamic>{};
    queryParameters['currency'] = 'CAD';
    try {
      isCadNewOffersLoading(true);
      final response = await OfferService.instance.fetchAllOffers(queryParameters);
      if (response.statusCode == 200 || response.statusCode == 201) {
        var contents = response.data['content'];
        List<OfferEntity> fetchAllOffers = (contents as List)
            .map((json) => OfferEntity.fromJson(json)).toList();
        newCadOffers.assignAll(fetchAllOffers);
      }
    } catch (err) {
      print('Wahala dey town');
    } finally {
      isCadNewOffersLoading(false);
    }
  }

  Future<void> fetchNewEurOffers() async {
    final queryParameters = <String, dynamic>{};
    queryParameters['currency'] = 'EUR';
    try {
      isEurNewOffersLoading(true);
      final response = await OfferService.instance.fetchAllOffers(queryParameters);
      if (response.statusCode == 200 || response.statusCode == 201) {
        var contents = response.data['content'];
        List<OfferEntity> fetchAllOffers = (contents as List)
            .map((json) => OfferEntity.fromJson(json)).toList();
        newEurOffers.assignAll(fetchAllOffers);
      }
    } catch (err) {
      print('Wahala dey town');
    } finally {
      isEurNewOffersLoading(false);
    }
  }

  Future<void> fetchNewGbpOffers() async {
    final queryParameters = <String, dynamic>{};
    queryParameters['currency'] = 'GBP';
    try {
      isGbpNewOffersLoading(true);
      final response = await OfferService.instance.fetchAllOffers(queryParameters);
      if (response.statusCode == 200 || response.statusCode == 201) {
        var contents = response.data['content'];
        List<OfferEntity> fetchAllOffers = (contents as List)
            .map((json) => OfferEntity.fromJson(json)).toList();
        newGbpOffers.assignAll(fetchAllOffers);
      }
    } catch (err) {
      print('Wahala dey town');
    } finally {
      isGbpNewOffersLoading(false);
    }
  }

  Future<void> fetchTrendingOffers() async {
    final queryParameters = <String, dynamic>{};
    queryParameters['trending'] = 'trending';
    try {
      isTrendingOffersLoading(true);
      final response = await OfferService.instance.fetchAllOffers(queryParameters);
      if (response.statusCode == 200 || response.statusCode == 201) {
        var contents = response.data['content'];
        List<OfferEntity> fetchAllOffers = (contents as List)
            .map((json) => OfferEntity.fromJson(json)).toList();
        trendingOffers.assignAll(fetchAllOffers);
      }
    } catch (err) {
      print('Wahala dey town');
    } finally {
      isTrendingOffersLoading(false);
    }
  }

  Future<void> fetchTrendingUsdOffers() async {
    final queryParameters = <String, dynamic>{};
    queryParameters['trending'] = 'trending';
    queryParameters['currency'] = 'USD';
    try {
      isUsdTrendingOffersLoading(true);
      final response = await OfferService.instance.fetchAllOffers(queryParameters);
      if (response.statusCode == 200 || response.statusCode == 201) {
        var contents = response.data['content'];
        List<OfferEntity> fetchAllOffers = (contents as List)
            .map((json) => OfferEntity.fromJson(json)).toList();
        trendingUsdOffers.assignAll(fetchAllOffers);
      }
    } catch (err) {
      print('Wahala dey town');
    } finally {
      isUsdTrendingOffersLoading(false);
    }
  }

  Future<void> fetchTrendingNgnOffers() async {
    final queryParameters = <String, dynamic>{};
    queryParameters['trending'] = 'trending';
    queryParameters['currency'] = 'NGN';
    try {
      isNgnTrendingOffersLoading(true);
      final response = await OfferService.instance.fetchAllOffers(queryParameters);
      if (response.statusCode == 200 || response.statusCode == 201) {
        var contents = response.data['content'];
        List<OfferEntity> fetchAllOffers = (contents as List)
            .map((json) => OfferEntity.fromJson(json)).toList();
        trendingNgnOffers.assignAll(fetchAllOffers);
      }
    } catch (err) {
      print('Wahala dey town');
    } finally {
      isNgnTrendingOffersLoading(false);
    }
  }

  Future<void> fetchTrendingCadOffers() async {
    final queryParameters = <String, dynamic>{};
    queryParameters['trending'] = 'trending';
    queryParameters['currency'] = 'CAD';
    try {
      isCadTrendingOffersLoading(true);
      final response = await OfferService.instance.fetchAllOffers(queryParameters);
      if (response.statusCode == 200 || response.statusCode == 201) {
        var contents = response.data['content'];
        List<OfferEntity> fetchAllOffers = (contents as List)
            .map((json) => OfferEntity.fromJson(json)).toList();
        trendingCadOffers.assignAll(fetchAllOffers);
      }
    } catch (err) {
      print('Wahala dey town');
    } finally {
      isCadTrendingOffersLoading(false);
    }
  }

  Future<void> fetchTrendingEurOffers() async {
    final queryParameters = <String, dynamic>{};
    queryParameters['trending'] = 'trending';
    queryParameters['currency'] = 'EUR';
    try {
      isEurTrendingOffersLoading(true);
      final response = await OfferService.instance.fetchAllOffers(queryParameters);
      if (response.statusCode == 200 || response.statusCode == 201) {
        var contents = response.data['content'];
        List<OfferEntity> fetchAllOffers = (contents as List)
            .map((json) => OfferEntity.fromJson(json)).toList();
        trendingEurOffers.assignAll(fetchAllOffers);
      }
    } catch (err) {
      print('Wahala dey town');
    } finally {
      isEurTrendingOffersLoading(false);
    }
  }

  Future<void> fetchTrendingGbpOffers() async {
    final queryParameters = <String, dynamic>{};
    queryParameters['trending'] = 'trending';
    queryParameters['currency'] = 'GBP';
    try {
      isGbpTrendingOffersLoading(true);
      final response = await OfferService.instance.fetchAllOffers(queryParameters);
      if (response.statusCode == 200 || response.statusCode == 201) {
        var contents = response.data['content'];
        List<OfferEntity> fetchAllOffers = (contents as List)
            .map((json) => OfferEntity.fromJson(json)).toList();
        trendingGbpOffers.assignAll(fetchAllOffers);
      }
    } catch (err) {
      print('Wahala dey town');
    } finally {
      isGbpTrendingOffersLoading(false);
    }
  }

  Future<void> fetchOfferById({
    required String id,
    required String currency,
    required VoidCallback onSuccess
  }) async {
    try {
      isFetchOfferByIdLoading(true);
      Get.to(() => OfferDetailsScreen());
      print(('I want to load offer'));
      final response = await OfferService.instance.fetchOfferById(id);
      print(response);
      print(('I finally want to load offer'));
      var item = response.data;
      offerById(OfferEntity(
          id: item['id'],
          debitedCurrency: item['debitedCurrency'],
          creditedCurrency: item['creditedCurrency'],
          amount: item['amount'],
          rate: item['rate'],
          expireIn: item['expireIn'],
          expireCountDown: item['expireCountDown'],
          views: item['views'],
          negotiatorRate: item['negotiatorRate'],
          negotiatorAmount: item['negotiatorAmount'],
          negotiationAccepted: item['negotiationAccepted'],
          negotiatorId: item['negotiatorId'],
          isActive: item['isActive'],
          status: item['status'],
          createdDate: item['createdDate'],
          lastModifiedDate: item['lastModifiedDate']
      ));
      await fetchAllOffers();
      onSuccess();
    } catch (err) {
      Get.snackbar('Error`', handleApiFormatError(err), backgroundColor: Colors.redAccent);
    } finally {
      isFetchOfferByIdLoading(false);
    }
  }

  void clearData() {
    createOfferResponse.value = CreateOfferResponse();
    offerDetailsEntity.value = OfferDetailsEntity();
    offerById.value = OfferEntity();
    allOffers.clear();
    allUsdOffers.clear();
    allNgnOffers.clear();
    allCadOffers.clear();
    allEurOffers.clear();
    allGbpOffers.clear();
    newOffers.clear();
    newUsdOffers.clear();
    newNgnOffers.clear();
    newCadOffers.clear();
    newEurOffers.clear();
    newGbpOffers.clear();
    trendingOffers.clear();
    trendingUsdOffers.clear();
    trendingNgnOffers.clear();
    trendingCadOffers.clear();
    trendingEurOffers.clear();
    trendingGbpOffers.clear();
    allOfferIndex.value = 0;
    usdOfferIndex.value = 0;
    ngnOfferIndex.value = 0;
    gbpOfferIndex.value = 0;
    cadOfferIndex.value = 0;
    eurOfferIndex.value = 0;
  }
}
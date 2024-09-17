import 'dart:async';
import 'dart:ui';

import 'package:flutter/animation.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pouch/features/all_offer/apis/api.dart';
import 'package:pouch/features/all_offer/models/create_offer_response.dart';
import 'package:pouch/features/all_offer/models/offer.dart';
import 'package:pouch/features/all_offer/models/offer_details_entity.dart';
import 'package:pouch/utils/helpers/controller/helper_function_controller.dart';
import '../../authentication/controllers/auth_controller.dart';
import '../../home/controller/home_controller.dart';
import '../screens/accept_offer_success_page.dart';
import '../screens/offer_details.dart';

class OfferController extends GetxController {
  final  authController = Get.find<AuthController>();
  final helperFunctionsController = Get.put(HelperFunctionsController());
  final isLoading = false.obs;
  final isOfferLoading = false.obs;
  final isMyBidsLoading = false.obs;
  final isMyOffersLoading = false.obs;
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
  final isNegotiationOfferLoading = false.obs;
  final showAcceptOfferMsg = false.obs;
  final showRejectOfferMsg = false.obs;
  var showErrorText = false.obs;
  // final isNewOfferLoading = false.obs;
  // final isTrendingOfferLoading = false.obs;
  // final isAllUsdLoading = false.obs;
  // final isNewUsdLoading = false.obs;
  // final isTrendingUsdLoading = false.obs;
  // final isNgnLoading = false.obs;
  // final isCadLoading = false.obs;
  // final isGbpLoading = false.obs;
  // final isEurLoading = false.obs;
  var isFetchOfferByIdLoading = false.obs;
  var myOfferIndex = 0.obs;
  var allOfferIndex = 0.obs;
  var usdOfferIndex = 0.obs;
  var ngnOfferIndex = 0.obs;
  var gbpOfferIndex = 0.obs;
  var cadOfferIndex = 0.obs;
  var eurOfferIndex = 0.obs;
  final createOfferResponse = CreateOfferResponse().obs;
  final offerDetailsEntity = OfferDetailsEntity().obs;
  var myOfferById = OfferEntity().obs;
  final myBidById = OfferEntity().obs;
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
  final negotiatedOffers = <OfferEntity>[].obs;
  final myOffers = <OfferEntity>[].obs;
  final myBids = <OfferEntity>[].obs;

  // @override
  // void onInit() {
  //   super.onInit();
  //   fetchAllOffers();
  //   refreshHomePage();
  // }

  void showErrorMessage() {
    showErrorText.value = true;
    Timer(Duration(seconds: 3), () {
      showErrorText.value = false;
    });
  }

  Future<void> refreshHomePage() async {
    await fetchAllOffers();
    await fetchMyBids(days: '', currency: '');
    await fetchMyOffers(days: '', currency: '');
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
      isLoading(true);
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
      print('Wahala dey town');
    } finally {
      isLoading(false);
    }
  }

  Future<void> acceptingOrRejectingOffer({
    required String id,
    required String currency,
    required bool negotiationAccepted,
    required VoidCallback onSuccess
  }) async {
    try {
      isNegotiationOfferLoading(true);
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
      isNegotiationOfferLoading(false);
    }
  }

  Future<void> negotiatingOffer({
    required String id,
    required String currency,
    required String negotiatorRate,
    required String negotiatorAmount,
    required VoidCallback onSuccess
  }) async {
    try {
      isLoading(true);
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
        Get.snackbar('Success', 'Your bid has been created successfully!!!');
      }

    } catch (err) {
      print('Wahala dey town');
    } finally {
      isLoading(false);
    }
  }

  Future<void> swappingOffer({
    required String id,
    required String amount,
    required String creditedCurrency
    // required String currency
  }) async {
    try {
      isLoading(true);
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
      isLoading(false);
    }
  }

  Future<void> fetchAllOffers() async {
    final queryParameters = <String, dynamic>{};
    queryParameters['sortByAmount'] = 'sortByAmount';
    try {
      allOffers.isEmpty && isAllOffersLoading(true);
      final response = await OfferService.instance.fetchAllOffers(queryParameters);
      if (response.statusCode == 200 || response.statusCode == 201) {
        var data = response.data;
        var contents = response.data['content'];
        List<OfferEntity> fetchAOffers = (contents as List)
            .map((json) => OfferEntity.fromJson(json)).toList();
        allOffers.assignAll(fetchAOffers);
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
      final response = await OfferService.instance.fetchOfferById(id);
      print(response);
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
      print('Offer by id fetched ${offerById.value.amount}');
      print('The real value is ${offerById.value.id}');
      await fetchAllOffers();
      onSuccess();
    } catch (err) {
      print('Wahala dey town');
    } finally {
      isFetchOfferByIdLoading(false);
    }
  }

  Future<void> fetchAllNegotiatedOffers() async {
    try {
      negotiatedOffers.isEmpty && isNegotiationOfferLoading(true);
      final response = await OfferService.instance.fetchAllNegotiatedOffers();
      var data = response.data;
      var contents = data['content'];
      List<OfferEntity> fetchAllNegotiation = (contents as List)
          .map((json) => OfferEntity.fromJson(json)).toList();
      negotiatedOffers.assignAll(fetchAllNegotiation);
      print('All negotiations fetched $negotiatedOffers');
    } catch (err) {
      print('Wahala dey town');
    } finally {
      isNegotiationOfferLoading(false);
    }
  }

  Future<void> fetchMyOffers({
    required String days,
    required String currency
  }) async {
    try {
      isMyOffersLoading(true);
      final response = await OfferService.instance.fetchMyOffers(days, currency);
      var data = response.data;
      var contents = data['content'];
      List<OfferEntity> fetchAllNegotiation = (contents as List)
          .map((json) => OfferEntity.fromJson(json)).toList();
      myOffers.assignAll(fetchAllNegotiation);
    } catch (err) {
      print('Wahala dey for offer $err');
    } finally {
      isMyOffersLoading(false);
    }
  }

  Future<void> fetchMyBids({
    required String days,
    required String currency
  }) async {
    try {
      isMyBidsLoading(true);
      final response = await OfferService.instance.fetchMyBids(days, currency);
      var data = response.data;
      var contents = data['content'];
      List<OfferEntity> fetchAllNegotiation = (contents as List)
          .map((json) => OfferEntity.fromJson(json)).toList();
      myBids.assignAll(fetchAllNegotiation);
    } catch (err) {
      print('Wahala dey for bid $err');
    } finally {
      isMyBidsLoading(false);
    }
  }

  Future<void> fetchMyOffersById({required String id, required VoidCallback onSuccess}) async {
    try {
      Get.snackbar('', 'Fetching data ...', backgroundColor: Colors.yellow);
      final response = await OfferService.instance.fetchMyOffersById(id);
      var item = response.data;
      myOfferById(OfferEntity(
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
      print('My Offer by id fetched ${myOfferById.value.amount}');
      onSuccess();
    } catch (err) {
      print('Wahala dey town, $err');
    } finally {
      // Get.closeAllSnackbars();
    }
  }

  Future<void> fetchMyBidsById({required String id, required VoidCallback onSuccess}) async {
    try {
      isLoading(true);
      final response = await OfferService.instance.fetchMyBidsById(id);
      var item = response.data;
      myBidById(OfferEntity(
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
      print('My Bid by id fetched $myBidById');
      onSuccess();
    } catch (err) {
      print('Wahala dey town');
    } finally {
      isLoading(false);
    }
  }

  Future<void> deleteOffer({required String id, required String currency, required String days}) async {
    print('Working');
    try {
      isMyOffersLoading(true);
      final response = await OfferService.instance.deleteOffer(id);
      print(response);
      await fetchMyOffers(days: days, currency: currency);
      Get.snackbar('Success', response.data);
    } catch (e) {
      // Get.snackbar('Error`', 'Something went wrong');
    } finally {
      isMyOffersLoading(false);
    }
  }

  Future<void> deleteBid({required String id, required String currency, required String days}) async {
    try {
      final response = await OfferService.instance.deleteBid(id);
      await fetchMyBids(days: days, currency: currency);
      Get.snackbar('Success', response.data);
    } catch (e) {
      // Get.snackbar('Error`', 'Something went wrong');
    } finally {
    }
  }

  void clearData() {
    createOfferResponse.value = CreateOfferResponse();
    offerDetailsEntity.value = OfferDetailsEntity();
    myOfferById.value = OfferEntity();
    myBidById.value = OfferEntity();
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
    negotiatedOffers.clear();
    myOffers.clear();
    myBids.clear();
    myOfferIndex.value = 0;
    allOfferIndex.value = 0;
    usdOfferIndex.value = 0;
    ngnOfferIndex.value = 0;
    gbpOfferIndex.value = 0;
    cadOfferIndex.value = 0;
    eurOfferIndex.value = 0;
  }
}
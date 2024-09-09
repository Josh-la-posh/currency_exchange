import 'dart:ui';

import 'package:flutter/animation.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:pouch/features/all_offer/apis/api.dart';
import 'package:pouch/features/all_offer/models/create_offer_response.dart';
import 'package:pouch/features/all_offer/models/offer.dart';
import 'package:pouch/features/all_offer/models/offer_details_entity.dart';
import '../screens/accept_offer_success_page.dart';
import '../screens/offer_details.dart';

class OfferController extends GetxController {
  final isLoading = false.obs;
  final isOfferLoading = false.obs;
  final isMyBidsLoading = false.obs;
  final isMyOffersLoading = false.obs;
  final showAcceptOfferMsg = false.obs;
  final showRejectOfferMsg = false.obs;
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

  @override
  void onInit() {
    super.onInit();
    fetchAllOffers();
    refreshHomePage();
  }

  Future<void> refreshHomePage() async {
    await fetchTrendingOffers();
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

      await fetchOffersByCurrency(currency: debitedCurrency);
      await fetchNewOffersByCurrency(currency: debitedCurrency);
      await fetchTrendingOffersByCurrency(currency: debitedCurrency);
      await onSuccess();
      Get.offAndToNamed('/create-success-screen');
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
      isLoading(true);
      final response = await OfferService.instance.acceptingOrRejectingOffer(
          id: id,
          data: {'negotiationAccepted': negotiationAccepted}
      );
      var item = response.data;

      await fetchOffersByCurrency(currency: currency);
      await fetchNewOffersByCurrency(currency: currency);
      await fetchTrendingOffersByCurrency(currency: currency);
      onSuccess();
    } catch (err) {
      print('Wahala dey town');
    } finally {
      isLoading(false);
    }
  }

  Future<void> negotiatingOffer({
    required String id,
    required String currency,
    required String negotiatorRate,
    required String negotiatorAmount,
    // required String currency
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

      await fetchOffersByCurrency(currency: currency);
      await fetchNewOffersByCurrency(currency: currency);
      await fetchTrendingOffersByCurrency(currency: currency);
      Get.snackbar('Success', 'Your bid has been created successfully!!!');
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

      await fetchOffersByCurrency(currency: creditedCurrency);
      await fetchNewOffersByCurrency(currency: creditedCurrency);
      await fetchTrendingOffersByCurrency(currency: creditedCurrency);
      Get.to(() => AcceptOfferSuccessPage(
        amount: amount,
        creditedCurrency: creditedCurrency,
      ));
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
      allOffers.isEmpty && isOfferLoading(true);
      final response = await OfferService.instance.fetchAllOffers(queryParameters);
      var data = response.data;
      offerDetailsEntity(OfferDetailsEntity(
          totalPages: data['totalPages'],
          payloadSize: data['payloadSize'],
          hasNext: data['hasNext'],
          content: data['content'],
          currentPage: data['currentPage'],
          skippedRecords: data['skippedRecords'],
          totalRecords: data['totalRecords']
      ));

      var contents = offerDetailsEntity.value.content;
      List<OfferEntity> fetchAOffers = (contents as List)
          .map((json) => OfferEntity.fromJson(json)).toList();
      allOffers.assignAll(fetchAOffers);

      await fetchNewOffers();
      await fetchTrendingOffers();

      print('All offers fetched $allOffers');
    } catch (err) {
      print('Wahala dey town');
    } finally {
      isOfferLoading(false);
    }
  }

  Future<void> fetchOffersByCurrency({required String currency}) async {
    final queryParameters = <String, dynamic>{};
    queryParameters['sortByAmount'] = 'sortByAmount';
    queryParameters['currency'] = currency;

    try {
      isOfferLoading(true);
      final response = await OfferService.instance.fetchAllOffers(queryParameters);
      var data = response.data;
      offerDetailsEntity(OfferDetailsEntity(
          totalPages: data['totalPages'],
          payloadSize: data['payloadSize'],
          hasNext: data['hasNext'],
          content: data['content'],
          currentPage: data['currentPage'],
          skippedRecords: data['skippedRecords'],
          totalRecords: data['totalRecords']
      ));
      var contents = offerDetailsEntity.value.content;
      List<OfferEntity> fetchAOffers = (contents as List)
          .map((json) => OfferEntity.fromJson(json)).toList();

      switch (currency) {
        case 'USD':
          allUsdOffers.assignAll(fetchAOffers);
          break;
        case 'NGN':
          allNgnOffers.assignAll(fetchAOffers);
          break;
        case 'GBP':
          allGbpOffers.assignAll(fetchAOffers);
          break;
        case 'CAD':
          allCadOffers.assignAll(fetchAOffers);
          break;
        default:
          allEurOffers.assignAll(fetchAOffers);
          break;
      }

      await fetchNewOffersByCurrency(currency: currency);
      await fetchTrendingOffersByCurrency(currency: currency);

      print('All offers fetched $allOffers');
    } catch (err) {
      print('Wahala dey town');
    } finally {
      isOfferLoading(false);
    }
  }

  Future<void> fetchNewOffers() async {
    final queryParameters = <String, dynamic>{};

    try {
      isOfferLoading(true);
      final response = await OfferService.instance.fetchAllOffers(queryParameters);
      var data = response.data;
      offerDetailsEntity(OfferDetailsEntity(
          totalPages: data['totalPages'],
          payloadSize: data['payloadSize'],
          hasNext: data['hasNext'],
          content: data['content'],
          currentPage: data['currentPage'],
          skippedRecords: data['skippedRecords'],
          totalRecords: data['totalRecords']
      ));

      var contents = offerDetailsEntity.value.content;
      List<OfferEntity> fetchAOffers = (contents as List)
          .map((json) => OfferEntity.fromJson(json)).toList();

      newOffers.assignAll(fetchAOffers);
      print('All new offers fetched');
    } catch (err) {
      print('Wahala dey town');
    } finally {
      isOfferLoading(false);
    }
  }

  Future<void> fetchNewOffersByCurrency({required String currency}) async {
    final queryParameters = <String, dynamic>{};
    queryParameters['currency'] = currency;

    try {
      isOfferLoading(true);
      final response = await OfferService.instance.fetchAllOffers(queryParameters);
      var data = response.data;
      offerDetailsEntity(OfferDetailsEntity(
          totalPages: data['totalPages'],
          payloadSize: data['payloadSize'],
          hasNext: data['hasNext'],
          content: data['content'],
          currentPage: data['currentPage'],
          skippedRecords: data['skippedRecords'],
          totalRecords: data['totalRecords']
      ));

      var contents = offerDetailsEntity.value.content;
      List<OfferEntity> fetchAllOffers = (contents as List)
          .map((json) => OfferEntity.fromJson(json)).toList();

      switch (currency) {
        case 'USD':
          newUsdOffers.assignAll(fetchAllOffers);
          break;
        case 'NGN':
          newNgnOffers.assignAll(fetchAllOffers);
          break;
        case 'GBP':
          newGbpOffers.assignAll(fetchAllOffers);
          break;
        case 'CAD':
          newCadOffers.assignAll(fetchAllOffers);
          break;
        default:
          newEurOffers.assignAll(fetchAllOffers);
          break;
      }

      print('All new offers fetched');
    } catch (err) {
      print('Wahala dey town');
    } finally {
      isOfferLoading(false);
    }
  }

  Future<void> fetchTrendingOffers() async {
    final queryParameters = <String, dynamic>{};
    queryParameters['trending'] = 'trending';

    try {
      isOfferLoading(true);
      final response = await OfferService.instance.fetchAllOffers(queryParameters);
      var data = response.data;
      offerDetailsEntity(OfferDetailsEntity(
          totalPages: data['totalPages'],
          payloadSize: data['payloadSize'],
          hasNext: data['hasNext'],
          content: data['content'],
          currentPage: data['currentPage'],
          skippedRecords: data['skippedRecords'],
          totalRecords: data['totalRecords']
      ));

      var contents = offerDetailsEntity.value.content;
      List<OfferEntity> fetchAllOffers = (contents as List)
          .map((json) => OfferEntity.fromJson(json)).toList();

      trendingOffers.assignAll(fetchAllOffers);

      print('All trending offers fetched');
    } catch (err) {
      print('Wahala dey town');
    } finally {
      isOfferLoading(false);
    }
  }

  Future<void> fetchTrendingOffersByCurrency({required String currency}) async {
    final queryParameters = <String, dynamic>{};
    queryParameters['trending'] = 'trending';
    queryParameters['currency'] = currency;

    try {
      isOfferLoading(true);
      final response = await OfferService.instance.fetchAllOffers(queryParameters);
      var data = response.data;
      offerDetailsEntity(OfferDetailsEntity(
          totalPages: data['totalPages'],
          payloadSize: data['payloadSize'],
          hasNext: data['hasNext'],
          content: data['content'],
          currentPage: data['currentPage'],
          skippedRecords: data['skippedRecords'],
          totalRecords: data['totalRecords']
      ));

      var contents = offerDetailsEntity.value.content;
      List<OfferEntity> fetchAllOffers = (contents as List)
          .map((json) => OfferEntity.fromJson(json)).toList();

      switch (currency) {
        case 'USD':
          trendingUsdOffers.assignAll(fetchAllOffers);
          break;
        case 'NGN':
          trendingNgnOffers.assignAll(fetchAllOffers);
          break;
        case 'GBP':
          trendingGbpOffers.assignAll(fetchAllOffers);
          break;
        case 'CAD':
          trendingCadOffers.assignAll(fetchAllOffers);
          break;
        default:
          trendingEurOffers.assignAll(fetchAllOffers);
          break;
      }

      print('All trending offers fetched');
    } catch (err) {
      print('Wahala dey town');
    } finally {
      isOfferLoading(false);
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

      // print('Offer by id fetched $offerById');
      print('Offer by id fetched ${offerById.value.amount}');
      await fetchAllOffers();
      await fetchOffersByCurrency(currency: currency);
      onSuccess();
    } catch (err) {
      print('Wahala dey town');
    } finally {
      isFetchOfferByIdLoading(false);
    }
  }

  Future<void> fetchAllNegotiatedOffers() async {
    try {
      isLoading(true);
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
      isLoading(false);
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
      print('Wahala dey town $err');
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
      print('Wahala dey town');
    } finally {
      isMyBidsLoading(false);
    }
  }

  Future<void> fetchMyOffersById({required String id, required VoidCallback onSuccess}) async {
    try {
      isLoading(true);
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
      isLoading(false);
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
      Get.snackbar('Error`', 'Something went wrong');
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
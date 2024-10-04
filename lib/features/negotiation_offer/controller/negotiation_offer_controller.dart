import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../utils/constants/colors.dart';
import '../../../utils/responses/handleApiError.dart';
import '../../all_offer/apis/api.dart';
import '../../all_offer/models/offer.dart';

class NegotiationOfferController extends GetxController {
  final isMyBidsLoading = false.obs;
  final isMyOffersLoading = false.obs;
  final isNegotiatedOfferLoading = false.obs;
  var myOfferIndex = 0.obs;
  final myOfferById = OfferEntity().obs;
  final myBidById = OfferEntity().obs;
  final myOffers = <OfferEntity>[].obs;
  final myBids = <OfferEntity>[].obs;
  final negotiatedOffers = <OfferEntity>[].obs;

  @override
  void onInit() {
    fetchMyBids(days: '', currency: '');
    fetchMyOffers(days: '', currency: '');
    super.onInit();
  }

  Future<void> fetchMyOffers({
    required String days,
    required String currency
  }) async {
    try {
      myOffers.isEmpty && isMyOffersLoading(true);
      final response = await OfferService.instance.fetchMyOffers(days, currency);
      var data = response.data;
      var contents = data['content'];
      List<OfferEntity> fetchAllNegotiation = (contents as List)
          .map((json) => OfferEntity.fromJson(json)).toList();
      myOffers.assignAll(fetchAllNegotiation);
      print('This is ${myOffers}');
    } catch (err) {
      Get.snackbar('Error`', handleApiFormatError(err), backgroundColor: Colors.redAccent);
    } finally {
      isMyOffersLoading(false);
    }
  }

  Future<void> fetchMyBids({
    required String days,
    required String currency
  }) async {
    try {
      myBids.isEmpty && isMyBidsLoading(true);
      final response = await OfferService.instance.fetchMyBids(days, currency);
      var data = response.data;
      var contents = data['content'];
      List<OfferEntity> fetchAllNegotiation = (contents as List)
          .map((json) => OfferEntity.fromJson(json)).toList();
      myBids.assignAll(fetchAllNegotiation);
    } catch (err) {
      Get.snackbar('Error`', handleApiFormatError(err), backgroundColor: Colors.redAccent);
    } finally {
      isMyBidsLoading(false);
    }
  }

  Future<void> fetchMyOffersById({required String id, required VoidCallback onSuccess}) async {
    try {
      Get.snackbar('', 'Fetching data ...', backgroundColor: TColors.primary);
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
      onSuccess();
    } catch (err) {
      Get.snackbar('Error`', handleApiFormatError(err), backgroundColor: Colors.redAccent);
    } finally {
      Get.closeAllSnackbars();
    }
  }

  Future<void> fetchMyBidsById({required String id, required VoidCallback onSuccess}) async {
    try {
      Get.snackbar('', 'Fetching data ...', backgroundColor: TColors.primary);
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
      Get.snackbar('Error`', handleApiFormatError(err), backgroundColor: Colors.redAccent);
    } finally {
      Get.closeAllSnackbars();
    }
  }

  Future<void> deleteOffer({required String id, required String currency, required String days}) async {
    print('Working');
    try {
      Get.snackbar('', 'Deleting offer ...', backgroundColor: TColors.primary);
      final response = await OfferService.instance.deleteOffer(id);
      print(response);
      await fetchMyOffers(days: days, currency: currency);
      Get.snackbar('Success', response.data);
    } catch (e) {
      Get.snackbar('Error`', handleApiFormatError(e), backgroundColor: Colors.redAccent);
    } finally {
      Get.closeAllSnackbars();
    }
  }

  Future<void> deleteBid({required String id, required String currency, required String days}) async {
    try {
      Get.snackbar('', 'Deleting bid ...', backgroundColor: TColors.primary);
      final response = await OfferService.instance.deleteBid(id);
      await fetchMyBids(days: days, currency: currency);
      Get.snackbar('Success', response.data);
    } catch (e) {
      Get.snackbar('Error`', handleApiFormatError(e), backgroundColor: Colors.redAccent);
    } finally {
      Get.closeAllSnackbars();
    }
  }

  Future<void> fetchAllNegotiatedOffers() async {
    try {
      negotiatedOffers.isEmpty && isNegotiatedOfferLoading(true);
      final response = await OfferService.instance.fetchAllNegotiatedOffers();
      var data = response.data;
      var contents = data['content'];
      List<OfferEntity> fetchAllNegotiation = (contents as List)
          .map((json) => OfferEntity.fromJson(json)).toList();
      negotiatedOffers.assignAll(fetchAllNegotiation);
      print('All negotiations fetched $negotiatedOffers');
    } catch (err) {
      Get.snackbar('Error`', handleApiFormatError(err), backgroundColor: Colors.redAccent);
    } finally {
      isNegotiatedOfferLoading(false);
    }
  }

  void clearData() {
    myOfferById.value = OfferEntity();
    myBidById.value = OfferEntity();
    myOffers.clear();
    myBids.clear();
    myOfferIndex.value = 0;
    negotiatedOffers.clear();
  }
}
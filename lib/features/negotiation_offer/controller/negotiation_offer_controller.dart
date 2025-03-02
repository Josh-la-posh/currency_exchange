import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../utils/constants/colors.dart';
import '../../all_offer/apis/api.dart';
import '../../all_offer/models/offer.dart';

class NegotiationOfferController extends GetxController {
  final CancelToken requestCancelToken = CancelToken();
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
      final response = await OfferService.instance.fetchMyOffers(
        onFailure: () {
          isMyOffersLoading(false);
        }, queryParameters: {
          'days': days,
          'currency': currency
        }
      );
      var data = response;
      var contents = data['content'];
      List<OfferEntity> fetchAllNegotiation = (contents as List)
          .map((json) => OfferEntity.fromJson(json)).toList();
      myOffers.assignAll(fetchAllNegotiation);
      print('This is ${myOffers}');
    } catch (err) {
      Get.snackbar('Error`', err.toString(), backgroundColor: Colors.redAccent);
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
      final response = await OfferService.instance.fetchMyBids(
        onFailure: () {
          isMyBidsLoading(false);
        }, queryParameters: {
          'days': days,
          'currency': currency,
      }
      );
      var data = response;
      var contents = data['content'];
      List<OfferEntity> fetchAllNegotiation = (contents as List)
          .map((json) => OfferEntity.fromJson(json)).toList();
      myBids.assignAll(fetchAllNegotiation);
    } catch (err) {
      Get.snackbar('Error`', err.toString(), backgroundColor: Colors.redAccent);
    } finally {
      isMyBidsLoading(false);
    }
  }

  Future<void> fetchMyOffersById({required String id, required VoidCallback onSuccess}) async {
    try {
      Get.snackbar('', 'Fetching data ...', backgroundColor: TColors.primary);
      final response = await OfferService.instance.fetchMyOffersById(
        id: id,
        onFailure: () {}
      );
      var item = response;
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
      Get.snackbar('Error`', err.toString(), backgroundColor: Colors.redAccent);
    } finally {
      Get.closeAllSnackbars();
    }
  }

  Future<void> fetchMyBidsById({required String id, required VoidCallback onSuccess}) async {
    try {
      Get.snackbar('', 'Fetching data ...', backgroundColor: TColors.primary);
      final response = await OfferService.instance.fetchMyBidsById(
        id: id,
        onFailure: () {}
      );
      var item = response;
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
      Get.snackbar('Error`', err.toString(), backgroundColor: Colors.redAccent);
    } finally {
      Get.closeAllSnackbars();
    }
  }

  Future<void> deleteOffer({required String id, required String currency, required String days}) async {
    print('Working');
    try {
      Get.snackbar('', 'Deleting offer ...', backgroundColor: TColors.primary);
      final response = await OfferService.instance.deleteOffer(
        id: id,
        onFailure: () {
          Get.closeAllSnackbars();
        }
      );
      print(response);
      await fetchMyOffers(days: days, currency: currency);
      Get.snackbar('Success', response.toString());
    } catch (e) {
      Get.snackbar('Error`', e.toString(), backgroundColor: Colors.redAccent);
    } finally {
      Get.closeAllSnackbars();
    }
  }

  Future<void> deleteBid({required String id, required String currency, required String days}) async {
    try {
      Get.snackbar('', 'Deleting bid ...', backgroundColor: TColors.primary);
      final response = await OfferService.instance.deleteBid(
          id: id,
          onFailure: () {
            Get.closeAllSnackbars();
          });
      await fetchMyBids(days: days, currency: currency);
      Get.snackbar('Success', response.toString());
    } catch (e) {
      Get.snackbar('Error`', e.toString(), backgroundColor: Colors.redAccent);
    } finally {
      Get.closeAllSnackbars();
    }
  }

  Future<void> fetchAllNegotiatedOffers() async {
    try {
      negotiatedOffers.isEmpty && isNegotiatedOfferLoading(true);
      final response = await OfferService.instance.fetchAllNegotiatedOffers(
        onFailure: () {
          isNegotiatedOfferLoading(false);
        }
      );
      var data = response;
      var contents = data['content'];
      List<OfferEntity> fetchAllNegotiation = (contents as List)
          .map((json) => OfferEntity.fromJson(json)).toList();
      negotiatedOffers.assignAll(fetchAllNegotiation);
      print('All negotiations fetched $negotiatedOffers');
    } catch (err) {
      Get.snackbar('Error`', err.toString(), backgroundColor: Colors.redAccent);
    } finally {
      isNegotiatedOfferLoading(false);
    }
  }

  void resetBoolOnOngoingRequest() {
    isMyBidsLoading.value = false;
    isMyOffersLoading.value = false;
    isNegotiatedOfferLoading.value = false;
  }

  void clearData() {
    myOfferById.value = OfferEntity();
    myBidById.value = OfferEntity();
    myOffers.clear();
    myBids.clear();
    myOfferIndex.value = 0;
    negotiatedOffers.clear();
  }

  @override
  void dispose() {
    requestCancelToken.cancel('Component disposed');
    super.dispose();
  }
}
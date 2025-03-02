import 'dart:async';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pouch/features/all_offer/apis/api.dart';
import 'package:pouch/features/all_offer/models/offer.dart';
import 'package:pouch/features/all_offer/models/offer_details_entity.dart';
import 'package:pouch/utils/shared/error_dialog_response.dart';
import '../screens/accept_offer_success_page.dart';
import '../screens/offer_details.dart';

class TradingOfferController extends GetxController {
  final CancelToken requestCancelToken = CancelToken();
  final isAcceptingRejectingOfferLoading = false.obs;
  final isSwappingLoading = false.obs;
  final isNegotiatingOfferLoading = false.obs;
  final showAcceptOfferMsg = false.obs;
  final showRejectOfferMsg = false.obs;
  var isFetchOfferByIdLoading = false.obs;
  final offerDetailsEntity = OfferDetailsEntity().obs;
  final offerById = OfferEntity().obs;

  @override
  void onClose() {
    offerDetailsEntity.value = OfferDetailsEntity();
    offerById.value = OfferEntity();
    super.onClose();
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
        data: {'negotiationAccepted': negotiationAccepted},
        onFailure: () {
          isAcceptingRejectingOfferLoading(false);
        }
      );
      var item = response;
      onSuccess();
    } catch (err) {
      showErrorAlertHelper(errorMessage: err.toString());
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
        },
        onFailure: () {
          isNegotiatingOfferLoading(false);
        }
      );
      var item = response;
      onSuccess();

    } catch (err) {
      showErrorAlertHelper(errorMessage: err.toString());
    } finally {
      isNegotiatingOfferLoading(false);
    }
  }

  Future<void> swappingOffer({
    required String id,
    required String amount,
    required String creditedCurrency
  }) async {
    try {
      isSwappingLoading(true);
      final response = await OfferService.instance.swappingOffer(
        id: id,
        onFailure: () {
          isSwappingLoading(false);
        }
      );
      Get.to(() => AcceptOfferSuccessPage(
        amount: amount,
        creditedCurrency: creditedCurrency,
      ));
    } catch (err) {
      showErrorAlertHelper(errorMessage: err.toString());
    } finally {
      isSwappingLoading(false);
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
      final response = await OfferService.instance.fetchOfferById(
          id: id,
          onFailure: () {
            isFetchOfferByIdLoading(false);
          }
      );
      print(response);
      var item = response;
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
      onSuccess();
    } catch (err) {
      showErrorAlertHelper(errorMessage: err.toString());
    } finally {
      isFetchOfferByIdLoading(false);
    }
  }

  void resetBoolForOutgoingRequests() {
    isAcceptingRejectingOfferLoading.value = false;
    isSwappingLoading.value = false;
    isNegotiatingOfferLoading.value = false;
    showAcceptOfferMsg.value = false;
    showRejectOfferMsg.value = false;
    isFetchOfferByIdLoading.value = false;
  }

  void clearData() {
    offerDetailsEntity.value = OfferDetailsEntity();
    offerById.value = OfferEntity();
  }

  @override
  void dispose() {
    requestCancelToken.cancel('Component disposed');
    super.dispose();
  }
}
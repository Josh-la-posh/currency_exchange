import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pouch/features/all_offer/apis/api.dart';
import 'package:pouch/features/all_offer/models/create_offer_response.dart';
import 'package:pouch/features/all_offer/models/offer.dart';
import 'package:pouch/features/all_offer/models/offer_details_entity.dart';
import 'package:pouch/utils/helpers/controller/helper_function_controller.dart';
import 'package:pouch/utils/responses/handleApiError.dart';
import 'package:pouch/utils/shared/error_dialog_response.dart';
import '../screens/accept_offer_success_page.dart';
import '../screens/offer_details.dart';

class TradingOfferController extends GetxController {
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
          data: {'negotiationAccepted': negotiationAccepted}
      );
      var item = response.data;
      if (response.statusCode == 200 || response.statusCode == 201) {
        onSuccess();
      }
    } catch (err) {
      showErrorAlertHelper(errorMessage: handleApiFormatError(err));
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
      showErrorAlertHelper(errorMessage: handleApiFormatError(err));
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
      final response = await OfferService.instance.swappingOffer(id: id);
      if (response.statusCode == 200 || response.statusCode == 201) {
        // await fetchAllOffers();
        Get.to(() => AcceptOfferSuccessPage(
          amount: amount,
          creditedCurrency: creditedCurrency,
        ));
      }
    } catch (err) {
      showErrorAlertHelper(errorMessage: handleApiFormatError(err));
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
      print(('I want to load offer'));
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
      // await fetchAllOffers();
      onSuccess();
    } catch (err) {
      showErrorAlertHelper(errorMessage: handleApiFormatError(err));
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
}
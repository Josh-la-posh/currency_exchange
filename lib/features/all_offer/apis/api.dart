import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:swappr/data/modules/dio.dart';
import 'package:swappr/data/provider/offer_provider.dart';
import 'package:swappr/features/all_offer/models/create_offer_response.dart';
import 'package:swappr/features/all_offer/models/negotiate_offer_entity.dart';
import 'package:swappr/features/all_offer/models/offer_details_entity.dart';
import 'package:swappr/features/all_offer/routes/names.dart';
import 'package:swappr/features/all_offer/screens/accept_offer_success_page.dart';
import 'package:swappr/features/all_offer/screens/offer_details.dart';
import 'package:swappr/utils/constants/enums.dart';
import 'package:swappr/utils/responses/error_dialog.dart';
import 'package:swappr/utils/responses/handleApiError.dart';
import 'package:swappr/utils/shared/notification/snackbar.dart';

import '../../../data/modules/app_navigator.dart';
import '../models/negotiate_offer_model.dart';
import '../models/offer.dart';

class OfferService {
  static final OfferService _instance = OfferService._();

  OfferService._();

  static OfferService get instance => _instance;

  // post requests
  
  Future _createOffer(Object data) {
    return apiService.post('/offer/create', data: data);
  }

  Future _acceptRejectOffer({
    required String id,
    required Object data
  }) {
    return apiService.post('/offer/accept-reject/$id', data: data);
  }

  Future _negotiateOffer({
    required String id,
    required Object data
  }) {
    return apiService.post('/offer/negotiate/$id', data: data
    );
  }

  Future _swapOffer({required String id}) {
    return apiService.post('/offer/swap/$id');
  }


  // get requests

  Future _getAllOffers(String currency, String date) {
    return apiService.get('/offer', queryParameters: {'currency': currency, 'date': date});
  }

  Future _getOfferById(String id) {
    return apiService.get('/offer/$id');
  }

  Future _getAllNegotiatedOffers() {
    return apiService.get('/offer/negotiate/negotiated-offers');
  }

  // Creating an offer

  createOffer({
    required OfferProvider offerProvider,
    required String debitedCurrency,
    required String creditedCurrency,
    required int amount,
    required int rate,
    required int expireIn,
  }) {
    _createOffer({
      "debitedCurrency": debitedCurrency,
      "creditedCurrency": creditedCurrency,
      "amount": amount,
      "rate": rate,
      "expireIn": expireIn
    }).then((response) async {
      var item = response.data;

      CreateOfferResponse offerResponse = CreateOfferResponse(
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
      );
      offerProvider.saveOfferResponse(offerResponse);

      await getAllOffers(offerProvider: offerProvider, currency: '', date: '');
      offerProvider.resetCreateOfferDetails();
      AppNavigator.instance
          .removeAllNavigateToNavHandler(CREATE_SUCCESS_SCREEN);
    }).catchError((error) {
      handleShowCustomToast(message: handleApiFormatError(error));
    });
  }

  // Accepting and rejecting an offer

  acceptRejectOffer({
    required String id,
    required bool negotiationAccepted,
    required OfferProvider offerProvider,
    required VoidCallback onSuccess
  }) {
    _acceptRejectOffer(
        id: id,
        data: {'negotiationAccepted': negotiationAccepted}
    ).then((response) async {
      print(response.data);
      await getAllNegotiatedOOffers(offerProvider: offerProvider);
      await getAllOffers(offerProvider: offerProvider, currency: '', date: '');
      onSuccess();
    }).catchError((error) {
      print(error.toString());
      handleShowCustomToast(message: handleApiFormatError(error));
    });
  }

  // Negotiating an offer

  negotiateOffer({
    required String id,
    required int negotiatorRate,
    required int negotiatorAmount,
    required OfferProvider offerProvider
  }) {
    _negotiateOffer(
        id: id,
        data: {
          'negotiatorRate': negotiatorRate,
          'negotiatorAmount': negotiatorAmount})
    .then((response) async {
      await getAllOffers(offerProvider: offerProvider, currency: '', date: '');
      await getAllNegotiatedOOffers(offerProvider: offerProvider);
      AppNavigator.instance
          .removeAllNavigateToNavHandler(CREATE_SUCCESS_SCREEN);
    }).catchError((error) {
      showErrorAlertHelper(errorMessage: handleApiFormatError(error));
    });
  }

  // Swapping an offer

  swapOffer({
    required String id,
    required OfferProvider offerProvider,
    required String amount,
    required String creditedCurrency

  }) {
    _swapOffer(id: id).then((response) async {
      await getAllOffers(offerProvider: offerProvider, currency: '', date: '');
      Get.to(() => AcceptOfferSuccessPage(
        amount: amount,
        creditedCurrency: creditedCurrency,
      ));
      // AppNavigator.instance
      //     .removeAllNavigateToNavHandler(ACCEPT_SUCCESS_SCREEN);
    }).catchError((error) {
      showErrorAlertHelper(errorMessage: handleApiFormatError(error));
    });
  }


  getAllOffers({
    required OfferProvider offerProvider,
    required String currency,
    required String date
  }) {
    List<OfferEntity> offers = [];

    _getAllOffers(currency, date).then((response) {
      var data = response.data;

      OfferDetailsEntity offerDetails = OfferDetailsEntity(
          totalPages: data['totalPages'],
          payloadSize: data['payloadSize'],
          hasNext: data['hasNext'],
          content: data['content'],
          currentPage: data['currentPage'],
          skippedRecords: data['skippedRecords'],
          totalRecords: data['totalRecords']
      );
        offerProvider.saveOfferDetails(offerDetails);

        var content = offerDetails.content;


        for (var item in content) {
          offers.add(OfferEntity(
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
          offerProvider.saveOffers(offers);
        }

    });
  }

  getOfferById({
    required OfferProvider offerProvider,
    required String id,
    VoidCallback? onTap
  }) async {
    await _getOfferById(id).then((response) {
      var item = response.data;

      OfferEntity offerDetails = OfferEntity(
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
      );
      offerProvider.saveOffersById(offerDetails);
    });
    await getAllOffers(offerProvider: offerProvider, currency: '', date: '');

    Get.to(() => OfferDetailsScreen(onTap: onTap,));
  }


  getAllNegotiatedOOffers({
    required OfferProvider offerProvider,
  }) {
    List<NegotiateOfferModel> negotiations = [];

    _getAllNegotiatedOffers().then((response) {
      var data = response.data;

      NegotiatedOffersEntity negotiatedOffers = NegotiatedOffersEntity(
          totalPages: data['totalPages'],
          payloadSize: data['payloadSize'],
          hasNext: data['hasNext'],
          content: data['content'],
          currentPage: data['currentPage'],
          skippedRecords: data['skippedRecords'],
          totalRecords: data['totalRecords']
      );

      var content = negotiatedOffers.content;

      for (var item in content) {
        negotiations.add(NegotiateOfferModel(
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
            lastModifiedDate: item['lastModifiedDate']
        ));
        offerProvider.saveNegotiations(negotiations);
      }

    });
  }




}
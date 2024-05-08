import 'package:flutter/material.dart';
import 'package:swappr/data/modules/dio.dart';
import 'package:swappr/data/provider/offer_provider.dart';
import 'package:swappr/features/home/models/offer_details_entity.dart';
import 'package:swappr/features/home/routes/names.dart';
import 'package:swappr/utils/responses/error_dialog.dart';
import 'package:swappr/utils/responses/handleApiError.dart';

import '../../../data/modules/app_navigator.dart';
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
      await getAllOffers(offerProvider: offerProvider, currency: '', date: '');
      print('create offer ${response.data}');

      AppNavigator.instance
          .removeAllNavigateToNavHandler(CREATE_SUCCESS_SCREEN);

      // Get.to(()=> const CreateOfferSuccessPage(
      //
      // ));
    }).catchError((error) {
      showErrorAlertHelper(errorMessage: handleApiFormatError(error));
    });
  }

  // Accepting and rejecting an offer

  acceptRejectOffer({
    required String id,
    required bool negotiationAccepted
  }) {
    _acceptRejectOffer(
        id: id,
        data: {{'negotiationAccepted': negotiationAccepted}}).then((response) {
      print('create offer ${response.data}');
    }).catchError((error) {
      showErrorAlertHelper(errorMessage: handleApiFormatError(error));
    });
  }

  // Negotiating an offer

  negotiateOffer({
    required String id,
    required int negotiatorRate,
    required int negotiatorAmount
  }) {
    _negotiateOffer(
        id: id,
        data: {
          'negotiatorRate': negotiatorRate,
          'negotiatorAmount': negotiatorAmount})
    .then((response) {
      print('create offer ${response.data}');
    }).catchError((error) {
      showErrorAlertHelper(errorMessage: handleApiFormatError(error));
    });
  }

  // Swapping an offer

  swapOffer({required String id}) {
    _swapOffer(id: id).then((response) {
      print('create offer ${response.data}');
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
        }
        offerProvider.saveOffers(offers);

    });
  }




}
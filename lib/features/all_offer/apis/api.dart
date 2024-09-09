import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:pouch/data/modules/background_task.dart';
import 'package:pouch/data/provider/offer_provider.dart';
import 'package:pouch/data/provider/transaction_provider.dart';
import 'package:pouch/features/all_offer/models/create_offer_response.dart';
import 'package:pouch/features/all_offer/models/negotiate_offer_entity.dart';
import 'package:pouch/features/all_offer/models/offer_details_entity.dart';
import 'package:pouch/features/all_offer/routes/names.dart';
import 'package:pouch/features/all_offer/screens/accept_offer_success_page.dart';
import 'package:pouch/features/all_offer/screens/offer_details.dart';
import 'package:pouch/utils/responses/error_dialog.dart';
import 'package:pouch/utils/responses/handleApiError.dart';
import 'package:pouch/utils/shared/notification/snackbar.dart';

import '../../../data/modules/app_navigator.dart';
import '../../../data/modules/interceptor.dart';
import '../../../data/provider/wallet_provider.dart';
import '../models/offer.dart';

const OFFER_URL = '/offer';
const CREATE_OFFER_URL = 'create';
const ACCEPT_REJECT_OFFER_URL = 'accept-reject';
const NEGOTIATE_OFFER_URL = 'negotiate';
const SWAP_OFFER_URL = 'swap';
const ALL_NEGOTIATED_OFFER_URL = 'negotiate/negotiated-offers';
const MY_OFFER_URL = 'me/my-offer';
const MY_OFFERS_URL = 'me/my-offers';
const MY_BIDS_URL = 'me/my-bids';
const MY_BID_URL = 'me/my-bid';

final _apiService = AppInterceptor(showLoader: false).dio;
final apiService = AppInterceptor(showLoader: true).dio;

class OfferService {
  static final OfferService _instance = OfferService._();

  OfferService._();

  static OfferService get instance => _instance;

  // post requests

  Future creatingOffer(Map<String, dynamic> queryParameters) async {
    try {
      final response = await _apiService.post('$OFFER_URL/$CREATE_OFFER_URL', data: queryParameters);
      return response;
    } catch (e) {
      Get.snackbar('Error', handleApiFormatError(e), backgroundColor: Colors.redAccent);
    }
  }

  Future acceptingOrRejectingOffer({required String id, required Object data}) async {
    try {
      final response = await _apiService.post('$OFFER_URL/$ACCEPT_REJECT_OFFER_URL/$id', data: data);
      return response;
    } catch (e) {
      Get.snackbar('Error', handleApiFormatError(e), backgroundColor: Colors.redAccent);
    }
  }

  Future negotiatingOffer({required String id, required Object data}) async {
    try {
      final response = await _apiService.post('$OFFER_URL/$NEGOTIATE_OFFER_URL/$id', data: data);
      return response;
    } catch (e) {
      Get.snackbar('Error', handleApiFormatError(e), backgroundColor: Colors.redAccent);
    }
  }

  Future swappingOffer({required String id}) async {
    try {
      final response = await _apiService.post('$OFFER_URL/$SWAP_OFFER_URL/$id');
      return response;
    } catch (e) {
      Get.snackbar('Error', handleApiFormatError(e), backgroundColor: Colors.redAccent);
    }
  }

  Future fetchAllOffers(Map<String, dynamic> queryParameters) async {
    try {
      final response = await _apiService.get('$OFFER_URL', queryParameters: queryParameters);
      return response;
    } catch (e) {
      Get.snackbar('Error', handleApiFormatError(e), backgroundColor: Colors.redAccent);
    }
  }

  Future fetchOfferById(String id) async {
    try {
      final response = await _apiService.get('$OFFER_URL/$id',);
      return response;
    } catch (e) {
      Get.snackbar('Error', handleApiFormatError(e), backgroundColor: Colors.redAccent);
    }
  }

  Future fetchAllNegotiatedOffers() async {
    try {
      final response = await _apiService.get('$OFFER_URL/$ALL_NEGOTIATED_OFFER_URL');
      return response;
    } catch (e) {
      Get.snackbar('Error', handleApiFormatError(e), backgroundColor: Colors.redAccent);
    }
  }

  Future fetchMyOffers(String days, String currency) async {
    try {
      final response = await _apiService.get('$OFFER_URL/$MY_OFFERS_URL', queryParameters: {'days': days, 'currency': currency});
      return response;
    } catch (e) {
      Get.snackbar('Error', handleApiFormatError(e), backgroundColor: Colors.redAccent);
    }
  }

  Future fetchMyBids(String days, String currency) async {
    try {
      final response = await _apiService.get('$OFFER_URL/$MY_BIDS_URL', queryParameters: {'days': days, 'currency': currency});
      return response;
    } catch (e) {
      Get.snackbar('Error', handleApiFormatError(e), backgroundColor: Colors.redAccent);
    }
  }

  Future fetchMyOffersById(String id) async {
    try {
      final response = await _apiService.get('$OFFER_URL/$MY_OFFER_URL/$id');
      return response;
    } catch (e) {
      Get.snackbar('Error', handleApiFormatError(e), backgroundColor: Colors.redAccent);
    }
  }

  Future fetchMyBidsById(String id) async {
    try {
      final response = await _apiService.get('$OFFER_URL/$MY_BID_URL/$id');
      return response;
    } catch (e) {
      Get.snackbar('Error', handleApiFormatError(e), backgroundColor: Colors.redAccent);
    }
  }

  Future deleteOffer(String id) async {
    try {
      final response = await _apiService.delete('$OFFER_URL/$id');
      return response;
    } catch (e) {
      Get.snackbar('Error', handleApiFormatError(e), backgroundColor: Colors.redAccent);
    }
  }

  Future deleteBid(String id) async {
    try {
      final response = await _apiService.delete('$OFFER_URL/bid/$id');
      return response;
    } catch (e) {
      Get.snackbar('Error', handleApiFormatError(e), backgroundColor: Colors.redAccent);
    }
  }











  
  Future _createOffer(Map<String, dynamic> queryParameters) {
    return apiService.post('/offer/create', data: queryParameters);
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
    return apiService.get('/offer', queryParameters: {'currency': currency, 'days': date});
  }

  Future _getOfferById(String id) {
    return apiService.get('/offer/$id');
  }

  Future _getAllNegotiatedOffers() {
    return apiService.get('/offer/negotiate/negotiated-offers');
  }

  Future _getMyOffers(String days, String currency) {
    return apiService.get('/offer/me/my-offers', queryParameters: {'days': days, 'currency': currency});
  }

  Future _getMyBids(String days, String currency) {
    return apiService.get('/offer/me/my-bids', queryParameters: {'days': days, 'currency': currency});
  }

  Future _getMyOfferById(String id) {
    return apiService.get('/offer/me/my-offer/$id');
  }

  Future _getMyBidsById(String id) {
    return apiService.get('/offer/me/my-bid/$id');
  }

  // Creating an offer

  createOffer({
    required OfferProvider offerProvider,
    required String debitedCurrency,
    required String creditedCurrency,
    required String amount,
    required String rate,
    String? expireIn,
  }) {

    final queryParameters = <String, dynamic>{};
    queryParameters['debitedCurrency'] = debitedCurrency;
    queryParameters['creditedCurrency'] = creditedCurrency;
    queryParameters['amount'] = amount;
    queryParameters['rate'] = rate;
    queryParameters['expireIn'] = expireIn != 'Never' ? int.parse(expireIn.toString()) : 0;

    _createOffer(queryParameters).then((response) async {
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

      // await getAllOffers(offerProvider: offerProvider, currency: '', date: '');
      await NoLoaderService.instance.getAllOffers(offerProvider: offerProvider, onFailure: (){}, onSuccess: (){});
      await NoLoaderService.instance.getUsdOffers(offerProvider: offerProvider, onFailure: (){}, onSuccess: (){});
      await NoLoaderService.instance.getNgnOffers(offerProvider: offerProvider, onFailure: (){}, onSuccess: (){});
      await NoLoaderService.instance.getGbpOffers(offerProvider: offerProvider, onFailure: (){}, onSuccess: (){});
      await NoLoaderService.instance.getCadOffers(offerProvider: offerProvider, onFailure: (){}, onSuccess: (){});
      await NoLoaderService.instance.getEurOffers(offerProvider: offerProvider, onFailure: (){}, onSuccess: (){});
      await NoLoaderService.instance.getAllNewOffers(offerProvider: offerProvider, onSuccess: (){}, onFailure: (){});
      await NoLoaderService.instance.getUsdNewOffers(offerProvider: offerProvider, onSuccess: (){}, onFailure: (){});
      await NoLoaderService.instance.getNgnNewOffers(offerProvider: offerProvider, onSuccess: (){}, onFailure: (){});
      await NoLoaderService.instance.getGbpNewOffers(offerProvider: offerProvider, onSuccess: (){}, onFailure: (){});
      await NoLoaderService.instance.getCadNewOffers(offerProvider: offerProvider, onSuccess: (){}, onFailure: (){});
      await NoLoaderService.instance.getEurNewOffers(offerProvider: offerProvider, onSuccess: (){}, onFailure: (){});
      await NoLoaderService.instance.getAllTrendingOffers(offerProvider: offerProvider, onSuccess: (){}, onFailure: (){});
      await NoLoaderService.instance.getUsdTrendingOffers(offerProvider: offerProvider, onSuccess: (){}, onFailure: (){});
      await NoLoaderService.instance.getNgnTrendingOffers(offerProvider: offerProvider, onSuccess: (){}, onFailure: (){});
      await NoLoaderService.instance.getGbpTrendingOffers(offerProvider: offerProvider, onSuccess: (){}, onFailure: (){});
      await NoLoaderService.instance.getCadTrendingOffers(offerProvider: offerProvider, onSuccess: (){}, onFailure: (){});
      await NoLoaderService.instance.getEurTrendingOffers(offerProvider: offerProvider, onSuccess: (){}, onFailure: (){});
      offerProvider.resetCreateOfferDetails();
      AppNavigator.instance
          .removeAllNavigateToNavHandler(CREATE_SUCCESS_SCREEN);
    }).catchError((error) {
      print('new error ${error.toString()}');
      handleShowCustomToast(message: handleApiFormatError(error));
    });
  }

  // Accepting and rejecting an offer

  acceptRejectOffer({
    required String id,
    required bool negotiationAccepted,
    required OfferProvider offerProvider,
    required WalletProvider walletProvider,
    required TransactionProvider transactionProvider,
    required VoidCallback onSuccess
  }) {
    _acceptRejectOffer(
        id: id,
        data: {'negotiationAccepted': negotiationAccepted}
    ).then((response) async {
      await getAllNegotiatedOOffers(offerProvider: offerProvider);
      await NoLoaderService.instance.getAllOffers(offerProvider: offerProvider, onFailure: (){}, onSuccess: (){});
      await NoLoaderService.instance.getUsdOffers(offerProvider: offerProvider, onFailure: (){}, onSuccess: (){});
      await NoLoaderService.instance.getNgnOffers(offerProvider: offerProvider, onFailure: (){}, onSuccess: (){});
      await NoLoaderService.instance.getGbpOffers(offerProvider: offerProvider, onFailure: (){}, onSuccess: (){});
      await NoLoaderService.instance.getCadOffers(offerProvider: offerProvider, onFailure: (){}, onSuccess: (){});
      await NoLoaderService.instance.getEurOffers(offerProvider: offerProvider, onFailure: (){}, onSuccess: (){});
      await NoLoaderService.instance.getAllNewOffers(offerProvider: offerProvider, onSuccess: (){}, onFailure: (){});
      await NoLoaderService.instance.getUsdNewOffers(offerProvider: offerProvider, onSuccess: (){}, onFailure: (){});
      await NoLoaderService.instance.getNgnNewOffers(offerProvider: offerProvider, onSuccess: (){}, onFailure: (){});
      await NoLoaderService.instance.getGbpNewOffers(offerProvider: offerProvider, onSuccess: (){}, onFailure: (){});
      await NoLoaderService.instance.getCadNewOffers(offerProvider: offerProvider, onSuccess: (){}, onFailure: (){});
      await NoLoaderService.instance.getEurNewOffers(offerProvider: offerProvider, onSuccess: (){}, onFailure: (){});
      await NoLoaderService.instance.getAllTrendingOffers(offerProvider: offerProvider, onSuccess: (){}, onFailure: (){});
      await NoLoaderService.instance.getUsdTrendingOffers(offerProvider: offerProvider, onSuccess: (){}, onFailure: (){});
      await NoLoaderService.instance.getNgnTrendingOffers(offerProvider: offerProvider, onSuccess: (){}, onFailure: (){});
      await NoLoaderService.instance.getGbpTrendingOffers(offerProvider: offerProvider, onSuccess: (){}, onFailure: (){});
      await NoLoaderService.instance.getCadTrendingOffers(offerProvider: offerProvider, onSuccess: (){}, onFailure: (){});
      await NoLoaderService.instance.getEurTrendingOffers(offerProvider: offerProvider, onSuccess: (){}, onFailure: (){});
      await NoLoaderService.instance.getWallets(walletProvider: walletProvider, currency: '', transactionProvider: transactionProvider);
      onSuccess();
    }).catchError((error) {
      print(error.toString());
      handleShowCustomToast(message: handleApiFormatError(error));
    });
  }

  // Negotiating an offer

  negotiateOffer({
    required String id,
    required String negotiatorRate,
    required String negotiatorAmount,
    required OfferProvider offerProvider,
    required VoidCallback onSuccess,
    required VoidCallback onFailure,
  }) {
    _negotiateOffer(
        id: id,
        data: {
          'negotiatorRate': negotiatorRate,
          'negotiatorAmount': negotiatorAmount})
    .then((response) async {
      await NoLoaderService.instance.getAllOffers(offerProvider: offerProvider, onFailure: (){}, onSuccess: (){});
      await NoLoaderService.instance.getUsdOffers(offerProvider: offerProvider, onFailure: (){}, onSuccess: (){});
      await NoLoaderService.instance.getNgnOffers(offerProvider: offerProvider, onFailure: (){}, onSuccess: (){});
      await NoLoaderService.instance.getGbpOffers(offerProvider: offerProvider, onFailure: (){}, onSuccess: (){});
      await NoLoaderService.instance.getCadOffers(offerProvider: offerProvider, onFailure: (){}, onSuccess: (){});
      await NoLoaderService.instance.getEurOffers(offerProvider: offerProvider, onFailure: (){}, onSuccess: (){});
      await NoLoaderService.instance.getAllNewOffers(offerProvider: offerProvider, onSuccess: (){}, onFailure: (){});
      await NoLoaderService.instance.getUsdNewOffers(offerProvider: offerProvider, onSuccess: (){}, onFailure: (){});
      await NoLoaderService.instance.getNgnNewOffers(offerProvider: offerProvider, onSuccess: (){}, onFailure: (){});
      await NoLoaderService.instance.getGbpNewOffers(offerProvider: offerProvider, onSuccess: (){}, onFailure: (){});
      await NoLoaderService.instance.getCadNewOffers(offerProvider: offerProvider, onSuccess: (){}, onFailure: (){});
      await NoLoaderService.instance.getEurNewOffers(offerProvider: offerProvider, onSuccess: (){}, onFailure: (){});
      await NoLoaderService.instance.getAllTrendingOffers(offerProvider: offerProvider, onSuccess: (){}, onFailure: (){});
      await NoLoaderService.instance.getUsdTrendingOffers(offerProvider: offerProvider, onSuccess: (){}, onFailure: (){});
      await NoLoaderService.instance.getNgnTrendingOffers(offerProvider: offerProvider, onSuccess: (){}, onFailure: (){});
      await NoLoaderService.instance.getGbpTrendingOffers(offerProvider: offerProvider, onSuccess: (){}, onFailure: (){});
      await NoLoaderService.instance.getCadTrendingOffers(offerProvider: offerProvider, onSuccess: (){}, onFailure: (){});
      await NoLoaderService.instance.getEurTrendingOffers(offerProvider: offerProvider, onSuccess: (){}, onFailure: (){});
      await getAllNegotiatedOOffers(offerProvider: offerProvider);
      Future.delayed(
          Duration(seconds: 2),
              () => onSuccess()
      );
      Future.delayed(
        Duration(seconds: 3),
          () => handleShowCustomToast(message: 'Your bid has been created successfully!!!')
      );
    }).catchError((error) {
      onFailure();
      showErrorAlertHelper(errorMessage: handleApiFormatError(error));
    });
  }

  // Swapping an offer

  swapOffer({
    required String id,
    required OfferProvider offerProvider,
    required TransactionProvider transactionProvider,
    required WalletProvider walletProvider,
    required String amount,
    required String creditedCurrency

  }) {
    _swapOffer(id: id).then((response) async {
      await NoLoaderService.instance.getAllOffers(offerProvider: offerProvider, onFailure: (){}, onSuccess: (){});
      await NoLoaderService.instance.getUsdOffers(offerProvider: offerProvider, onFailure: (){}, onSuccess: (){});
      await NoLoaderService.instance.getNgnOffers(offerProvider: offerProvider, onFailure: (){}, onSuccess: (){});
      await NoLoaderService.instance.getGbpOffers(offerProvider: offerProvider, onFailure: (){}, onSuccess: (){});
      await NoLoaderService.instance.getCadOffers(offerProvider: offerProvider, onFailure: (){}, onSuccess: (){});
      await NoLoaderService.instance.getEurOffers(offerProvider: offerProvider, onFailure: (){}, onSuccess: (){});
      await NoLoaderService.instance.getAllNewOffers(offerProvider: offerProvider, onSuccess: (){}, onFailure: (){});
      await NoLoaderService.instance.getUsdNewOffers(offerProvider: offerProvider, onSuccess: (){}, onFailure: (){});
      await NoLoaderService.instance.getNgnNewOffers(offerProvider: offerProvider, onSuccess: (){}, onFailure: (){});
      await NoLoaderService.instance.getGbpNewOffers(offerProvider: offerProvider, onSuccess: (){}, onFailure: (){});
      await NoLoaderService.instance.getCadNewOffers(offerProvider: offerProvider, onSuccess: (){}, onFailure: (){});
      await NoLoaderService.instance.getEurNewOffers(offerProvider: offerProvider, onSuccess: (){}, onFailure: (){});
      await NoLoaderService.instance.getAllTrendingOffers(offerProvider: offerProvider, onSuccess: (){}, onFailure: (){});
      await NoLoaderService.instance.getUsdTrendingOffers(offerProvider: offerProvider, onSuccess: (){}, onFailure: (){});
      await NoLoaderService.instance.getNgnTrendingOffers(offerProvider: offerProvider, onSuccess: (){}, onFailure: (){});
      await NoLoaderService.instance.getGbpTrendingOffers(offerProvider: offerProvider, onSuccess: (){}, onFailure: (){});
      await NoLoaderService.instance.getCadTrendingOffers(offerProvider: offerProvider, onSuccess: (){}, onFailure: (){});
      await NoLoaderService.instance.getEurTrendingOffers(offerProvider: offerProvider, onSuccess: (){}, onFailure: (){});
      await NoLoaderService.instance.getTransactions(transactionProvider: transactionProvider);
      await NoLoaderService.instance.getWallets(walletProvider: walletProvider, currency: '', transactionProvider: transactionProvider);
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

        for (var item in content!) {
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

    Get.to(() => OfferDetailsScreen());
  }


  getAllNegotiatedOOffers({
    required OfferProvider offerProvider,
  }) {
    List<OfferEntity> negotiations = [];

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
        negotiations.add(OfferEntity(
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
        offerProvider.saveNegotiations(negotiations);
      }
    });
  }

  getMyOffers({
    required OfferProvider offerProvider,
    required String days,
    required String currency
  }) {
    List<OfferEntity> negotiations = [];

    _getMyOffers(days, currency).then((response) {
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
        negotiations.add(OfferEntity(
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
        offerProvider.saveMyOffers(negotiations);
      }

    });
  }

  getMyBids({
    required OfferProvider offerProvider,
    required String days,
    required String currency
  }) {
    List<OfferEntity> negotiations = [];

    _getMyBids(days, currency).then((response) {
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
        negotiations.add(OfferEntity(
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
        offerProvider.saveMyOffers(negotiations);
      }


      print('value ${content.length}');

    }).catchError((error) {
      print('newly found error $error');
    });
  }

  getMyBidsById({
    required OfferProvider offerProvider,
    required String id
  }) {
    _getMyBidsById(id).then((response) {
      var item = response.data;

      OfferEntity myBid = OfferEntity(
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
      offerProvider.saveMyBid(myBid);
    }).catchError((error) {
      print('newly found error $error');
    });
  }




}
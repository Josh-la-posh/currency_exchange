import 'package:flutter/material.dart';
import 'package:pouch/data/modules/interceptor.dart';
import 'package:pouch/data/provider/auth_provider.dart';
import 'package:pouch/features/authentication/models/user_model.dart';
import 'package:pouch/features/notification/model/get_user_notification.dart';

import '../../features/all_offer/models/negotiate_offer_entity.dart';
import '../../features/all_offer/models/negotiate_offer_model.dart';
import '../../features/all_offer/models/offer.dart';
import '../../features/all_offer/models/offer_details_entity.dart';
import '../../features/subscription/models/subscribeEnity.dart';
import '../../features/subscription/models/subscription_details.dart';
import '../../features/transaction/models/transaction_details_entity.dart';
import '../../features/transaction/models/transaction_entity.dart';
import '../../features/wallet/models/bank_list.dart';
import '../../features/wallet/models/bank_list_entity.dart';
import '../../features/wallet/models/default_wallet_model.dart';
import '../../features/wallet/models/get_bank_account.dart';
import '../../features/wallet/models/get_wallet.dart';
import '../../utils/responses/handleApiError.dart';
import '../../utils/shared/notification/snackbar.dart';
import '../provider/notificaton_provider.dart';
import '../provider/offer_provider.dart';
import '../provider/subscription_provider.dart';
import '../provider/transaction_provider.dart';
import '../provider/wallet_provider.dart';
import 'dio.dart';

final _apiService = AppInterceptor(showLoader: false).dio;

handleBackgroundAppRequest({
  required UserModel user,
  required AuthProvider authProvider,
  required WalletProvider walletProvider,
  required TransactionProvider transactionProvider,
  required OfferProvider offerProvider,
  required SubscriptionProvider subscriptionProvider,
  required NotificationProvider notificationProvider
}) async {
  NoLoaderService.instance.getAllOffers(offerProvider: offerProvider, onSuccess: (){}, onFailure: (){});
  NoLoaderService.instance.getMyBids(offerProvider: offerProvider, days: '', currency: '', onSuccess: (){}, onFailure: (){});
  NoLoaderService.instance.getMyOffers(offerProvider: offerProvider, days: '', currency: '', onSuccess: () {}, onFailure: () {});
  NoLoaderService.instance.getWallets(walletProvider: walletProvider, currency: '', transactionProvider: transactionProvider);
  NoLoaderService.instance.getDefaultWallet(walletProvider: walletProvider, transactionProvider: transactionProvider);
  NoLoaderService.instance.getBankList(walletProvider: walletProvider);
  NoLoaderService.instance.getLocalBank(walletProvider: walletProvider);
  NoLoaderService.instance.getSubscriptions(provider: subscriptionProvider, currency: '', onSuccess: (){});
  NoLoaderService.instance.getTransactions(transactionProvider: transactionProvider);
  NoLoaderService.instance.getUserNotification(provider: notificationProvider, onSuccess: () {});
}

class NoLoaderService {
  static final NoLoaderService _instance = NoLoaderService._();
  NoLoaderService._();
  static NoLoaderService get instance => _instance;

  // offer service
  Future _getAllOffers(Map<String, dynamic> queryParameters) {
    return _apiService.get(
        '/offer',
        queryParameters: queryParameters);
  }

  Future _getOfferById(String id) {
    return _apiService.get('/offer/$id');
  }

  Future _getAllNegotiatedOffers() {
    return _apiService.get('/offer/negotiate/negotiated-offers');
  }

  Future _getMyOffers(String days, String currency) {
    return _apiService.get('/offer/me/my-offers', queryParameters: {"status": '', 'days': days, 'currency': currency});
  }

  Future _getMyBids(String days, String currency) {
    return _apiService.get('/offer/me/my-bids', queryParameters: {"status": '', 'days': days, 'currency': currency});
  }

  Future _deleteOffer(String id) {return _apiService.delete('/offer/$id');}

  Future _deleteBid(String id) {return _apiService.delete('/offer/bid/$id');}
  
  
  // subscription service

  Future _getSubscriptions(String currency) {
    return _apiService.get('/subscription', queryParameters: {'currency': currency});
  }

  Future _deleteSubscriptions(String id) {return _apiService.delete('/subscription/$id');}

  
  // transaction service

  Future _transactions(){return _apiService.get('/transaction',);}

  Future _transaction({required String id}){return _apiService.get('/transaction/$id',);}
  
  
  
  // wallet services

  Future _defaultWallet(Object data) {
    return _apiService.post('/wallet/default-wallet', data: data);
  }

  Future _getWallet({required String currency}) {
    return _apiService.get('/wallet/get-wallets',
        queryParameters: {'currency': currency}
    );
  }

  Future _getDefaultWallet() {
    return _apiService.get('/wallet/user-default-wallet');
  }

  Future _getFcyAccounts({required String currency}) {
    return _apiService.get('/wallet/fcy-accounts',
        queryParameters: {'currency': currency});
  }

  Future _getFcyRates({required String currency}) {
    return _apiService.get('/wallet/fcy-rates',
        queryParameters: {'currency': currency});
  }

  Future _getLocalBank() {
    return _apiService.get('/wallet/get-local-bank');
  }

  Future _getBankList() {return _apiService.get('/wallet/list-banks');}


  // Notification

  Future _getUserNotifications() {
    return _apiService.get('/notification/user/notifications');
  }

  Future _getNotificationsId(String id) {
    return _apiService.get('/notification/user/notifications/$id');
  }



  
  // offers function

  // All

  getAllOffers({
    required OfferProvider offerProvider,
    required VoidCallback onSuccess,
    required VoidCallback onFailure,
  }) {

    final queryParameters = <String, dynamic>{};
    queryParameters['sortByAmount'] = 'sortByAmount';
    List<OfferEntity> offers = [];

    _getAllOffers(queryParameters).then((response) {
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
        offerProvider.saveAllOffers(offers);
      }

      onSuccess();

    }).catchError((error) {
      onFailure();
      print(error);
    });
  }

  getAllNewOffers({
    required OfferProvider offerProvider,
    required VoidCallback onSuccess,
    required VoidCallback onFailure,
  }) {

    final queryParameters = <String, dynamic>{};
    List<OfferEntity> offers = [];

    _getAllOffers(queryParameters).then((response) {
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
        offerProvider.saveAllNewOffers(offers);
      }

      onSuccess();

    }).catchError((error) {
      onFailure();
    });
  }

  getAllTrendingOffers({
    required OfferProvider offerProvider,
    required VoidCallback onSuccess,
    required VoidCallback onFailure,
  }) {

    final queryParameters = <String, dynamic>{};
    queryParameters['trending'] = 'trending';
    List<OfferEntity> offers = [];

    _getAllOffers(queryParameters).then((response) {
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
        offerProvider.saveAllTrendingOffers(offers);
      }
      onSuccess();

    }).catchError((error) {
      onFailure();
    });
  }

  // usd

  getUsdOffers({
    required OfferProvider offerProvider,
    required VoidCallback onSuccess,
    required VoidCallback onFailure,
  }) {

    final queryParameters = <String, dynamic>{};
    queryParameters['sortByAmount'] = 'sortByAmount';
    queryParameters['currency'] = 'USD';
    List<OfferEntity> offers = [];

    _getAllOffers(queryParameters).then((response) {
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
        offerProvider.saveUsdOffers(offers);
      }

      onSuccess();

    }).catchError((error) {
      onFailure();
    });
  }

  getUsdNewOffers({
    required OfferProvider offerProvider,
    required VoidCallback onSuccess,
    required VoidCallback onFailure,
  }) {

    final queryParameters = <String, dynamic>{};
    queryParameters['currency'] = 'USD';
    List<OfferEntity> offers = [];

    _getAllOffers(queryParameters).then((response) {
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
        offerProvider.saveUsdNewOffers(offers);
      }

      onSuccess();

    }).catchError((error) {
      onFailure();
    });
  }

  getUsdTrendingOffers({
    required OfferProvider offerProvider,
    required VoidCallback onSuccess,
    required VoidCallback onFailure,
  }) {

    final queryParameters = <String, dynamic>{};
    queryParameters['trending'] = 'trending';
    queryParameters['currency'] = 'USD';
    List<OfferEntity> offers = [];

    _getAllOffers(queryParameters).then((response) {
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
        offerProvider.saveUsdTrendingOffers(offers);
      }
      onSuccess();

    }).catchError((error) {
      onFailure();
    });
  }

  // usd

  getNgnOffers({
    required OfferProvider offerProvider,
    required VoidCallback onSuccess,
    required VoidCallback onFailure,
  }) {

    final queryParameters = <String, dynamic>{};
    queryParameters['sortByAmount'] = 'sortByAmount';
    queryParameters['currency'] = 'NGN';
    List<OfferEntity> offers = [];

    _getAllOffers(queryParameters).then((response) {
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
        offerProvider.saveNgnOffers(offers);
      }

      onSuccess();

    }).catchError((error) {
      onFailure();
    });
  }

  getNgnNewOffers({
    required OfferProvider offerProvider,
    required VoidCallback onSuccess,
    required VoidCallback onFailure,
  }) {

    final queryParameters = <String, dynamic>{};
    queryParameters['currency'] = 'NGN';
    List<OfferEntity> offers = [];

    _getAllOffers(queryParameters).then((response) {
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
        offerProvider.saveNgnNewOffers(offers);
      }

      onSuccess();

    }).catchError((error) {
      onFailure();
    });
  }

  getNgnTrendingOffers({
    required OfferProvider offerProvider,
    required VoidCallback onSuccess,
    required VoidCallback onFailure,
  }) {

    final queryParameters = <String, dynamic>{};
    queryParameters['trending'] = 'trending';
    queryParameters['currency'] = 'NGN';
    List<OfferEntity> offers = [];

    _getAllOffers(queryParameters).then((response) {
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
        offerProvider.saveNgnTrendingOffers(offers);
      }
      onSuccess();

    }).catchError((error) {
      onFailure();
    });
  }

  // usd

  getGbpOffers({
    required OfferProvider offerProvider,
    required VoidCallback onSuccess,
    required VoidCallback onFailure,
  }) {

    final queryParameters = <String, dynamic>{};
    queryParameters['sortByAmount'] = 'sortByAmount';
    queryParameters['currency'] = 'GBP';
    List<OfferEntity> offers = [];

    _getAllOffers(queryParameters).then((response) {
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
        offerProvider.saveGbpOffers(offers);
      }

      onSuccess();

    }).catchError((error) {
      onFailure();
    });
  }

  getGbpNewOffers({
    required OfferProvider offerProvider,
    required VoidCallback onSuccess,
    required VoidCallback onFailure,
  }) {

    final queryParameters = <String, dynamic>{};
    queryParameters['currency'] = 'GBP';
    List<OfferEntity> offers = [];

    _getAllOffers(queryParameters).then((response) {
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
        offerProvider.saveGbpNewOffers(offers);
      }

      onSuccess();

    }).catchError((error) {
      onFailure();
    });
  }

  getGbpTrendingOffers({
    required OfferProvider offerProvider,
    required VoidCallback onSuccess,
    required VoidCallback onFailure,
  }) {

    final queryParameters = <String, dynamic>{};
    queryParameters['trending'] = 'trending';
    queryParameters['currency'] = 'GBP';
    List<OfferEntity> offers = [];

    _getAllOffers(queryParameters).then((response) {
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
        offerProvider.saveGbpTrendingOffers(offers);
      }
      onSuccess();

    }).catchError((error) {
      onFailure();
    });
  }

  // usd

  getCadOffers({
    required OfferProvider offerProvider,
    required VoidCallback onSuccess,
    required VoidCallback onFailure,
  }) {

    final queryParameters = <String, dynamic>{};
    queryParameters['sortByAmount'] = 'sortByAmount';
    queryParameters['currency'] = 'CAD';
    List<OfferEntity> offers = [];

    _getAllOffers(queryParameters).then((response) {
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
        offerProvider.saveCadOffers(offers);
      }

      onSuccess();

    }).catchError((error) {
      onFailure();
    });
  }

  getCadNewOffers({
    required OfferProvider offerProvider,
    required VoidCallback onSuccess,
    required VoidCallback onFailure,
  }) {

    final queryParameters = <String, dynamic>{};
    queryParameters['currency'] = 'CAD';
    List<OfferEntity> offers = [];

    _getAllOffers(queryParameters).then((response) {
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
        offerProvider.saveCadNewOffers(offers);
      }

      onSuccess();

    }).catchError((error) {
      onFailure();
    });
  }

  getCadTrendingOffers({
    required OfferProvider offerProvider,
    required VoidCallback onSuccess,
    required VoidCallback onFailure,
  }) {

    final queryParameters = <String, dynamic>{};
    queryParameters['trending'] = 'trending';
    queryParameters['currency'] = 'CAD';
    List<OfferEntity> offers = [];

    _getAllOffers(queryParameters).then((response) {
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
        offerProvider.saveCadTrendingOffers(offers);
      }
      onSuccess();

    }).catchError((error) {
      onFailure();
    });
  }

  // usd

  getEurOffers({
    required OfferProvider offerProvider,
    required VoidCallback onSuccess,
    required VoidCallback onFailure,
  }) {

    final queryParameters = <String, dynamic>{};
    queryParameters['sortByAmount'] = 'sortByAmount';
    queryParameters['currency'] = 'EUR';
    List<OfferEntity> offers = [];

    _getAllOffers(queryParameters).then((response) {
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
        offerProvider.saveEurOffers(offers);
      }

      onSuccess();

    }).catchError((error) {
      onFailure();
    });
  }

  getEurNewOffers({
    required OfferProvider offerProvider,
    required VoidCallback onSuccess,
    required VoidCallback onFailure,
  }) {

    final queryParameters = <String, dynamic>{};
    queryParameters['currency'] = 'EUR';
    List<OfferEntity> offers = [];

    _getAllOffers(queryParameters).then((response) {
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
        offerProvider.saveEurNewOffers(offers);
      }

      onSuccess();

    }).catchError((error) {
      onFailure();
    });
  }

  getEurTrendingOffers({
    required OfferProvider offerProvider,
    required VoidCallback onSuccess,
    required VoidCallback onFailure,
  }) {

    final queryParameters = <String, dynamic>{};
    queryParameters['trending'] = 'trending';
    queryParameters['currency'] = 'EUR';
    List<OfferEntity> offers = [];

    _getAllOffers(queryParameters).then((response) {
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
        offerProvider.saveEurTrendingOffers(offers);
      }
      onSuccess();

    }).catchError((error) {
      onFailure();
    });
  }

  getOfferById({
    required OfferProvider offerProvider,
    required String id,
    required VoidCallback onSuccess,
    required VoidCallback onFailure,
  }) {
    handleShowCustomToast(message: 'Fetching offer details ...', time: Duration(minutes: 25));
    _getOfferById(id).then((response) async {
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

      await getAllOffers(offerProvider: offerProvider, onFailure: (){}, onSuccess: (){});
      await getUsdOffers(offerProvider: offerProvider, onFailure: (){}, onSuccess: (){});
      await getNgnOffers(offerProvider: offerProvider, onFailure: (){}, onSuccess: (){});
      await getGbpOffers(offerProvider: offerProvider, onFailure: (){}, onSuccess: (){});
      await getCadOffers(offerProvider: offerProvider, onFailure: (){}, onSuccess: (){});
      await getEurOffers(offerProvider: offerProvider, onFailure: (){}, onSuccess: (){});
      await getAllNewOffers(offerProvider: offerProvider, onSuccess: (){}, onFailure: (){});
      await getUsdNewOffers(offerProvider: offerProvider, onSuccess: (){}, onFailure: (){});
      await getNgnNewOffers(offerProvider: offerProvider, onSuccess: (){}, onFailure: (){});
      await getGbpNewOffers(offerProvider: offerProvider, onSuccess: (){}, onFailure: (){});
      await getCadNewOffers(offerProvider: offerProvider, onSuccess: (){}, onFailure: (){});
      await getEurNewOffers(offerProvider: offerProvider, onSuccess: (){}, onFailure: (){});
      await getAllTrendingOffers(offerProvider: offerProvider, onSuccess: (){}, onFailure: (){});
      await getUsdTrendingOffers(offerProvider: offerProvider, onSuccess: (){}, onFailure: (){});
      await getNgnTrendingOffers(offerProvider: offerProvider, onSuccess: (){}, onFailure: (){});
      await getGbpTrendingOffers(offerProvider: offerProvider, onSuccess: (){}, onFailure: (){});
      await getCadTrendingOffers(offerProvider: offerProvider, onSuccess: (){}, onFailure: (){});
      await getEurTrendingOffers(offerProvider: offerProvider, onSuccess: (){}, onFailure: (){});
      onSuccess();
      handleShowCustomToast(message: 'Successful', time: Duration(milliseconds: 200));
    }).catchError((error) {
      handleShowCustomToast(message: handleApiFormatError(error));
      onFailure();
    });
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
    required String currency,
    required VoidCallback onSuccess,
    required VoidCallback onFailure,
  }) {
    List<NegotiateOfferModel> negotiations = [];

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
        negotiations.add(NegotiateOfferModel(
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

      onSuccess();

    }).catchError((error) {
      onFailure();
    });
  }

  getMyBids({
    required OfferProvider offerProvider,
    required String days,
    required String currency,
    required VoidCallback onSuccess,
    required VoidCallback onFailure,
  }) {
    List<NegotiateOfferModel> negotiations = [];

    _getMyBids(days, currency).then((response) {
      var data = response.data;

      NegotiatedOffersEntity bids = NegotiatedOffersEntity(
          totalPages: data['totalPages'],
          payloadSize: data['payloadSize'],
          hasNext: data['hasNext'],
          content: data['content'],
          currentPage: data['currentPage'],
          skippedRecords: data['skippedRecords'],
          totalRecords: data['totalRecords']
      );

      var content = bids.content;

      for (var item in content) {
        negotiations.add(NegotiateOfferModel(
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
        offerProvider.saveMyBids(negotiations);
      }
      print('value ${content.length}');
      onSuccess();
    }).catchError((error) {
      print('checking $error');
      onFailure();
    });
  }

  deleteOffer({required String id, required OfferProvider offerProvider, required String days, required String currency}) {
    _deleteOffer(id).then((response) async {
      await getMyOffers(offerProvider: offerProvider, days: days, currency: currency, onSuccess: () {}, onFailure: () {});
      handleShowCustomToast(message: response.data);
    }).catchError((error) {
      handleShowCustomToast(message: handleApiFormatError(error));
    });
  }

  deleteBid({required String id, required OfferProvider offerProvider, required String days, required String currency}) {
    _deleteBid(id).then((response) async {
      await getMyOffers(offerProvider: offerProvider, days: days, currency: currency, onSuccess: () {}, onFailure: () {});
      handleShowCustomToast(message: response.data);
    }).catchError((error) {
      handleShowCustomToast(message: handleApiFormatError(error));
    });
  }

  
  // wallet function

  defaultWallet({
    required WalletProvider walletProvider,
    required String walletId,
    required TransactionProvider transactionProvider
  }) {
    _defaultWallet({'walletId': walletId})
        .then((response) async {
      await getDefaultWallet(transactionProvider: transactionProvider, walletProvider: walletProvider);

      print('objectjjj');
    }).catchError((error) {
      print('object..');
      handleShowCustomToast(message: handleApiFormatError(error));
      // showErrorAlertHelper(errorMessage: handleApiFormatError(error));
    });
  }
  
  getWallets({
    required WalletProvider walletProvider,
    required String currency,
    required TransactionProvider transactionProvider
  }) {
    List<GetWalletModel> wallets = [];
    _getWallet(currency: currency).then((response) async {
      await getTransactions(transactionProvider: transactionProvider);
      var data = response.data;
      for (var item in data) {
        wallets.add(GetWalletModel(
            id: item['id'],
            currency: item['currency'],
            balance: item['balance'],
            isActive: item['isActive'],
            createdDate: item['createdDate'],
            lastModifiedDate: item['lastModifiedDate']
        ));
      }
      walletProvider.saveWallets(wallets);
    });
  }

  getDefaultWallet({
    required WalletProvider walletProvider,
    required TransactionProvider transactionProvider
  }) {
    _getDefaultWallet().then((response) async {
      await getWallets(transactionProvider: transactionProvider, walletProvider: walletProvider, currency: '');
      var item = response.data;
      DefaultWalletModel defaultWallet = DefaultWalletModel(
          id: item['id'],
          currency: item['currency'],
          balance: item['balance'],
          isActive: item['isActive'],
          pendingWithdrawals: item['pendingWithdrawals'],
          createdDate: item['createdDate'],
          lastModifiedDate: item['lastModifiedDate']
      );
      walletProvider.setDefaultWallet(defaultWallet);
    });
  }

  getLocalBank({
    required WalletProvider walletProvider
  }) {
    List<GetBankAccountModel> bankAccounts = [];
    _getLocalBank().then((response) {
      var data = response.data;
      for (var item in data) {
        bankAccounts.add(GetBankAccountModel(
            id: item['id'],
            accountNumber: item['accountNumber'],
            accountName: item['accountName'],
            bankName: item['bankName'],
            currency: item['currency'],
            type: item['type'],
            bankCode: item['bankCode'],
            recipientCode: item['recipientCode'],
            createdDate: item['createdDate'],
            lastModifiedDate: item['lastModifiedDate']));
        walletProvider.saveBankAccounts(bankAccounts);
      }
    });
  }

  getBankList({required WalletProvider walletProvider}) {
    List<BankListModel> bankList = [];
    _getBankList().then((response) {
      var result = response.data;

      BankListEntity bankListModel = BankListEntity(
        status: result['status'],
        message: result['message'],
        data: result['data'],
      );

      final data = bankListModel.data;

      for (var item in data) {
        bankList.add(BankListModel(
          id: item['id'],
          name: item['name'],
          slug: item['slug'],
          code: item['code'],
          longCode: item['longCode'],
          gateway: item['gateway'],
          pay_with_bank: item['pay_with_bank'],
          supports_transfer: item['supports_transfer'],
          active: item['active'],
          country: item['country'],
          currency: item['currency'],
          type: item['type'],
          is_deleted: item['is_deleted'],
          createdAt: item['createdAt'],
          updatedAt: item['updatedAt'],
        ));
      }
      walletProvider.saveBankList(bankList);
    });
  }

  
  // subscribe function

  getSubscriptions({required SubscriptionProvider provider, required String currency, required VoidCallback onSuccess}) {
    List<SubscriptionEntity> subscriptions = [];
    _getSubscriptions(currency)
        .then((response) {
      var data = response.data;

      SubscriptionDetailsEntity subscriptionDetails = SubscriptionDetailsEntity(
        totalPages: data['totalPages'],
        payloadSize: data['payloadSize'],
        hasNext: data['hasNext'],
        content: data['content'],
        currentPage: data['currentPage'],
        skippedRecords: data['skippedRecords'],
        totalRecords: data['totalRecords'],
      );
      provider.saveSubscriptionDetails(subscriptionDetails);

      var content = subscriptionDetails.content;

      for (var item in content) {
        subscriptions.add(SubscriptionEntity(
          id: item['id'],
          debitedCurrency: item['debitedCurrency'],
          creditedCurrency: item['creditedCurrency'],
          createdDate: item['createdDate'],
          minRate: item['minRate'],
          maxRate: item['maxRate'],
          lastModifiedDate: item['lastModifiedDate'],
        ));
      }
      provider.saveSubscriptions(subscriptions);
      print('The value is not working ${subscriptions.length}');
      onSuccess();
    });
  }

  deleteSubscription({required String id, required SubscriptionProvider subscriptionProvider}) {
    _deleteSubscriptions(id).then((response) async {
      await getSubscriptions(provider: subscriptionProvider, currency: '', onSuccess: (){});
      handleShowCustomToast(message: response.data['message']);
    }).catchError((error) {
      handleShowCustomToast(message: handleApiFormatError(error));
    });
  }

  
  // transaction function
  
  getTransactions({required TransactionProvider transactionProvider,}) {
    List<TransactionEntity> transactions = [];

    _transactions().then((response) {
      var data = response.data;
      TransactionsDetailsEntity transactionDetails = TransactionsDetailsEntity(
          totalPages: data['totalPages'],
          payloadSize: data['payloadSize'],
          hasNext: data['hasNext'],
          content: data['content'],
          currentPage: data['currentPage'],
          skippedRecords: data['skippedRecords'],
          totalRecords: data['totalRecords']
      );
      transactionProvider.saveTransactionDetails(transactionDetails);
      var content = transactionDetails.content;
      for (var item in content) {
        transactions.add(TransactionEntity(
          id: item['id'],
          transactionId: item['transactionId'],
          creditedCurrency: item['creditedCurrency'],
          debitedCurrency: item['debitedCurrency'],
          description: item['description'],
          amount: item['amount'],
          debitedAmount: item['debitedAmount'],
          transactionType: item['transactionType'],
          rate: item['rate'],
          creditedWallet: item['creditedWallet'],
          debitedWallet: item['debitedWallet'],
          createdDate: item['createdDate'],
          status: item['status'],
          lastModifiedDate: item['lastModifiedDate'],
        ));
      }
      transactionProvider.saveTransactions(transactions);
    }).catchError((error) {
      print(error);
    });
  }


  // Notification function

  getUserNotification({
    required NotificationProvider provider,
    required VoidCallback onSuccess
  }) {
    List<GetUserNotification> notification = [];
    _getUserNotifications()
        .then((response) {
      var data = response.data;

      for (var item in data) {
        notification.add(GetUserNotification(
          id: item['id'],
          description: item['description'],
          read: item['read'],
          delivered: item['delivered'],
          type: item['type'],
          offerId: item['offerId'],
          createdDate: item['createdDate'],
          lastModifiedDate: item['lastModifiedDate']
        ));
      }
      provider.saveUserNotifications(notification);

      onSuccess();
      print('The value is not working ${notification.length}');
    });
  }

  getNotificationId({
    required NotificationProvider provider,
    required String id,
    // required VoidCallback onSuccess
  }) {
    _getNotificationsId(id)
        .then((response) async {
      var data = response.data;

      print(data);
      await getUserNotification(provider: provider, onSuccess: (){});
      // onSuccess();
      print('The value is not working');
    });
  }
}
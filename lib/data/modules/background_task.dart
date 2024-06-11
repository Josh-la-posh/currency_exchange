import 'package:flutter/material.dart';
import 'package:swappr/data/modules/interceptor.dart';
import 'package:swappr/data/provider/auth_provider.dart';
import 'package:swappr/features/authentication/models/user_model.dart';

import '../../features/all_offer/models/offer.dart';
import '../../features/all_offer/models/offer_details_entity.dart';
import '../../features/profile/models/wallet_model.dart';
import '../../features/subscription/models/subscribeEnity.dart';
import '../../features/subscription/models/subscription_details.dart';
import '../../features/transaction/models/transaction_details_entity.dart';
import '../../features/transaction/models/transaction_entity.dart';
import '../provider/offer_provider.dart';
import '../provider/subscription_provider.dart';
import '../provider/transaction_provider.dart';
import '../provider/wallet_provider.dart';
import 'dio.dart';

final _apiService = AppInterceptor(showLoader: false).dio;

getUserProfileDetails(AuthProvider authProvider) {
  Future userProfileDetails(){
    return _apiService.get('');
  }
}

handleBackgroundAppRequest({
  required UserModel user,
  required AuthProvider authProvider,
  required WalletProvider walletProvider,
  required TransactionProvider transactionProvider,
  required OfferProvider offerProvider,
  required SubscriptionProvider subscriptionProvider,
}) async {
  getUserProfileDetails(authProvider);

  getAllOffers(offerProvider: offerProvider, currency: '', date: '');

  getWallets(walletProvider);

  getTransactions(transactionProvider);

  getSubscriptions(provider: subscriptionProvider, currency: '');
}

getWallets(WalletProvider walletProvider) {
  List<GetWalletModel> wallets = [];

  Future _getWallet() {
    return apiService.post('/wallet/get-wallets');
  }
  _getWallet().then((response) {
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
    print('I am actually working');
    // }
  });
}

getTransactions(TransactionProvider transactionProvider) {
  List<TransactionEntity> transactions = [];

  Future _transactions(){
    return apiService.get(
      '/transaction',
    );
  }
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
  });
}

getAllOffers({
  required OfferProvider offerProvider,
  required String currency,
  required String date
}) {

  Future _getAllOffers(String currency, String date) {
    return apiService.get('/offer', queryParameters: {'currency': currency, 'date': date});
  }
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
      offerProvider.saveOffers(offers);
    }

  });
}

getSubscriptions({
  required SubscriptionProvider provider,
  required String currency
}) {

  Future _getSubscriptions(String currency) {
    return apiService.get(
        '/subscription',
        queryParameters: {'currency': currency}
    );
  }
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
      provider.saveSubscriptions(subscriptions);
    }
  });
}
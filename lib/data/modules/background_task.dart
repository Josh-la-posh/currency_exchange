import 'package:flutter/material.dart';
import 'package:swappr/data/modules/interceptor.dart';
import 'package:swappr/data/provider/auth_provider.dart';
import 'package:swappr/features/authentication/models/user_model.dart';

import '../../features/all_offer/models/offer.dart';
import '../../features/all_offer/models/offer_details_entity.dart';
import '../../features/subscription/models/subscribeEnity.dart';
import '../../features/subscription/models/subscription_details.dart';
import '../../features/transaction/models/transaction_details_entity.dart';
import '../../features/transaction/models/transaction_entity.dart';
import '../../features/wallet/models/bank_list.dart';
import '../../features/wallet/models/bank_list_entity.dart';
import '../../features/wallet/models/get_bank_account.dart';
import '../../features/wallet/models/get_wallet.dart';
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

  //  user details
  getUserProfileDetails(authProvider);


  // all offer request

  getAllOffers(offerProvider: offerProvider, currency: '', date: '');


  // wallet requests

  getWallets(walletProvider);
  getBankList(walletProvider: walletProvider);
  getLocalBank(walletProvider: walletProvider);


  // subscription requests

  getSubscriptions(provider: subscriptionProvider, currency: '');


  // transaction requests

  getTransactions(transactionProvider);


}


// all offer request

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


//  Wallet requests

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
          pendingWithdrawals: item['pendingWithdrawals'],
          createdDate: item['createdDate'],
          lastModifiedDate: item['lastModifiedDate']
      ));
    }
    walletProvider.saveWallets(wallets);
    print('I am actually working');
    // }
  });
}

getBankList({required WalletProvider walletProvider}) {
  List<BankListModel> bankList = [];

  Future _getBankList() {
    return apiService.get('/wallet/list-banks');
  }
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

getLocalBank({
  required WalletProvider walletProvider
}) {
  List<GetBankAccountModel> bankAccounts = [];

  Future _getLocalBank() {
    return apiService.get('/wallet/get-local-bank');
  }

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
    }
    walletProvider.saveBankAccounts(bankAccounts);
  });
}


// subscription request

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


// transaction requests

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
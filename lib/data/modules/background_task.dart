import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:swappr/data/modules/interceptor.dart';
import 'package:swappr/data/provider/auth_provider.dart';
import 'package:swappr/features/authentication/models/user_model.dart';

import '../../features/profile/models/wallet_model.dart';
import '../../features/transaction/models/transaction_details_entity.dart';
import '../../features/transaction/models/transaction_entity.dart';
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
  required TransactionProvider transactionProvider
}) async {
  getUserProfileDetails(authProvider);

  getWallets(walletProvider);

  getTransactions(transactionProvider);


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


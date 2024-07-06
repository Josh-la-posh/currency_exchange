import 'package:flutter/material.dart';
import 'package:swappr/data/modules/dio.dart';
import 'package:swappr/data/provider/transaction_provider.dart';
import 'package:swappr/features/transaction/models/transaction_details_entity.dart';
import 'package:swappr/features/transaction/models/transaction_entity.dart';


class TransactionService {
  static final TransactionService _instance = TransactionService._();

  TransactionService._();

  static TransactionService get instance => _instance;


  Future _transactions(){
    return apiService.get(
      '/transaction',
    );
  }

  Future _transaction({required String id}){
    return apiService.get(
      '/transaction/$id',
    );
  }

  getTransactions({
    required TransactionProvider transactionProvider,
}) {
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


}
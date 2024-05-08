import 'package:flutter/foundation.dart';
import 'package:swappr/features/transaction/models/transaction_details_entity.dart';

import '../../features/transaction/models/transaction_entity.dart';

class TransactionProvider extends ChangeNotifier {
  TransactionsDetailsEntity? _transactionDetails;
  List<TransactionEntity> _transactions = [];


  List<TransactionEntity> get transactions => _transactions;
  TransactionsDetailsEntity? get transactionDetails => _transactionDetails;

  void saveTransactionDetails(TransactionsDetailsEntity data){
    _transactionDetails = data;
    notifyListeners();
  }

  void saveTransactions(List<TransactionEntity> data) {
    _transactions = data;
    notifyListeners();
  }

  void removeTransactions() {
    _transactions = [];
    notifyListeners();
  }



  resetState() {
    _transactions = [];
    _transactionDetails = null;
    notifyListeners();
  }

}
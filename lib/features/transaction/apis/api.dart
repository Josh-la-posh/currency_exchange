import 'dart:ui';

import 'package:pouch/data/modules/dio.dart';

import '../../../utils/responses/handleApiError.dart';


class TransactionService {
  static final TransactionService _instance = TransactionService._();

  TransactionService._();

  static TransactionService get instance => _instance;

  Future _fetchTransactions() {
    return apiService.get('/transaction');
  }


  Future fetchTransactions({required VoidCallback onFailure}) async{
    return _fetchTransactions().then((response) async {
      return response;
    }).catchError((error) {
      onFailure();
      throw (handleApiFormatError(error));
    });
  }

  Future _transaction({required String id}){
    return apiService.get(
      '/transaction/$id',
    );
  }


}
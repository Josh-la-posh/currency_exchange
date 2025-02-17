import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:pouch/features/transaction/apis/api.dart';
import 'package:pouch/features/transaction/models/transaction_entity.dart';

import '../../../utils/shared/error_dialog_response.dart';

class TransactionController extends GetxController {
  final CancelToken requestCancelToken = CancelToken();
  var isTransactionLoading = false.obs;
  var transactions = <TransactionEntity>[].obs;

  @override
  void onInit() {
    fetchTransactions();
    super.onInit();
  }

  Future<void> fetchTransactions() async {
    try {
      transactions.isEmpty && isTransactionLoading(true);
      final response = await TransactionService.instance.fetchTransactions(
          onFailure: () {isTransactionLoading(false);}
      );
      final data = response.data['content'];
      List<TransactionEntity> fetchedTransactions = (data as List)
          .map((json) => TransactionEntity.fromJson(json)).toList();
      transactions.assignAll(fetchedTransactions);
    } catch (e) {
      showErrorAlertHelper(errorMessage: e.toString());
    } finally {
      isTransactionLoading(false);
    }
  }

  clearData() {
    transactions.clear();
  }

  @override
  void dispose() {
    requestCancelToken.cancel('Component disposed');
    super.dispose();
  }
}
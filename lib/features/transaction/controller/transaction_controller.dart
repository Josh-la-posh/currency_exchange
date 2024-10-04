import 'package:get/get.dart';
import 'package:pouch/features/transaction/apis/api.dart';
import 'package:pouch/features/transaction/models/transaction_entity.dart';

class TransactionController extends GetxController {
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
      final response = await TransactionService.instance.fetchTransactions();
      if (response.statusCode == 200 || response.statusCode == 201) {
        final data = response.data['content'];
        List<TransactionEntity> fetchedTransactions = (data as List)
            .map((json) => TransactionEntity.fromJson(json)).toList();
        transactions.assignAll(fetchedTransactions);
      }
    } catch (e) {
      print(e);
    } finally {
      isTransactionLoading(false);
    }
  }

  clearData() {
    transactions.clear();
  }
}
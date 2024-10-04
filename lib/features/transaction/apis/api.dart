import 'package:pouch/data/modules/dio.dart';


class TransactionService {
  static final TransactionService _instance = TransactionService._();

  TransactionService._();

  static TransactionService get instance => _instance;


  Future fetchTransactions(){
    return apiService.get(
      '/transaction',
    );
  }

  Future _transaction({required String id}){
    return apiService.get(
      '/transaction/$id',
    );
  }

//   getTransactions({
//     required TransactionProvider transactionProvider,
// }) {
//     List<TransactionEntity> transactions = [];
//
//     _transactions().then((response) {
//       var data = response.data;
//       TransactionsDetailsEntity transactionDetails = TransactionsDetailsEntity(
//           totalPages: data['totalPages'],
//           payloadSize: data['payloadSize'],
//           hasNext: data['hasNext'],
//           content: data['content'],
//           currentPage: data['currentPage'],
//           skippedRecords: data['skippedRecords'],
//           totalRecords: data['totalRecords']
//       );
//       transactionProvider.saveTransactionDetails(transactionDetails);
//       var content = transactionDetails.content;
//         for (var item in content) {
//           transactions.add(TransactionEntity(
//             id: item['id'],
//             transactionId: item['transactionId'],
//             creditedCurrency: item['creditedCurrency'],
//             debitedCurrency: item['debitedCurrency'],
//             description: item['description'],
//             amount: item['amount'],
//             debitedAmount: item['debitedAmount'],
//             transactionType: item['transactionType'],
//             rate: item['rate'],
//             rateDescription: item['rateDescription'],
//             creditedWallet: item['creditedWallet'],
//             debitedWallet: item['debitedWallet'],
//             createdDate: item['createdDate'],
//             status: item['status'],
//             lastModifiedDate: item['lastModifiedDate'],
//           ));
//         }
//         transactionProvider.saveTransactions(transactions);
//     });
//   }


}
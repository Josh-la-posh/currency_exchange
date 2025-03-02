import 'dart:ui';
import '../../../data/modules/dio_service.dart';
import '../../../utils/responses/handleApiError.dart';

class TransactionService {
  static final TransactionService _instance = TransactionService._();

  TransactionService._();

  static TransactionService get instance => _instance;

  final DioService _dioService = DioService();

  Future<Map<String, dynamic>> fetchTransactions({
    required VoidCallback onFailure,
  }) async {
    try {
      final response = await _dioService.getRequest(endpoint: '/transaction');
      return response;
    } catch (error) {
      onFailure();
      throw handleApiFormatError(error);
    }
  }

  Future<Map<String, dynamic>> fetchTransactionById({
    required String id,
    required VoidCallback onFailure,
  }) async {
    try {
      final response = await _dioService.getRequest(endpoint: '/transaction/$id');
      return response;
    } catch (error) {
      onFailure();
      throw handleApiFormatError(error);
    }
  }
}





// class TransactionService {
//   static final TransactionService _instance = TransactionService._();
//
//   TransactionService._();
//
//   static TransactionService get instance => _instance;
//
//   Future _fetchTransactions() {
//     return apiService.get('/transaction');
//   }
//
//
//   Future fetchTransactions({required VoidCallback onFailure}) async{
//     return _fetchTransactions().then((response) async {
//       return response;
//     }).catchError((error) {
//       onFailure();
//       throw (handleApiFormatError(error));
//     });
//   }
//
//   Future _transaction({required String id}){
//     return apiService.get(
//       '/transaction/$id',
//     );
//   }
//
//
// }
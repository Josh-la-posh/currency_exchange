
class PaymentMethodService{
  static final PaymentMethodService _instance = PaymentMethodService._();

  PaymentMethodService._();

  static PaymentMethodService get instance => _instance;

  // Post requests

  // Future _createFcy(Object data) {
  //   return apiService.post('/wallet/create/fcy', data: data);
  // }

  // Get requests


  // Future _getWallet({required String currency}) {
  //   return apiService.get('/wallet/get-wallets',
  //     queryParameters: {'currency': currency}
  //   );
  // }

  // Delete requests



}
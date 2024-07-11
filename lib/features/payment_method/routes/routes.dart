import 'package:flutter/material.dart';
import 'package:pouch/features/payment_method/routes/names.dart';
import 'package:pouch/features/payment_method/screens/bank_transfer.dart';
import 'package:pouch/features/payment_method/screens/flutterwave_payment.dart';
import 'package:pouch/features/payment_method/screens/paystack_payment.dart';
import 'package:pouch/features/payment_method/screens/ussd_funding.dart';
import 'package:pouch/features/payment_method/screens/ussd_funding_detail.dart';
import 'package:pouch/features/profile/routes/names.dart';
import '../../../data/routes/guard_route.dart';
import '../screens/payment_options.dart';


Map<String, WidgetBuilder> depositRoute = {
  PAYMENT_OPTION_SCREEN: (context) => const AuthGuard(
    widget: PaymentOptionScreen(),
  ),
  PAYSTACK_PAYMENT_SCREEN: (context) => AuthGuard(
    widget: PaystackPaymentScreen(),
  ),
  FLUTTER_WAVE_PAYMENT_SCREEN: (context) => const AuthGuard(
    widget: FlutterwavePaymentScreen(),
  ),
  BANK_TRANSFER_PAYMENT_SCREEN: (context) => const AuthGuard(
    widget: BankTransferScreen(),
  ),
  USSD_FUNDING_SCREEN: (context) => const AuthGuard(
      widget: UssdFundingScreen()
  ),
  USSD_FUNDING_DETAIL_SCREEN: (context) => AuthGuard(
      widget: UssdFundingDetailScreen()
  )
};

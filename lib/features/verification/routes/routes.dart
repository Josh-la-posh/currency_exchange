import 'package:flutter/material.dart';
import 'package:swappr/features/verification/routes/names.dart';
import 'package:swappr/features/verification/screens/country_select.dart';
import 'package:swappr/features/verification/screens/identity_verification_type.dart';
import 'package:swappr/features/verification/screens/verification_process.dart';
import 'package:swappr/features/verification/screens/verify_page.dart';
import 'package:swappr/features/verification/screens/verify_success.dart';

import '../screens/identity_verification.dart';


Map<String, WidgetBuilder> verifyRoute = {
  VERIFICATION_PAGE_SCREEN: (context) => const VerificationPage(),
  VERIFICATION_PROCESS_SCREEN: (context) => const VerificationProcess(),
  COUNTRY_SELECTION_SCREEN: (context) => const CountrySelectionPage(),
  IDENTITY_VERIFICATION_TYPE_SCREEN: (context) => const IdentityVerificationTypeScreen(),
  IDENTITY_VERIFICATION_SCREEN: (context) => IdentityVerificationScreen(),
  VERIFICATION_SUCCESS_SCREEN: (context) => const VerificationSuccessScreen()
};

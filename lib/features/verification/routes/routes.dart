import 'package:flutter/material.dart';
import 'package:pouch/features/verification/routes/names.dart';
import 'package:pouch/features/verification/screens/country_select.dart';
import 'package:pouch/features/verification/screens/identity_verification_type.dart';
import 'package:pouch/features/verification/screens/verification_in_progress.dart';
import 'package:pouch/features/verification/screens/verification_process.dart';
import 'package:pouch/features/verification/screens/verify_page.dart';
import 'package:pouch/features/verification/screens/verify_success.dart';

import '../../../data/routes/guard_route.dart';
import '../screens/identity_verification.dart';

// AuthGuard(widget: VerificationPage())
Map<String, WidgetBuilder> verifyRoute = {
  VERIFICATION_PAGE_SCREEN: (context) => AuthGuard(widget: VerificationPage()),
  VERIFICATION_PROCESS_SCREEN: (context) => AuthGuard(widget: VerificationProcess()),
  COUNTRY_SELECTION_SCREEN: (context) => AuthGuard(widget: CountrySelectionPage()),
  IDENTITY_VERIFICATION_TYPE_SCREEN: (context) => AuthGuard(widget: IdentityVerificationTypeScreen()),
  IDENTITY_VERIFICATION_SCREEN: (context) => AuthGuard(widget: IdentityVerificationScreen()),
  VERIFICATION_SUCCESS_SCREEN: (context) => AuthGuard(widget: VerificationSuccessScreen()),
  VERIFICATION_IN_PROGRESS_SCREEN: (context) => AuthGuard(widget: VerificationInProgressScreen())
};

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pouch/features/profile/icons/svg.dart';
import 'package:pouch/common/widgets/divider.dart';
import 'package:pouch/features/profile/screens/change_password.dart';
import 'package:pouch/features/profile/widgets/layout.dart';
import 'package:pouch/features/profile/widgets/profile/logout.dart';
import 'package:pouch/features/profile/widgets/profile/profile_details.dart';
import 'package:pouch/features/profile/widgets/profile/profile_link.dart';
import 'package:pouch/features/verification/screens/verify_page.dart';
import 'package:pouch/utils/constants/colors.dart';
import 'package:pouch/utils/constants/sizes.dart';

import '../../../utils/helpers/helper_functions.dart';
import 'bank_account/bank_account.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final darkMode = THelperFunctions.isDarkMode(context);
    return SingleChildScrollView(
      child: Column(
        children: [
          ProfileDetailsScreen(darkMode: darkMode,),
          const SizedBox(height: 8),
          ProfileLinkWidget(onPressed: () => {Get.to(() => VerificationPage())}, title: 'Identity Verification', icon: Icon(Icons.perm_identity, size: 23, color: TColors.primary,)),
          ProfileLinkWidget(onPressed: () => {Get.to(() => const BankAccountScreen())}, title: 'Bank Account', icon: BankIcon(),),
          ProfileLinkWidget(onPressed: (){Get.to(() => const ChangePasswordScreen());}, title: 'Change Password', icon: PasswordIcon(),),
          const SizedBox(height: 8),
          ProfileLinkWidget(onPressed: (){}, title: 'FAQs', icon: FaqIcon(),),
          ProfileLinkWidget(onPressed: (){}, title: 'Help & Support', icon: SupportIcon(),),
          const SizedBox(height: 8),
          const LogoutButton()
        ],
      ),
    );
  }
}




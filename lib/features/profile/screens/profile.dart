import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pouch/features/profile/icons/svg.dart';
import 'package:pouch/features/profile/screens/security/security.dart';
import 'package:pouch/features/profile/widgets/profile/logout.dart';
import 'package:pouch/features/profile/widgets/profile/profile_details.dart';
import 'package:pouch/features/profile/widgets/profile/profile_link.dart';
import 'package:pouch/features/verification/screens/verify_page.dart';
import 'package:pouch/utils/constants/colors.dart';
import '../../../utils/helpers/helper_functions.dart';
import 'bank_account/bank_account.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final darkMode = THelperFunctions.isDarkMode(context);
    return Scaffold(
      backgroundColor: darkMode ? Colors.transparent : Colors.grey.withOpacity(0.4),
      body: Container(
        height: THelperFunctions.screenHeight(),
        child: Stack(
          children: [
            SingleChildScrollView(
              child: Column(
                children: [
                  ProfileDetailsScreen(darkMode: darkMode),
                  const SizedBox(height: 8),
                  ProfileLinkWidget(
                    onPressed: () => Get.to(() => BankAccountScreen()),
                    title: 'Bank Account',
                    icon: BankIcon(),
                  ),
                  ProfileLinkWidget(
                    onPressed: () => Get.to(() => SecurityScreen()),
                    title: 'Security',
                    icon: PasswordIcon(),
                  ),
                  const SizedBox(height: 8),
                  ProfileLinkWidget(
                    onPressed: () {},
                    title: 'FAQs',
                    icon: FaqIcon(),
                  ),
                  ProfileLinkWidget(
                    onPressed: () {},
                    title: 'Help & Support',
                    icon: SupportIcon(),
                  ),
                  const SizedBox(height: 8),
                  LogoutButton(),
                ],
              ),
            ),
            Positioned(
              bottom: 0,
              left: 10,
              child: Text(
                'Version: 1.1.0.3',
                style: Theme.of(context).textTheme.labelSmall?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}




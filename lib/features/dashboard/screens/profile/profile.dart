import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:swappr/common/styles/spacing_styles.dart';
import 'package:swappr/features/dashboard/screens/profile/bank_accounts.dart';
import 'package:swappr/features/dashboard/screens/profile/icons/svg.dart';
import 'package:swappr/common/widgets/divider.dart';
import 'package:swappr/features/dashboard/screens/profile/widgets/profile/logout.dart';
import 'package:swappr/features/dashboard/screens/profile/widgets/profile/profile_details.dart';
import 'package:swappr/features/dashboard/screens/profile/widgets/profile/profile_link.dart';
import 'package:swappr/utils/constants/sizes.dart';

import '../../../../utils/constants/colors.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: TSpacingStyle.dashboardPadding,
          child: Column(
            children: [
              const ProfileDetailsScreen(),
              const SizedBox(height: TSizes.spaceBtwItems,),
              ProfileLinkWidget(onPressed: () => {Get.to(() => const BankAccounts())}, title: 'Bank Accounts', icon: BankIcon(),),
              const DividerWidget(),
              ProfileLinkWidget(onPressed: (){}, title: 'Change Password', icon: PasswordIcon(),),
              const DividerWidget(),
              ProfileLinkWidget(onPressed: (){}, title: 'FAQs', icon: FaqIcon(),),
              const DividerWidget(),
              ProfileLinkWidget(onPressed: (){}, title: 'Help & Support', icon: SupportIcon(),),
              const SizedBox(height: TSizes.spaceBtwItems,),
              const LogoutButton()
            ],
          ),
        ),
      ),
    );
  }
}




import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:swappr/common/styles/spacing_styles.dart';
import 'package:swappr/features/profile/screens/bank_accounts.dart';
import 'package:swappr/features/profile/icons/svg.dart';
import 'package:swappr/common/widgets/divider.dart';
import 'package:swappr/features/profile/widgets/layout.dart';
import 'package:swappr/features/profile/widgets/profile/logout.dart';
import 'package:swappr/features/profile/widgets/profile/profile_details.dart';
import 'package:swappr/features/profile/widgets/profile/profile_link.dart';
import 'package:swappr/utils/constants/sizes.dart';

import '../../../utils/constants/colors.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ProfileScreenLayout(
      childWidget: SingleChildScrollView(
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
    );
  }
}




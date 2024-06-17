import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:swappr/features/profile/icons/svg.dart';
import 'package:swappr/common/widgets/divider.dart';
import 'package:swappr/features/profile/screens/change_password.dart';
import 'package:swappr/features/profile/widgets/layout.dart';
import 'package:swappr/features/profile/widgets/profile/logout.dart';
import 'package:swappr/features/profile/widgets/profile/profile_details.dart';
import 'package:swappr/features/profile/widgets/profile/profile_link.dart';
import 'package:swappr/utils/constants/sizes.dart';

import '../../../utils/helpers/helper_functions.dart';
import 'bank_account/bank_account.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final darkMode = THelperFunctions.isDarkMode(context);
    return ProfileScreenLayout(
      childWidget: SingleChildScrollView(
        child: Column(
          children: [
            ProfileDetailsScreen(darkMode: darkMode,),
            const SizedBox(height: TSizes.spaceBtwItems,),
            ProfileLinkWidget(onPressed: () => {Get.to(() => const BankAccountScreen())}, title: 'Bank Account', icon: BankIcon(),),
            const DividerWidget(),
            ProfileLinkWidget(onPressed: (){Get.to(() => const ChangePasswordScreen());}, title: 'Change Password', icon: PasswordIcon(),),
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




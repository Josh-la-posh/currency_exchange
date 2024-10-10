import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pouch/features/authentication/controllers/auth_controller.dart';
import 'package:pouch/features/profile/screens/security/biometric_authentication.dart';
import 'package:pouch/features/profile/screens/security/change_password.dart';
import 'package:pouch/features/profile/widgets/profile/profile_link.dart';
import 'package:pouch/utils/constants/sizes.dart';
import 'package:pouch/utils/constants/texts.dart';
import '../../../../utils/constants/colors.dart';
import '../../../../utils/helpers/helper_functions.dart';

class SecurityScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    AuthController authController = Get.find();
    final darkMode = THelperFunctions.isDarkMode(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: darkMode ? TColors.textPrimaryO40 : Colors.white,
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: const Icon(Icons.arrow_back),
          style: IconButton.styleFrom(
            foregroundColor: Colors.grey,
            iconSize: TSizes.iconBackSize,
          ),
          hoverColor: Colors.transparent,
        ),
        title: Text(
          'Security',
          style: Theme.of(context).textTheme.titleMedium,
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              color: darkMode ? TColors.textPrimaryO40 : Colors.white,
              width: double.infinity,
              padding: EdgeInsets.only(left: TSizes.defaultSpace),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 10),
                  Text(
                    'Account Activity',
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w400),
                  ),
                  SizedBox(height: 10),
                  Text(
                    'Last login time: ${THelperFunctions.getFormattedDate(authController.user.value.lastLogin.toString())}',
                    style: TextStyle(
                        fontSize: 11,
                        fontFamily: TTexts.fontFamily,
                        color: Colors.grey
                    ),
                  ),
                  Row(
                    children: [
                      Text(
                        'Login device: ',
                        style: TextStyle(
                            fontSize: 11,
                            fontFamily: TTexts.fontFamily,
                            color: Colors.grey
                        ),
                      ),
                      Icon(Icons.phone_android, size: 12,),
                      Text(
                        authController.user.value.lastLoginDevice.toString(),
                        style: TextStyle(
                            fontSize: 11,
                            fontFamily: TTexts.fontFamily,
                            color: Colors.grey
                        ),
                      )
                    ],
                  ),
                  SizedBox(height: 10),
                ],
              ),
            ),
            Container(
              height: 8,
              color: darkMode ? Colors.transparent : Colors.grey.withOpacity(0.2),
            ),
            Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ProfileLinkWidget(
                    title: 'Change Password',
                    onPressed: () => Get.to(() => ChangePasswordScreen()),
                  ),
                  ProfileLinkWidget(
                    title: 'Email',
                    onPressed: () {},
                    rightText: '${authController.user.value.email?.substring(0,3)}***@****',
                  ),
                  ProfileLinkWidget(
                    title: 'Mobile',
                    onPressed: () {},
                    rightText: '${authController.user.value.phoneNumber?.substring(0,7)}*****',
                  ),
                ],
              ),
            ),
            Container(
              height: 8,
              color: darkMode ? Colors.transparent : Colors.grey.withOpacity(0.2),
            ),
            Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ProfileLinkWidget(
                    title: 'Google 2FA Authentication',
                    onPressed: () {},
                  ),
                  ProfileLinkWidget(
                    title: 'Biometric Authentication',
                    onPressed: () => Get.to(() => BiometricAuthenticationScreen()),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}


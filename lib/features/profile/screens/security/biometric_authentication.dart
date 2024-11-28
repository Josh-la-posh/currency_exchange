import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pouch/data/modules/storage_session_controller.dart';
import 'package:pouch/features/profile/controller/security_controller.dart';
import 'package:pouch/utils/constants/sizes.dart';
import '../../../../utils/constants/colors.dart';
import '../../../../utils/helpers/helper_functions.dart';

class BiometricAuthenticationScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final UserSessionController userSessionController = Get.find();
    final SecurityController securityController = Get.put(SecurityController());
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
          'Biometric Authentication',
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
                    'Once locked, you may unlock using the authenticator method:',
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w400,
                        fontSize: 11,
                    ),
                  ),
                  SizedBox(height: 10),
                ],
              ),
            ),
            Container(
              height: 1,
              color: darkMode ? Colors.transparent : Colors.grey.withOpacity(0.2),
            ),
            Container(
              color: darkMode ? TColors.textPrimaryO40 : Colors.white,
              padding: EdgeInsets.only(left: TSizes.defaultSpace),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 48,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        RichText(
                            text: TextSpan(
                                style: Theme.of(context).textTheme.labelMedium,
                                children: <TextSpan> [
                                  TextSpan(
                                      text: 'Enable Biometric',
                                      style: TextStyle(
                                        fontSize: 15,
                                        // fontWeight: FontWeight.w600
                                      )
                                  )
                                ]
                            )
                        ),
                        Spacer(),
                        Transform.scale(
                          scale: 0.8,
                          child: Obx(() => Switch(
                            value: securityController.useBiometric.value,
                            onChanged: (val) {
                              userSessionController.setUserBiometrics(!securityController.useBiometric.value);
                              securityController.getBiometricValue();
                            },
                          )),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}


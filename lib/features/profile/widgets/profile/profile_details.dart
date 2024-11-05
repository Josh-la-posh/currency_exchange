import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pouch/features/authentication/controllers/auth_controller.dart';
import 'package:pouch/utils/helpers/helper_functions.dart';

import '../../../../utils/constants/colors.dart';
import '../../../../utils/constants/sizes.dart';
import '../../../verification/screens/verify_page.dart';


class ProfileDetailsScreen extends StatelessWidget {
  final bool darkMode;
  const ProfileDetailsScreen({
    super.key, required this.darkMode,
  });

  @override
  Widget build(BuildContext context) {
    AuthController authController = Get.find();
    return Container(
      color: darkMode ? TColors.textPrimaryO40 : Colors.white,
      padding: EdgeInsets.only(bottom: 15, left: TSizes.defaultSpace * 0.7, right: TSizes.defaultSpace * 0.3),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            height: 50,
            width: 50,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(50),
              color: darkMode ? TColors.white.withOpacity(0.5) : TColors.secondaryBorder30
            ),
            child: Center(
              child: RichText(
                  text: TextSpan(
                      style: Theme.of(context).textTheme.labelMedium?.copyWith(fontSize: 22),
                      children: <TextSpan> [
                        TextSpan(
                            text: THelperFunctions.getInitials(authController.user.value.lastName ?? 'My', authController.user.value.firstName ?? 'Pouch'),
                            style: TextStyle(
                                color: darkMode ? Colors.white : TColors.primary,
                                fontWeight: FontWeight.w700
                            )
                        )
                      ]
                  )
              ),
            ),
          ),
          const SizedBox(width: TSizes.lg,),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              RichText(
                  text: TextSpan(
                      style: Theme.of(context).textTheme.labelMedium,
                      children: <TextSpan> [
                        TextSpan(
                            text: '${authController.user.value.lastName} ${authController.user.value.firstName}',
                            style: TextStyle(
                                fontWeight: TSizes.fontWeightMd,
                                fontSize: 20
                            )
                        )
                      ]
                  )
              ),
              RichText(
                  text: TextSpan(
                      style: Theme.of(context).textTheme.labelSmall,
                      children: <TextSpan> [
                        TextSpan(
                            text: authController.user.value.email,
                            style: TextStyle(
                                fontSize: TSizes.fontSize14,
                                // fontWeight: FontWeight.w600,
                                height: 1.2
                            )
                        )
                      ]
                  )
              ),
              SizedBox(height: 10),
              GestureDetector(
                onTap: authController.user.value.isVerified == true
                    ? null
                    : () => Get.to(() => VerificationPage()),
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: TColors.primary,
                    ),
                    borderRadius: BorderRadius.circular(11)
                  ),
                  child: Row(
                    children: [
                      Icon(authController.user.value.isVerified == true
                          ? Icons.verified
                          : Icons.verified_user_outlined,
                        color: TColors.primary, size: 13),
                      SizedBox(width: 5),
                      RichText(
                          text: TextSpan(
                              style: Theme.of(context).textTheme.labelSmall,
                              children: <TextSpan> [
                                TextSpan(
                                    text: authController.user.value.isVerified == true
                                        ? 'Verified ID'
                                        : 'Verify now',
                                    style: TextStyle(
                                        fontSize: TSizes.fontSize11,
                                        fontWeight: FontWeight.w500,
                                        height: 1.2,
                                        color: TColors.primary,
                                    )
                                )
                              ]
                          )
                      )
                    ],
                  ),
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
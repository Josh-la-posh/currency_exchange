import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:swappr/common/widgets/buttons/elevated_button.dart';
import 'package:swappr/data/provider/auth_provider.dart';
import 'package:swappr/data/provider/verification_provider.dart';
import 'package:swappr/features/verification/screens/verify_page.dart';
import '../../utils/constants/colors.dart';
import '../../utils/constants/sizes.dart';
import '../../utils/helpers/helper_functions.dart';

class VerifyYourAccountWidget extends StatelessWidget {
  final bool darkMode;
  final VoidCallback onTap;
  const VerifyYourAccountWidget({super.key, required this.darkMode, required this.onTap});

  @override
  Widget build(BuildContext context) {
    // var provider = Provider.of<VerificationProvider>(context);
    return Stack(
      children: [
        Container(
            width: 291,
            margin: const EdgeInsets.symmetric(vertical: TSizes.spaceBtwElements),
            padding: const EdgeInsets.symmetric(horizontal: 27, vertical: 30),
            decoration: BoxDecoration(
                color: darkMode ? TColors.black.withOpacity(0.8) : Color(0xFFF6F6F6),
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                      color: TColors.black.withOpacity(0.3),
                      offset: const Offset(1.72,2.24),
                      blurRadius: 1.94,
                      spreadRadius: 1.94
                  ),
                  BoxShadow(
                      color: TColors.secondaryBorder,
                      offset: const Offset(0.0,0.0),
                      blurRadius: 0,
                      spreadRadius: 0
                  ),
                ]
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                RichText(
                    text: TextSpan(
                        style: Theme.of(context).textTheme.titleSmall,
                        children: const <TextSpan> [
                          TextSpan(
                              text:'Verify Your Account',
                              style: TextStyle(
                                  fontSize: 18,
                                  // color: TColors.textPrimaryO80
                              )
                          ),
                        ]
                    )
                ),
                const SizedBox(height: TSizes.defaultSpace * 0.5),
                RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(
                        style: Theme.of(context).textTheme.titleSmall,
                        children: const <TextSpan> [
                          TextSpan(
                              text:'To ensure the security of your account and provide you with the best possible experience, we need to verify your identity.',
                              style: TextStyle(
                                  fontSize: 10,
                                  // color: TColors.textPrimaryO80
                              )
                          ),
                        ]
                    )
                ),
                const SizedBox(height: TSizes.defaultSpace * 0.6),

                TElevatedButton(
                    onTap: (){
                      Get.to(() => VerificationPage());
                    },
                    buttonText: 'Verify Now'
                )
              ],
            )
        ),
        Positioned(
            top: 0,
            right: 0,
            child: IconButton(
                onPressed: onTap,
                icon: const Icon(
                  Icons.cancel_rounded,
                  color: TColors.primary,
                  size: 30,
                )
            )
        )
      ],
    );
  }
}

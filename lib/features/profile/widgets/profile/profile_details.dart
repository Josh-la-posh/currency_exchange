import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:provider/provider.dart';
import 'package:pouch/utils/helpers/helper_functions.dart';

import '../../../../data/provider/auth_provider.dart';
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
    var authProvider = Provider.of<AuthProvider>(context);
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              height: 31,
              width: 31,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(31),
                color: darkMode ? TColors.white.withOpacity(0.5) : TColors.secondaryBorder30
              ),
              child: Center(
                child: RichText(
                    text: TextSpan(
                        style: Theme.of(context).textTheme.labelMedium,
                        children: <TextSpan> [
                          TextSpan(
                              text: THelperFunctions.getInitials(authProvider.user?.lastName, authProvider.user?.firstName),
                              style: TextStyle(
                                  color: TColors.primary,
                                  fontWeight: FontWeight.w700
                              )
                          )
                        ]
                    )
                ),
              ),
            ),
            const SizedBox(width: TSizes.md,),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                RichText(
                    text: TextSpan(
                        style: Theme.of(context).textTheme.labelMedium,
                        children: <TextSpan> [
                          TextSpan(
                              text: '${authProvider.user?.lastName} ${authProvider.user?.firstName}',
                              style: TextStyle(
                                  fontWeight: TSizes.fontWeightMd,
                                  fontSize: 16
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
                              text: authProvider.user?.email,
                              style: TextStyle(
                                  fontSize: TSizes.fontSize11,
                                fontWeight: FontWeight.w600
                              )
                          )
                        ]
                    )
                ),
              ],
            )
          ],
        ),
        Container(
          color: darkMode ? Colors.transparent : TColors.primaryBackground,
          child: TextButton(
              onPressed: (){
                Get.to(() => const VerificationPage());
              },
              child: const Row(
                children: [
                  Text('Verify', style: TextStyle(fontSize: TSizes.fontSize12, fontWeight: TSizes.fontWeightMd),),
                  Icon(Icons.chevron_right, size: 16,)
                ],
              )
          ),
        )
      ],
    );
  }
}
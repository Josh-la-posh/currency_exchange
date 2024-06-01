import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:provider/provider.dart';
import 'package:swappr/utils/helpers/helper_functions.dart';

import '../../../../data/provider/auth_provider.dart';
import '../../../../utils/constants/colors.dart';
import '../../../../utils/constants/sizes.dart';
import '../../../verification/screens/verify_page.dart';


class ProfileDetailsScreen extends StatelessWidget {
  const ProfileDetailsScreen({
    super.key,
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
                color: TColors.secondaryBorder30
              ),
              child: Center(
                child: RichText(
                    text: TextSpan(
                        style: Theme.of(context).textTheme.labelMedium,
                        children: <TextSpan> [
                          TextSpan(
                              text: THelperFunctions.getInitials(authProvider.user?.lastName, authProvider.user?.firstName),
                              style: TextStyle(color: TColors.primary)
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
                              style: TextStyle(fontWeight: TSizes.fontWeightMd)
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
                              style: TextStyle(fontSize: TSizes.fontSize11)
                          )
                        ]
                    )
                ),
              ],
            )
          ],
        ),
        Container(
          color: TColors.primaryBackground,
          child: TextButton(
              onPressed: (){
                Get.to(() => const VerificationPage());
              },
              child: const Row(
                children: [
                  Text('Verify', style: TextStyle(fontSize: TSizes.fontSize11, fontWeight: TSizes.fontWeightNm),),
                  Icon(Icons.chevron_right, size: 16,)
                ],
              )
          ),
        )
      ],
    );
  }
}
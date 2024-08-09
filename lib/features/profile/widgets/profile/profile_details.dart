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
                            text: THelperFunctions.getInitials(authProvider.user?.lastName ?? 'My', authProvider.user?.firstName ?? 'Pouch'),
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
                            text: '${authProvider.user?.lastName} ${authProvider.user?.firstName}',
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
                            text: authProvider.user?.email,
                            style: TextStyle(
                                fontSize: TSizes.fontSize14,
                                fontWeight: FontWeight.w600,
                                height: 1.2
                            )
                        )
                      ]
                  )
              ),
            ],
          )
        ],
      ),
    );
  }
}
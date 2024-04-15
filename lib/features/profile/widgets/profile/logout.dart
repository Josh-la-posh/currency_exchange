import 'package:flutter/material.dart';

import '../../../../utils/constants/colors.dart';
import '../../../../utils/constants/sizes.dart';

class LogoutButton extends StatelessWidget {
  const LogoutButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 40,
      child: OutlinedButton(
        style: OutlinedButton.styleFrom(
            side: BorderSide(
              color: TColors.danger,
            ),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(TSizes.borderRadiusSm))
        ),
        onPressed: (){},
        child: RichText(
            text: TextSpan(
                style: Theme.of(context).textTheme.labelMedium,
                children: const <TextSpan> [
                  TextSpan(
                      text: 'Log Out',
                      style: TextStyle(color: TColors.danger, fontSize: TSizes.fontSize16)
                  )
                ]
            )
        ),
      ),
    );
  }
}
import 'package:flutter/material.dart';

import '../../../../../../utils/constants/colors.dart';
import '../../../../../../utils/constants/sizes.dart';


class ProfileDetailsScreen extends StatelessWidget {
  const ProfileDetailsScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
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
                color: TColors.secondaryBorder
              ),
              child: Center(
                child: RichText(
                    text: TextSpan(
                        style: Theme.of(context).textTheme.labelMedium,
                        children: const <TextSpan> [
                          TextSpan(
                              text: 'JF',
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
                        children: const <TextSpan> [
                          TextSpan(
                              text: 'Joshua Fajobi',
                              style: TextStyle(fontWeight: TSizes.fontWeightMd)
                          )
                        ]
                    )
                ),
                RichText(
                    text: TextSpan(
                        style: Theme.of(context).textTheme.labelSmall,
                        children: const <TextSpan> [
                          TextSpan(
                              text: 'joshuamayowa23@yahoo.com',
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
              onPressed: (){},
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
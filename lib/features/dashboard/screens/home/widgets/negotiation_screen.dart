import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:swappr/common/styles/spacing_styles.dart';
import 'package:swappr/common/widgets/buttons/elevated_button.dart';
import 'package:swappr/utils/constants/colors.dart';
import 'package:swappr/utils/constants/sizes.dart';
import 'package:swappr/utils/helpers/helper_functions.dart';
import 'package:swappr/utils/layouts/bottom_sheet_widget.dart';

import '../accept_review_details.dart';

class NegotiationScreen extends StatelessWidget {
  const NegotiationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return HalfBottomSheetWidget(
        title: "I'm interested, but...",
        child: SizedBox(
          height: THelperFunctions.screenHeight() * 0.52,
          child: Form(
            child:
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('I have', style: Theme.of(context).textTheme.labelSmall,),
                    SizedBox(
                      height: TSizes.textInputFieldHeight,
                      child: TextFormField(
                        style: TextStyle(
                          color: TColors.textPrimary.withOpacity(0.4),
                          fontSize: 14,
                          fontFamily: 'Roboto',
                          fontWeight: FontWeight.w400
                        )
                      ),
                    ),
                    const SizedBox(height: TSizes.spaceBtwInputFields,),
                    Text('At', style: Theme.of(context).textTheme.labelSmall,),
                    SizedBox(
                      height: TSizes.textInputFieldHeight,
                      child: TextFormField(
                          style: TextStyle(
                              color: TColors.textPrimary.withOpacity(0.4),
                              fontSize: 14,
                              fontFamily: 'Roboto',
                              fontWeight: FontWeight.w400
                          )
                      ),
                    ),
                  ],
                ),
                TElevatedButton(onTap: (){Get.to(() => const AcceptReviewDetailsScreen());}, buttonText: 'Done')
              ],
            ),
          ),
        ));
  }
}

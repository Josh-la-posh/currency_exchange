
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:swappr/features/negotiation_offer/screen/negotiation_accept_reject.dart';
import 'package:swappr/features/negotiation_offer/widget/negotiation_list.dart';
import '../../../common/widgets/divider.dart';
import '../../../utils/constants/colors.dart';
import '../../../utils/constants/sizes.dart';
import '../../transaction/icons/svg.dart';

class NegotiationItem extends StatelessWidget {
  // final TransactionEntity item;
  const NegotiationItem({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    // String? status = item.status;
    return Column(
      children: [
        ListTile(
          onTap: (){
            Get.to(() => const NegotiationAcceptRejectScreen());
          },
          contentPadding: EdgeInsets.symmetric(vertical: TSizes.md, horizontal: TSizes.defaultSpace),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  TransactionIcon(),
                  const SizedBox(width: TSizes.lg,),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      RichText(
                          text: TextSpan(
                              style: Theme.of(context).textTheme.labelSmall,
                              children: const <TextSpan> [
                                TextSpan(
                                  text: '400 GPB - 20,000 NGN',
                                    style: TextStyle(fontSize: TSizes.fontSize11, fontWeight: TSizes.fontWeightLg)
                                ),
                              ]
                          )
                      ),
                      RichText(
                          text: TextSpan(
                              style: Theme.of(context).textTheme.labelMedium,
                              children: const <TextSpan> [
                                TextSpan(
                                    text: 'Offer',
                                    style: TextStyle(
                                      fontSize: TSizes.fontSize10,
                                      color: TColors.golden,

                                    )
                                ),
                              ]
                          )
                      ),
                    ],
                  )
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  RichText(
                      text: TextSpan(
                          style: Theme.of(context).textTheme.labelMedium,
                          children: const <TextSpan> [
                            TextSpan(
                              text: '600 NGN // GBP ',
                                style: TextStyle(fontSize: TSizes.fontSize11, color: TColors.primary)
                            ),
                          ]
                      )
                  ),
                  RichText(
                      text: TextSpan(
                          style: Theme.of(context).textTheme.labelSmall,
                          children: <TextSpan> [
                            TextSpan(
                                text: 'Jun 5, 10:00 AM',
                                style: TextStyle(
                                    color: TColors.textPrimary.withOpacity(0.5),
                                    fontSize: TSizes.fontSize9
                                )
                            ),
                          ]
                      )
                  ),
                ],
              )
            ],
          ),
        ),
        const DividerWidget()
      ],
    );
  }
}

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';
import 'package:swappr/data/provider/subscription_provider.dart';
import 'package:swappr/features/subscription/apis/api.dart';
import 'package:swappr/features/subscription/models/subscribeEnity.dart';
import 'package:swappr/utils/helpers/helper_functions.dart';
import '../../../common/widgets/divider.dart';
import '../../../utils/constants/colors.dart';
import '../../../utils/constants/image_strings.dart';
import '../../../utils/constants/sizes.dart';
import '../../../utils/constants/texts.dart';

class SubscriptionItem extends StatelessWidget {
  final SubscriptionEntity item;
  SubscriptionItem({
    required this.item,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<SubscriptionProvider>(context);
    return Column(
      children: [
        Container(
          height: TSizes.textReviewHeight * 1.4,
          color: TColors.secondaryBorder30,
          // padding: const EdgeInsets.only(left: TSizes.defaultSpace / 1.5),
          child: Slidable(
            key: const ValueKey(0),
            endActionPane: ActionPane(
                extentRatio: 0.2,
                motion: const ScrollMotion(),
                // dismissible: DismissiblePane(onDismissed: (){}),
                children: [
                  Builder(
                      builder: (cont) {
                        return SizedBox(
                          height: 68,
                          width: 60,
                          child: ElevatedButton(
                            onPressed: () {
                              SubscriptionService.instance.deleteSubscription(id: item.id, subscriptionProvider: provider);
                            },
                            style: ElevatedButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10)
                                ),
                                backgroundColor: TColors.danger,
                                padding: EdgeInsets.all(0)
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                SizedBox(
                                    height: 24,
                                    width: 24,
                                    child: Image(image: AssetImage(TImages.trashIcon))
                                ),
                                Text(
                                  'Delete',
                                  style: TextStyle(
                                      fontSize: 12,
                                      fontFamily: TTexts.fontFamily,
                                      fontWeight: FontWeight.w400,
                                      color: Colors.white
                                  ),
                                )
                              ],
                            ),
                          ),
                        );
                      }
                  ),
                  // SlidableAction(
                  //   onPressed: ((context){
                  //     SubscriptionService.instance.deleteSubscription(id: item.id, subscriptionProvider: provider);
                  //   }),
                  //   backgroundColor: TColors.danger,
                  //   icon: Icons.delete,
                  //   // label: 'Delete',
                  // ),
                ]
            ),
            child: ListTile(
              dense: true,
              contentPadding: const EdgeInsets.only(left: TSizes.defaultSpace / 1.5, top: 0, bottom: 0, right: TSizes.defaultSpace / 1.5),
              title: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      RichText(
                          text: TextSpan(
                              style: Theme.of(context).textTheme.bodyMedium,
                              children: <TextSpan> [
                                TextSpan(
                                    text: 'has: ${item.debitedCurrency}',
                                    style: TextStyle(fontWeight: TSizes.fontWeightMd)
                                ),
                              ]
                          )
                      ),
                      Row(
                        children: [
                          RichText(
                              text: TextSpan(
                                  style: Theme.of(context).textTheme.labelMedium,
                                  children: <TextSpan> [
                                    TextSpan(
                                        text: '${item.maxRate} ${item.debitedCurrency} // ${item.creditedCurrency}',
                                        style: TextStyle(fontSize: TSizes.fontSize12, color: Color(0xFF5ABFE4))
                                    ),
                                  ]
                              )
                          ),
                          SizedBox(width: 10,),
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: 7,),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(
                                color: TColors.black,
                                width: 1
                              ),
                              color: Color(0xFFA2C8D6)
                            ),
                            child:
                            RichText(
                                text: TextSpan(
                                    style: Theme.of(context).textTheme.labelSmall,
                                    children: <TextSpan> [
                                      TextSpan(
                                          text: 'Max',
                                          style: TextStyle(fontSize: TSizes.fontSize10)
                                      ),
                                    ]
                                )
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: TSizes.sm,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [

                      RichText(
                          text: TextSpan(
                              style: Theme.of(context).textTheme.bodyMedium,
                              children: <TextSpan> [
                                TextSpan(
                                    text: 'needs: ${item.creditedCurrency}',
                                    style: TextStyle(fontWeight: TSizes.fontWeightMd)
                                ),
                              ]
                          )
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              RichText(
                                  text: TextSpan(
                                      style: Theme.of(context).textTheme.labelMedium,
                                      children: <TextSpan> [
                                        TextSpan(
                                            text: '${item.minRate} ${item.debitedCurrency} // ${item.creditedCurrency}',
                                            style: TextStyle(fontSize: TSizes.fontSize12, color: TColors.primary)
                                        ),
                                      ]
                                  )
                              ),
                              SizedBox(width: 10,),
                              Container(
                                padding: EdgeInsets.symmetric(horizontal: 8,),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    border: Border.all(
                                        color: TColors.black,
                                        width: 1
                                    ),
                                    color: TColors.secondaryBorder
                                ),
                                child:
                                RichText(
                                    text: TextSpan(
                                        style: Theme.of(context).textTheme.labelSmall,
                                        children: <TextSpan> [
                                          TextSpan(
                                              text: 'Min',
                                              style: TextStyle(fontSize: TSizes.fontSize10)
                                          ),
                                        ]
                                    )
                                ),
                              )
                            ],
                          ),
                          RichText(
                              text: TextSpan(
                                  style: Theme.of(context).textTheme.labelSmall,
                                  children: <TextSpan> [
                                    TextSpan(
                                        text: '${THelperFunctions.getFormattedDate(item.createdDate)}  - ${THelperFunctions.getFormattedTime(item.createdDate)}',
                                        style: TextStyle(color: TColors.primary)
                                    ),
                                  ]
                              )
                          ),
                        ],
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
        Container(
          height: 3,
          color: Color(0XFFD9D9D9),
        )
      ],
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import 'package:pouch/features/subscription/controller/subscription_controller.dart';
import 'package:pouch/features/subscription/models/subscribeEnity.dart';
import 'package:pouch/utils/helpers/helper_functions.dart';
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
    SubscriptionController controller = Get.find();
    final darkMode = THelperFunctions.isDarkMode(context);
    return Column(
      children: [
        Container(
          height: TSizes.textReviewHeight * 1.4,
          color: darkMode ? TColors.textPrimaryO40 : Colors.white,
          child: Slidable(
            key: ValueKey(item.id),
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
                              controller.deleteSubscription(id: item.id.toString());
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
                ]
            ),
            child: ListTile(
              dense: true,
              contentPadding: const EdgeInsets.only(left: TSizes.defaultSpace * 0.8, top: 0, bottom: 0, right: TSizes.defaultSpace * 0.8),
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
                                    text: 'has: ',
                                    style: TextStyle(fontWeight: TSizes.fontWeightNm, fontSize: 13)
                                ),
                                TextSpan(
                                    text: item.debitedCurrency,
                                    style: TextStyle(fontWeight: TSizes.fontWeightMd)
                                ),
                              ]
                          )
                      ),
                      Row(
                        children: [
                          RichText(
                              text: TextSpan(
                                  style: Theme.of(context).textTheme.bodyMedium,
                                  children: <TextSpan> [
                                    TextSpan(
                                        text: '${item.maxRate} ',
                                        style: TextStyle(color: Color(0xFF5ABFE4))
                                    ),
                                    TextSpan(
                                        text: '${item.creditedCurrency} // ${item.debitedCurrency}',
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
                                    text: 'needs: ',
                                    style: TextStyle(fontWeight: TSizes.fontWeightNm, fontSize: 13)
                                ),
                                TextSpan(
                                    text: item.creditedCurrency,
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
                                      style: Theme.of(context).textTheme.bodyMedium,
                                      children: <TextSpan> [
                                        TextSpan(
                                            text: '${item.minRate} ',
                                            style: TextStyle( color: TColors.primary)
                                        ),
                                        TextSpan(
                                            text: '${item.creditedCurrency} // ${item.debitedCurrency}',
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
                          // RichText(
                          //     text: TextSpan(
                          //         style: Theme.of(context).textTheme.labelSmall,
                          //         children: <TextSpan> [
                          //           TextSpan(
                          //               text: '${THelperFunctions.getFormattedDate(item.createdDate.toString())}  - ${THelperFunctions.getFormattedTime(item.createdDate.toString())}',
                          //               style: TextStyle(color: TColors.primary)
                          //           ),
                          //         ]
                          //     )
                          // ),
                        ],
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
        SizedBox(height: 8,)
      ],
    );
  }
}

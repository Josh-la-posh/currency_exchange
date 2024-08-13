import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:pouch/common/widgets/custom_time_line.dart';
import 'package:pouch/common/widgets/divider.dart';
import 'package:pouch/utils/constants/colors.dart';
import 'package:pouch/utils/helpers/helper_functions.dart';
import 'package:pouch/utils/layouts/bottom_sheet_widget.dart';
import 'package:pouch/utils/layouts/list_layout.dart';

import '../../../../utils/constants/sizes.dart';
import '../../../utils/constants/image_strings.dart';
import '../icons/svg.dart';
import '../models/transaction_entity.dart';

class TransactionDetails extends StatelessWidget {
  final TransactionEntity item;
  const TransactionDetails({
    super.key,
    required this.item
  });

  @override
  Widget build(BuildContext context) {
    final darkMode = THelperFunctions.isDarkMode(context);
    return HalfBottomSheetWidget(
        title: 'Transaction Details',
        child: Column(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  padding: const EdgeInsets.all(5),
                  height: 24,
                  width: 24,
                  decoration: BoxDecoration(
                    color: darkMode ? TColors.grey : TColors.secondaryBorder30,
                    borderRadius: BorderRadius.circular(50),

                  ),
                    child: TransactionIcon()
                ),
                const SizedBox(height: TSizes.spaceBtwElements,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    RichText(
                        text: TextSpan(
                            style: Theme.of(context).textTheme.headlineLarge,
                            children: <TextSpan> [
                              TextSpan(
                                  text: item.rate == null ? '' : '${THelperFunctions.moneyFormatter(THelperFunctions.getStringMultiplication(THelperFunctions.formatRate(item.rate.toString()), item.amount.toString()))} ${item.debitedCurrency}  ',
                                  style: TextStyle(
                                      color: darkMode ? TColors.grey : TColors.textPrimaryO80
                                  )
                              )
                            ]
                        )
                    ),
                    if (item.rate != null)
                    Image(image: AssetImage(TImages.handIcon), height: 25, color: TColors.primary,),
                    RichText(
                        text: TextSpan(
                            style: Theme.of(context).textTheme.headlineLarge,
                            children: <TextSpan> [
                              TextSpan(
                                  text: item.rate == null ? '${THelperFunctions.moneyFormatter(item.amount.toString())} ${item.creditedCurrency != null ? item.creditedCurrency : item.debitedCurrency}' : ' ${THelperFunctions.moneyFormatter(item.amount.toString())} ${item.creditedCurrency}',
                                  style: TextStyle(
                                      color: darkMode ? TColors.grey : TColors.textPrimaryO80
                                  )
                              )
                            ]
                        )
                    ),
                  ],
                ),
                const SizedBox(height: TSizes.spaceBtwElements,),
                RichText(
                    text: TextSpan(
                        style: Theme.of(context).textTheme.labelMedium,
                        children: <TextSpan> [
                          TextSpan(
                              text: item.rate == null ? '${item.status}' : '${(THelperFunctions.formatRate(item.rate.toString()))} ${item.creditedCurrency} // ${item.debitedCurrency}',
                              style: TextStyle(fontSize: TSizes.fontSize11, color: TColors.primary, fontWeight: FontWeight.w700)
                          ),
                        ]
                    )
                ),

              ],
            ),
            const SizedBox(height: TSizes.spaceBtwSections,),
            Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    RichText(
                        text: TextSpan(
                            style: Theme.of(context).textTheme.labelMedium,
                            children: const <TextSpan> [
                              TextSpan(
                                  text: 'Source',
                                  style: TextStyle(
                                    height: 1.39,
                                    fontSize: 13
                                  )
                              ),
                            ]
                        )
                    ),
                    SizedBox(
                      width: THelperFunctions.screenWidth() * 0.6,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            RichText(
                                text: TextSpan(
                                    style: Theme.of(context).textTheme.labelSmall,
                                    children: <TextSpan> [
                                      TextSpan(
                                          text: item.debitedWallet == null ? item.description : item.debitedWallet,
                                          style: TextStyle(
                                              fontSize: TSizes.fontSize12,
                                              height: 1.39,
                                              fontWeight: FontWeight.w700
                                          )
                                      )
                                    ]
                                )
                            ),
                            // Row(
                            //   crossAxisAlignment: CrossAxisAlignment.end,
                            //   children: [
                            //     RichText(
                            //         text: TextSpan(
                            //             style: Theme.of(context).textTheme.labelSmall,
                            //             children: <TextSpan> [
                            //               TextSpan(
                            //                   text: '60-00-06',
                            //                   style: TextStyle(
                            //                     fontSize: TSizes.fontSize10,
                            //                     color: TColors.textPrimary.withOpacity(0.5),
                            //                     height: 1.4
                            //                   )
                            //               ),
                            //             ]
                            //         )
                            //     ),
                            //     RichText(
                            //         text: TextSpan(
                            //             style: Theme.of(context).textTheme.labelSmall,
                            //             children: <TextSpan> [
                            //               TextSpan(
                            //                   text: ' * ',
                            //                   style: TextStyle(
                            //                       fontSize: TSizes.fontSize10,
                            //                       color: TColors.textPrimary.withOpacity(0.5),
                            //                       height: 1.4
                            //                   )
                            //               ),
                            //             ]
                            //         )
                            //     ),
                            //     RichText(
                            //         text: TextSpan(
                            //             style: Theme.of(context).textTheme.labelSmall,
                            //             children: <TextSpan> [
                            //               TextSpan(
                            //                   text: '445347697',
                            //                   style: TextStyle(
                            //                       fontSize: TSizes.fontSize10,
                            //                       color: TColors.textPrimary.withOpacity(0.5),
                            //                       height: 1.4
                            //                   )
                            //               ),
                            //             ]
                            //         )
                            //     ),
                            //   ],
                            // ),
                          ],
                        ),
                      )
                  ],
                ),
                const SizedBox(height: TSizes.spaceBtwItems,),
                const DividerWidget(),
                const SizedBox(height: TSizes.spaceBtwItems,),
                if (item.creditedWallet != null)
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    RichText(
                        text: TextSpan(
                            style: Theme.of(context).textTheme.labelMedium,
                            children: <TextSpan> [
                              TextSpan(
                                  text: 'Destination',
                                  style: TextStyle(
                                    fontSize: TSizes.fontSize12,
                                    height: 1.39,
                                  )
                              ),
                            ]
                        )
                    ),
                    SizedBox(
                      width: THelperFunctions.screenWidth() * 0.6,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          RichText(
                              text: TextSpan(
                                  style: Theme.of(context).textTheme.labelSmall,
                                  children: <TextSpan> [
                                    TextSpan(
                                        text: item.creditedWallet,
                                        style: TextStyle(
                                            fontSize: TSizes.fontSize12,
                                            height: 1.39,
                                            fontWeight: FontWeight.w700
                                        )
                                    )
                                  ]
                              )
                          ),
                          // Row(
                          //   crossAxisAlignment: CrossAxisAlignment.end,
                          //   children: [
                          //     RichText(
                          //         text: TextSpan(
                          //             style: Theme.of(context).textTheme.labelSmall,
                          //             children: <TextSpan> [
                          //               TextSpan(
                          //                   text: '60-00-06',
                          //                   style: TextStyle(
                          //                       fontSize: TSizes.fontSize10,
                          //                       color: TColors.textPrimary.withOpacity(0.5),
                          //                       height: 1.4
                          //                   )
                          //               ),
                          //             ]
                          //         )
                          //     ),
                          //     RichText(
                          //         text: TextSpan(
                          //             style: Theme.of(context).textTheme.labelSmall,
                          //             children: <TextSpan> [
                          //               TextSpan(
                          //                   text: ' * ',
                          //                   style: TextStyle(
                          //                       fontSize: TSizes.fontSize10,
                          //                       color: TColors.textPrimary.withOpacity(0.5),
                          //                       height: 1.4
                          //                   )
                          //               ),
                          //             ]
                          //         )
                          //     ),
                          //     RichText(
                          //         text: TextSpan(
                          //             style: Theme.of(context).textTheme.labelSmall,
                          //             children: <TextSpan> [
                          //               TextSpan(
                          //                   text: '445347697',
                          //                   style: TextStyle(
                          //                       fontSize: TSizes.fontSize10,
                          //                       color: TColors.textPrimary.withOpacity(0.5),
                          //                       height: 1.4
                          //                   )
                          //               ),
                          //             ]
                          //         )
                          //     ),
                          //   ],
                          // ),
                        ],
                      ),
                    )
                  ],
                ),
                const SizedBox(height: TSizes.spaceBtwItems,),
                // Container(
                //   height: THelperFunctions.screenHeight() * 0.25,
                //   padding: const EdgeInsets.symmetric(vertical: TSizes.xl, horizontal: TSizes.lg),
                //   decoration: const BoxDecoration(color: TColors.primaryBackground),
                //   child: TListLayout(
                //       itemCount: 4,
                //       itemBuilder: (_, index) =>  MyTimeLine(
                //         isFirst: index == 0 ? true : false,
                //         isLast: index == 3 ? true : false,
                //         isDone: index == 3 ? false : true,
                //         startChild: Container(
                //           padding: const EdgeInsets.only(bottom: 7),
                //           child: Column(
                //             crossAxisAlignment: CrossAxisAlignment.start,
                //             children: [
                //               RichText(
                //                   text: TextSpan(
                //                       style: Theme.of(context).textTheme.labelSmall,
                //                       children: <TextSpan> [
                //                         TextSpan(
                //                             text: 'June 3',
                //                             style: TextStyle(
                //                                 color: TColors.textPrimary.withOpacity(0.6),
                //                                 height: 1.5
                //                             )
                //                         ),
                //                       ]
                //                   )
                //               ),
                //               RichText(
                //                   text: TextSpan(
                //                       style: Theme.of(context).textTheme.labelSmall,
                //                       children: <TextSpan> [
                //                         TextSpan(
                //                             text: '12:00 am',
                //                             style: TextStyle(
                //                                 fontSize: TSizes.fontSize9,
                //                                 color: TColors.textPrimary.withOpacity(0.3),
                //                                 height: 2
                //                             )
                //                         ),
                //                       ]
                //                   )
                //               ),
                //             ],
                //           ),
                //         ),
                //         endChild: Container(
                //             margin: const EdgeInsets.only(left: 10),
                //             padding: const EdgeInsets.only(bottom: 22),
                //             child: Text('You created this offer', style: Theme.of(context).textTheme.labelMedium,)),
                //       )
                //   ),
                // )
              ],
            )
          ],
        )
    );
  }
}

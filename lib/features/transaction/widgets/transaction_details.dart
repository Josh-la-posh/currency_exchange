import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:swappr/common/widgets/custom_time_line.dart';
import 'package:swappr/common/widgets/divider.dart';
import 'package:swappr/utils/constants/colors.dart';
import 'package:swappr/utils/helpers/helper_functions.dart';
import 'package:swappr/utils/layouts/bottom_sheet_widget.dart';
import 'package:swappr/utils/layouts/list_layout.dart';

import '../../../../utils/constants/sizes.dart';
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
                    color: TColors.secondaryBorder,
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
                                  text: item.rate == null ? '' : '${item.amount} ${item.debitedCurrency} ---',
                                  style: TextStyle(color: TColors.textPrimaryO80)
                              )
                            ]
                        )
                    ),
                    RichText(
                        text: TextSpan(
                            style: Theme.of(context).textTheme.headlineLarge,
                            children: <TextSpan> [
                              TextSpan(
                                  text: item.rate == null ? '${item.amount} ${item.creditedCurrency}' : '${THelperFunctions.getStringMultiplication(item.rate as String, item.amount)} ${item.creditedCurrency}',
                                  style: TextStyle(color: TColors.textPrimaryO80)
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
                              text: item.rate == null ? '${item.status}' : '${item.rate} ${item.creditedCurrency} // ${item.debitedCurrency}',
                              style: TextStyle(fontSize: TSizes.fontSize11, color: TColors.primary)
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
                                    fontSize: TSizes.fontSize13,
                                    height: 1.39
                                  )
                              ),
                            ]
                        )
                    ),
                    Row(
                      children: [
                        // Container(
                        //   width: 20,
                        //   height: 20,
                        //   color: TColors.danger,
                        // ),
                        // const SizedBox(width: TSizes.md,),
                        SizedBox(
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
                                            style: TextStyle(height: 1.34)
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
                                    fontSize: TSizes.fontSize13,
                                    height: 1.39
                                  )
                              ),
                            ]
                        )
                    ),
                    Row(
                      children: [
                        // Container(
                        //   width: 20,
                        //   height: 20,
                        //   color: TColors.danger,
                        // ),
                        const SizedBox(width: TSizes.md,),
                        SizedBox(
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
                                            style: TextStyle(height: 1.34)
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

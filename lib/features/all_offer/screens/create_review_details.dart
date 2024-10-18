import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pouch/features/all_offer/controllers/create_offer_controller.dart';
import 'package:pouch/features/all_offer/controllers/offer_controller.dart';
import 'package:pouch/utils/helpers/controller/helper_function_controller.dart';
import 'package:pouch/common/widgets/buttons/elevated_button.dart';
import 'package:pouch/features/home/icons/svg.dart';
import 'package:pouch/utils/constants/colors.dart';
import 'package:pouch/utils/constants/enums.dart';
import 'package:pouch/utils/constants/sizes.dart';
import '../../../data/modules/interceptor.dart';
import '../../../utils/helpers/helper_functions.dart';

class CreateReviewDetailsScreen extends StatelessWidget {
  final AppInterceptor appInterceptor = AppInterceptor();

  @override
  Widget build(BuildContext context) {
    CreateOfferController createOfferController = Get.find();
    OfferController offerController = Get.find();
    HelperFunctionsController helperFunctionsController = Get.find();
    final darkMode = THelperFunctions.isDarkMode(context);
    return Scaffold(
      backgroundColor: darkMode ? TColors.textPrimaryO40 : Colors.white,
      appBar: AppBar(
        backgroundColor: darkMode ? TColors.textPrimary.withOpacity(0) : Colors.white,
        surfaceTintColor: darkMode ? TColors.textPrimary.withOpacity(0) : Colors.white,
        leading: IconButton(
          onPressed: (){
            appInterceptor.cancelOngoingRequest(() {
              offerController.resetBoolForOutgoingRequests();
            });
            Get.back();
            },
          icon: const Icon(Icons.arrow_back),
          style: IconButton.styleFrom(
              foregroundColor: Colors.grey,
              iconSize: TSizes.iconBackSize
          ),
          hoverColor: Colors.transparent,
        ),
        title: Text(
            'Review Details',
            style: Theme.of(context).textTheme.titleMedium
        ),
        centerTitle: true,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.only(bottom: 100),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    alignment: Alignment.centerLeft,
                    width: double.infinity,
                    height: 48,
                    color: TColors.primaryBackground,
                    padding: const EdgeInsets.symmetric(horizontal: TSizes.defaultSpace),
                    child: RichText(
                        text: TextSpan(
                            style: Theme.of(context).textTheme.labelMedium,
                            children: <TextSpan> [
                              TextSpan(
                                  text: 'Offer Summary',
                                  style: TextStyle(
                                      fontWeight: TSizes.fontWeightMd,
                                      color: TColors.textPrimaryO80
                                  )
                              )
                            ]
                        )
                    ),
                  ),
                  const SizedBox(height: TSizes.md),
                  Column(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: TSizes.defaultSpace),
                        height: TSizes.textReviewHeight,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            RichText(
                                text: TextSpan(
                                    style: Theme.of(context).textTheme.labelMedium,
                                    children: const <TextSpan> [
                                      TextSpan(
                                        text: 'I have',
                                      )
                                    ]
                                )
                            ),
                            RichText(
                                text: TextSpan(
                                    style: Theme.of(context).textTheme.labelMedium,
                                    children: <TextSpan> [
                                      TextSpan(
                                          text: '${helperFunctionsController.moneyFormatter(createOfferController.amountController.text)} ${getCurrencyName(createOfferController.debitedCurrency.value)}',
                                          style: const TextStyle(
                                            // fontSize: TSizes.fontSize13,
                                              fontWeight: TSizes.fontWeightLg
                                          )
                                      )
                                    ]
                                )
                            ),
                          ],
                        ),
                      ),

                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: TSizes.defaultSpace),
                        height: TSizes.textReviewHeight,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            RichText(
                                text: TextSpan(
                                    style: Theme.of(context).textTheme.labelMedium,
                                    children: const <TextSpan> [
                                      TextSpan(
                                        text: 'I need',
                                        // style: TextStyle(fontSize: TSizes.fontSize13)
                                      )
                                    ]
                                )
                            ),
                            RichText(
                                text: TextSpan(
                                    style: Theme.of(context).textTheme.labelMedium,
                                    children: <TextSpan> [
                                      TextSpan(
                                          text: getCurrencyName(createOfferController.creditedCurrency.value),
                                          style: const TextStyle(
                                            // fontSize: TSizes.fontSize13,
                                              fontWeight: TSizes.fontWeightLg
                                          )
                                      )
                                    ]
                                )
                            ),
                          ],
                        ),
                      ),

                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: TSizes.defaultSpace),
                        height: TSizes.textReviewHeight,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            RichText(
                                text: TextSpan(
                                    style: Theme.of(context).textTheme.labelMedium,
                                    children: const <TextSpan> [
                                      TextSpan(
                                        text: 'Rate',
                                        // style: TextStyle(fontSize: TSizes.fontSize13)
                                      )
                                    ]
                                )
                            ),
                            RichText(
                                text: TextSpan(
                                    style: Theme.of(context).textTheme.labelMedium,
                                    children: <TextSpan> [
                                      TextSpan(
                                          text: '${createOfferController.rateController.text} ${getCurrencyName(createOfferController.creditedCurrency.value)} // ${getCurrencyName(createOfferController.debitedCurrency.value)}',
                                          style: const TextStyle(
                                              fontWeight: TSizes.fontWeightLg
                                          )
                                      )
                                    ]
                                )
                            ),
                          ],
                        ),
                      ),

                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: TSizes.defaultSpace),
                        height: TSizes.textReviewHeight,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            RichText(
                                text: TextSpan(
                                    style: Theme.of(context).textTheme.labelMedium,
                                    children: const <TextSpan> [
                                      TextSpan(
                                        text: 'Expected Returns',
                                      )
                                    ]
                                )
                            ),
                            RichText(
                                text: TextSpan(
                                    style: Theme.of(context).textTheme.labelMedium,
                                    children: <TextSpan> [
                                      TextSpan(
                                          text: '${helperFunctionsController.moneyFormatter(helperFunctionsController.multipliedString.value)} ${getCurrencyName(createOfferController.creditedCurrency.value)}',
                                          style: const TextStyle(
                                              fontWeight: TSizes.fontWeightLg
                                          )
                                      )
                                    ]
                                )
                            ),
                          ],
                        ),
                      ),

                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: TSizes.defaultSpace),
                        height: TSizes.textReviewHeight,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            RichText(
                                text: TextSpan(
                                    style: Theme.of(context).textTheme.labelMedium,
                                    children: const <TextSpan> [
                                      TextSpan(
                                        text: 'Expires in',
                                      )
                                    ]
                                )
                            ),
                            RichText(
                                text: TextSpan(
                                    style: Theme.of(context).textTheme.labelMedium,
                                    children: <TextSpan> [
                                      TextSpan(
                                          text: createOfferController.expiryHour.value == 'Never' ? "Don't expire" : '${createOfferController.expiryHour.value} hour',
                                          style: const TextStyle(
                                              fontWeight: TSizes.fontWeightLg
                                          )
                                      )
                                    ]
                                )
                            ),
                          ],
                        ),
                      ),

                      Column(
                        children: [
                          const SizedBox(height: TSizes.xs),
                          Container(
                            width: double.infinity,
                            padding: const EdgeInsets.only(left: TSizes.defaultSpace),
                            height: TSizes.textReviewHeight,
                            decoration: BoxDecoration(
                              color: TColors.secondaryBorder30,
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                RichText(
                                    text: TextSpan(
                                        style: Theme.of(context).textTheme.labelMedium,
                                        children: <TextSpan> [
                                          TextSpan(
                                              text: 'You will be debited from ',
                                              style: TextStyle(
                                                  fontSize: TSizes.fontSize13,
                                                  color: darkMode ? TColors.white : TColors.primary
                                              )
                                          ),
                                          TextSpan(
                                              text: ' ${getCurrencyName(createOfferController.debitedCurrency.value)} ',
                                              style: TextStyle(
                                                  fontWeight: FontWeight.w700,
                                                  color: darkMode ? TColors.white : TColors.primary
                                              )
                                          ),
                                          TextSpan(
                                              text: ' wallet',
                                              style: TextStyle(
                                                  fontSize: TSizes.fontSize13,
                                                  color: darkMode ? TColors.white : TColors.primary
                                              )
                                          )
                                        ]
                                    )
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: TSizes.defaultSpace,),
                          Container(
                            width: double.infinity,
                            padding: const EdgeInsets.only(left: TSizes.defaultSpace),
                            height: TSizes.textReviewHeight,
                            decoration: BoxDecoration(
                              color: TColors.secondaryBorder30,
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                RichText(
                                    text: TextSpan(
                                        style: Theme.of(context).textTheme.labelMedium,
                                        children: <TextSpan> [
                                          TextSpan(
                                              text: 'You will be credited to ',
                                              style: TextStyle(
                                                  fontSize: TSizes.fontSize13,
                                                  color: darkMode ? TColors.white : TColors.primary
                                              )
                                          ),
                                          TextSpan(
                                              text: ' ${getCurrencyName(createOfferController.creditedCurrency.value)} ',
                                              style: TextStyle(
                                                  fontWeight: FontWeight.w700,
                                                  color: darkMode ? TColors.white : TColors.primary
                                              )
                                          ),
                                          TextSpan(
                                              text: ' wallet',
                                              style: TextStyle(
                                                  fontSize: TSizes.fontSize13,
                                                  color: darkMode ? TColors.white : TColors.primary
                                              )
                                          )
                                        ]
                                    )
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: TSizes.xs),
                        ],
                      ),

                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: TSizes.defaultSpace),
                        height: TSizes.textReviewHeight,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                RichText(
                                    text: TextSpan(
                                        style: Theme.of(context).textTheme.labelMedium,
                                        children: const <TextSpan> [
                                          TextSpan(
                                            text: 'Fee',
                                          )
                                        ]
                                    )

                                ),
                                const SizedBox(width: TSizes.md),
                                NotiIcon(),
                              ],
                            ),
                            RichText(
                                text: TextSpan(
                                    style: Theme.of(context).textTheme.labelMedium,
                                    children: <TextSpan> [
                                      TextSpan(
                                          // text: '${TPriceCalculator.calculateFee(getCurrencyName(createOfferController.debitedCurrency.value))} ${getCurrencyName(createOfferController.debitedCurrency.value)}',
                                          text: '0 ${getCurrencyName(createOfferController.debitedCurrency.value)}',
                                          style: const TextStyle(
                                            // fontSize: TSizes.fontSize13,
                                              fontWeight: TSizes.fontWeightLg)
                                      )
                                    ]
                                )
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: TSizes.spaceBtwSections),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: TSizes.defaultSpace),
                        child: Obx(() => TElevatedButton(
                            onTap: offerController.isCreatingOfferLoading.value ? null : (){
                              offerController.creatingOffer(
                                  debitedCurrency: getCurrencyName(createOfferController.debitedCurrency.value),
                                  creditedCurrency: getCurrencyName(createOfferController.creditedCurrency.value),
                                  amount: createOfferController.amountController.text,
                                  rate: createOfferController.rateController.text,
                                  expireIn: createOfferController.expiryHour.value,
                                  onSuccess: () {
                                    createOfferController.clearForm();
                                    helperFunctionsController.multipliedString.value = '0';
                                  }
                              );
                            },
                            buttonText: offerController.isCreatingOfferLoading.value ? 'Paying ...' : 'Pay ${helperFunctionsController.moneyFormatter(createOfferController.amountController.text.toString())} ${getCurrencyName(createOfferController.debitedCurrency.value)}')),
                      ),
                      const SizedBox(height: TSizes.spaceBtwElements),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          NotiIcon(height: 15),
                          const SizedBox(width: TSizes.sm),
                          SizedBox(
                            width: THelperFunctions.screenWidth() * 0.6,
                            child: FittedBox(
                              fit: BoxFit.fill,
                              child: RichText(
                                  text: TextSpan(
                                      style: Theme.of(context).textTheme.labelSmall,
                                      children: const <TextSpan> [
                                        TextSpan(
                                            text: 'You will be fully refunded if your offer is not matched in 1hour',
                                            style: TextStyle(fontSize: TSizes.fontSize11)
                                        )
                                      ]
                                  )
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(width: TSizes.defaultSpace),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

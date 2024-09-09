import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pouch/common/widgets/currencyWidget.dart';
import 'package:pouch/features/all_offer/controllers/offer_controller.dart';
import 'package:pouch/utils/helpers/controller/helper_function_controller.dart';
import 'package:pouch/utils/helpers/helper_functions.dart';
import '../../../utils/constants/colors.dart';
import '../../../utils/constants/sizes.dart';
import '../widgets/negotiation_screen.dart';
import 'accept_review_details.dart';

class OfferDetailsScreen extends StatelessWidget {
  final OfferController offerController = Get.put(OfferController());
  final HelperFunctionsController helperFunctionsController = Get.put(HelperFunctionsController());

  @override
  Widget build(BuildContext context) {
    final darkMode = THelperFunctions.isDarkMode(context);
    final item = offerController.offerById.value;
    return Scaffold(
      backgroundColor: darkMode ? TColors.black.withOpacity(0.8) : TColors.white,
      appBar: AppBar(),
      body: Column(
        children: [
          CurrencyWidget(),
          Padding(
            padding: const EdgeInsets.all(TSizes.defaultSpace),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                RichText(
                    text: TextSpan(
                        style: Theme.of(context).textTheme.titleMedium,
                        children: const <TextSpan> [
                          TextSpan(
                              text: 'Would you like to swap?',
                              style: TextStyle(fontWeight: TSizes.fontWeightMd)
                          )
                        ]
                    )
                ),
                const SizedBox(height: TSizes.spaceBtwElements * 2),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Obx(() => RichText(
                            text: TextSpan(
                                style: Theme.of(context).textTheme.labelMedium,
                                children: <TextSpan> [
                                  TextSpan(
                                      text: 'has: ${offerController.isFetchOfferByIdLoading.value ? '---- ---' : '${item.amount} ${item.debitedCurrency}'}'
                                  ),
                                ]
                            )
                        )),
                        const SizedBox(height: TSizes.md,),
                        Obx(() => RichText(
                            text: TextSpan(
                                style: Theme.of(context).textTheme.labelMedium,
                                children: <TextSpan> [
                                  TextSpan(
                                    text: 'needs: ${offerController.isFetchOfferByIdLoading.value ? '---' : item.creditedCurrency}',
                                  ),
                                ]
                            )
                        )),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Obx(() => RichText(
                            text: TextSpan(
                                style: Theme.of(context).textTheme.labelMedium,
                                children: <TextSpan> [
                                  TextSpan(
                                      text: '${offerController.isFetchOfferByIdLoading.value ? '-- --- // ---' : '${THelperFunctions.formatRate(item.rate.toString())} ${item.creditedCurrency} // ${item.debitedCurrency}'}',
                                      style: const TextStyle(fontSize: TSizes.fontSize13, color: TColors.primary)
                                  ),
                                ]
                            )
                        )),
                        const SizedBox(height: TSizes.md,),
                        Obx(() => RichText(
                            text: TextSpan(
                                style: Theme.of(context).textTheme.labelSmall,
                                children: <TextSpan> [
                                  TextSpan(
                                    text: 'Created ${offerController.isFetchOfferByIdLoading.value ? '-- days ago' : '${THelperFunctions.getFormattedTime(item.createdDate.toString())}'}',
                                  ),
                                ]
                            )
                        )),
                      ],
                    )
                  ],
                ),
                const SizedBox(height: TSizes.spaceBtwSections),
              ],
            ),
          ),
          Obx(() {
            if (offerController.isFetchOfferByIdLoading.value == false) {
              if (item.expireIn != null) {
                return Container(
                  width: double.infinity,
                  padding: EdgeInsets.symmetric(horizontal: TSizes.defaultSpace, vertical: 10),
                  decoration: const BoxDecoration(
                      color: TColors.primaryBackground
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        height: 15,
                        width: 15,
                        decoration: BoxDecoration(
                            color: TColors.primary,
                            borderRadius: BorderRadius.circular(15)
                        ),
                        child: const Center(
                          child: Text('!', style: TextStyle(
                              color: TColors.white
                          ),
                          ),
                        ),
                      ),
                      const SizedBox(width: TSizes.md,),
                      Expanded(
                        child: RichText(
                            text: TextSpan(
                                style: Theme.of(context).textTheme.labelSmall,
                                children: <TextSpan> [
                                  TextSpan(
                                      text: 'This offer expires in ${'${item.expireCountDown == null ? '' : THelperFunctions.millisecondConversion(item.expireCountDown.toString()) ?? ''}'}',
                                      style: TextStyle(
                                          color: TColors.textPrimaryO80
                                      )
                                  ),

                                ]
                            )
                        ),
                      ),
                    ],
                  ),
                );
              } else {
                return SizedBox();
              }
            } else {
              return SizedBox();
            }
          }),
        ],
      ),
      bottomNavigationBar: Theme(
        data: Theme.of(context).copyWith(
        ),
        child: SizedBox(
          height: 150,
          child: BottomAppBar(
            padding: const EdgeInsets.all(0),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: TSizes.defaultSpace),
              color: darkMode ? TColors.black.withOpacity(0.8) : TColors.white,
              child: Obx(() {
                if (offerController.isFetchOfferByIdLoading.value == false) {
                  return Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SizedBox(
                        width: double.infinity,
                        height: TSizes.buttonHeight,
                        child: ElevatedButton(
                          onPressed: () {
                            Get.to(() => AcceptReviewDetailsScreen(item: item));
                          },
                          child: const Text("I'm interested"),
                        ),
                      ),
                      const SizedBox(height: TSizes.spaceBtwButtons,),
                      SizedBox(
                        width: double.infinity,
                        height: TSizes.buttonHeight,
                        child: OutlinedButton(
                          onPressed: () {
                            showModalBottomSheet(
                              // isDismissible: false,
                                isScrollControlled: true,
                                // enableDrag: false,
                                context: context,
                                builder: (ctx) => NegotiationScreen(id: item.id.toString(), debitedCurrency: item.debitedCurrency.toString(), creditedCurrency: item.creditedCurrency.toString())
                            );
                          }, // Handle button press
                          child: const Text("I'm interested, but..."),
                        ),
                      ),
                    ],
                  );
                } else {
                  return SizedBox();
                }
              }),
            ),
          ),
        ),
      ),
    );
  }
}


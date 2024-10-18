import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pouch/common/widgets/currencyWidget.dart';
import 'package:pouch/features/all_offer/controllers/offer_controller.dart';
import 'package:pouch/utils/helpers/helper_functions.dart';
import '../../../data/modules/interceptor.dart';
import '../../../utils/constants/colors.dart';
import '../../../utils/constants/sizes.dart';
import '../widgets/negotiation_screen.dart';
import 'accept_review_details.dart';

class OfferDetailsScreen extends StatelessWidget {
  final AppInterceptor appInterceptor = AppInterceptor();

  @override
  Widget build(BuildContext context) {
    OfferController offerController = Get.put(OfferController());
    final darkMode = THelperFunctions.isDarkMode(context);

    return Scaffold(
      backgroundColor: darkMode ? TColors.black.withOpacity(0.8) : TColors.white,
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            appInterceptor.cancelOngoingRequest(() {
              offerController.resetBoolForOutgoingRequests();
            });
            Get.back();
          },
          icon: const Icon(Icons.arrow_back),
          style: IconButton.styleFrom(
            foregroundColor: Colors.grey,
            iconSize: TSizes.iconBackSize,
          ),
          hoverColor: Colors.transparent,
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CurrencyWidget(),
          SizedBox(height: 15),
          Obx(() {
            if (offerController.isFetchOfferByIdLoading.value) {
              return const Center(child: CircularProgressIndicator());
            } else {
              final item = offerController.offerById.value;
              if (item.id == null) {
                return const Center(child: Text("No offer details available."));
              }
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: TSizes.defaultSpace),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    RichText(
                      text: TextSpan(
                        style: Theme.of(context).textTheme.titleMedium,
                        children: const <TextSpan>[
                          TextSpan(
                            text: 'Would you like to swap?',
                            style: TextStyle(fontWeight: TSizes.fontWeightMd),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: TSizes.spaceBtwElements * 2),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                RichText(
                                  text: TextSpan(
                                    style: Theme.of(context).textTheme.labelMedium,
                                    children: <TextSpan>[
                                      TextSpan(
                                        text: 'has: ${item.amount ?? ''} ${item.debitedCurrency ?? ''}',
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(height: TSizes.md),
                                RichText(
                                  text: TextSpan(
                                    style: Theme.of(context).textTheme.labelMedium,
                                    children: <TextSpan>[
                                      TextSpan(
                                        text: 'needs: ${item.creditedCurrency ?? ''}',
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                RichText(
                                  text: TextSpan(
                                    style: Theme.of(context).textTheme.labelMedium,
                                    children: <TextSpan>[
                                      TextSpan(
                                        text: '${THelperFunctions.formatRate(item.rate?.toString() ?? '0')} ${item.creditedCurrency ?? ''} // ${item.debitedCurrency ?? ''}',
                                        style: const TextStyle(
                                          fontSize: TSizes.fontSize13,
                                          color: TColors.primary,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(height: TSizes.md),
                                RichText(
                                  text: TextSpan(
                                    style: Theme.of(context).textTheme.labelSmall,
                                    children: <TextSpan>[
                                      TextSpan(
                                        text: 'Created ${offerController.helperFunctionsController.getFormattedDate(item.createdDate.toString()) ?? 'Unknown Date'} ${offerController.helperFunctionsController.getFormattedTime(item.createdDate.toString()) ?? ''}',
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        const SizedBox(height: TSizes.spaceBtwSections),
                        if (item.expireIn != null)
                          Container(
                            width: double.infinity,
                            padding: EdgeInsets.symmetric(horizontal: TSizes.defaultSpace, vertical: 10),
                            decoration: const BoxDecoration(color: TColors.primaryBackground),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                  height: 15,
                                  width: 15,
                                  decoration: BoxDecoration(
                                    color: TColors.primary,
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                  child: const Center(
                                    child: Text(
                                      '!',
                                      style: TextStyle(color: TColors.white),
                                    ),
                                  ),
                                ),
                                const SizedBox(width: TSizes.md),
                                Expanded(
                                  child: RichText(
                                    text: TextSpan(
                                      style: Theme.of(context).textTheme.labelSmall,
                                      children: <TextSpan>[
                                        TextSpan(
                                          text: 'This offer expires in ${item.expireCountDown == null ? '' : THelperFunctions.millisecondConversion(item.expireCountDown.toString()) ?? ''}',
                                          style: TextStyle(color: TColors.textPrimaryO80),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                      ],
                    ),
                  ],
                ),
              );
            }
          }),
        ],
      ),
      bottomNavigationBar: Theme(
        data: Theme.of(context).copyWith(),
        child: SizedBox(
          height: 150,
          child: BottomAppBar(
            padding: const EdgeInsets.all(0),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: TSizes.defaultSpace),
              color: darkMode ? TColors.black.withOpacity(0.8) : TColors.white,
              child: Obx(() {
                if (offerController.isFetchOfferByIdLoading.value) {
                  return const SizedBox();
                }

                final item = offerController.offerById.value;

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
                    const SizedBox(height: TSizes.spaceBtwButtons),
                    SizedBox(
                      width: double.infinity,
                      height: TSizes.buttonHeight,
                      child: OutlinedButton(
                        onPressed: () {
                          Get.bottomSheet(
                            backgroundColor: darkMode ? Color(0xFF121212) : Colors.white,
                            isScrollControlled: true,
                            NegotiationScreen(
                              id: item.id.toString(),
                              debitedCurrency: item.debitedCurrency.toString(),
                              creditedCurrency: item.creditedCurrency.toString(),
                            ),
                          );
                        },
                        child: const Text("I'm interested, but..."),
                      ),
                    ),
                  ],
                );
              }),
            ),
          ),
        ),
      ),
    );
  }
}

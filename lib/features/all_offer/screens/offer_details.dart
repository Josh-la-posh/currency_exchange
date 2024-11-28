import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pouch/common/widgets/buttons/elevated_button.dart';
import 'package:pouch/common/widgets/currencyWidget.dart';
import 'package:pouch/features/all_offer/controllers/offer_controller.dart';
import 'package:pouch/utils/helpers/helper_functions.dart';
import '../../../common/controller/exchange_rate_controller.dart';
import '../../../data/modules/interceptor.dart';
import '../../../utils/constants/colors.dart';
import '../../../utils/constants/sizes.dart';
import '../../../utils/helpers/controller/helper_function_controller.dart';
import '../controllers/tradingOfferController.dart';
import '../widgets/negotiation_screen.dart';
import 'accept_review_details.dart';

class OfferDetailsScreen extends StatelessWidget {
  final AppInterceptor appInterceptor = AppInterceptor();
  final ExchangeRateController controller = Get.put(ExchangeRateController());

  @override
  Widget build(BuildContext context) {
    final TradingOfferController tradingOfferController = Get.put(TradingOfferController());
    final HelperFunctionsController helperFunctionsController = Get.put(HelperFunctionsController());
    final darkMode = THelperFunctions.isDarkMode(context);

    return Scaffold(
      backgroundColor: darkMode ? TColors.black.withOpacity(0.8) : TColors.white,
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            // appInterceptor.cancelOngoingRequest(() {
            //   tradingOfferController.resetBoolForOutgoingRequests();
            // });
            Get.back();
          },
          icon: const Icon(Icons.arrow_back),
          style: IconButton.styleFrom(
            foregroundColor: Colors.grey,
            iconSize: TSizes.iconBackSize,
          ),
          hoverColor: Colors.transparent,
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 20.0),
            child: IconButton(
                onPressed: () {
                  Get.defaultDialog(
                    title: 'Today\'s Exchange Rate',
                    titleStyle: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
                    backgroundColor: TColors.primary,

                    content: Container(
                      width: MediaQuery.of(context).size.width * 0.9,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 3),
                            decoration: BoxDecoration(
                              color: Color(0xFFDADADA),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Row(
                              children: [
                                Expanded(
                                  child: TextField(
                                    onChanged: (val) {
                                      if (val.isNotEmpty && double.tryParse(val) != null) {
                                        controller.baseAmount.value = double.parse(val);
                                      } else {
                                        controller.baseAmount.value = 0.0;
                                      }
                                    },
                                    keyboardType: TextInputType.number,
                                    style: Theme.of(context).textTheme.labelMedium?.copyWith(
                                        fontWeight: FontWeight.w800,
                                        color: TColors.primary,
                                        fontSize: 16
                                    ),
                                    decoration: InputDecoration(fillColor: Colors.transparent),
                                  ),
                                ),
                                Expanded(
                                  child: Container(
                                    decoration: BoxDecoration(border: Border(left: BorderSide(color: Colors.white))),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        Obx(() => DropdownButton<String>(
                                          value: controller.baseCurrency.value,
                                          onChanged: (newCurrency) =>
                                              controller.updateBaseCurrency(newCurrency!),
                                          items: controller.currencies.map((currency) {
                                            return DropdownMenuItem(
                                              value: currency,
                                              child: Text(
                                                currency,
                                                style: Theme.of(context).textTheme.labelMedium?.copyWith(
                                                    fontWeight: FontWeight.w800,
                                                    color: TColors.primary
                                                ),
                                              ),
                                            );
                                          }).toList(),
                                        )),
                                      ],
                                    ),
                                  ),)
                              ],
                            ),
                          ),
                          const SizedBox(height: 25),
                          Container(
                            margin: const EdgeInsets.symmetric(horizontal: 20),
                            padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 25),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(30),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Obx(() => Text("1 ${controller.baseCurrency}",
                                    style: Theme.of(context).textTheme.labelMedium?.copyWith(
                                    fontWeight: FontWeight.w800,
                                    color: TColors.primary,
                                    fontSize: 14
                                ))),
                                Icon(Icons.swap_horiz, color: Colors.black),
                                Obx(() => Text("${controller.exchangeRate.value.toString()} ${controller.targetCurrency}",
                                    style: Theme.of(context).textTheme.labelMedium?.copyWith(
                                        fontWeight: FontWeight.w800,
                                        color: TColors.primary,
                                        fontSize: 14
                                    ))),
                                // Text("${controller.exchangeRate.value.toString} NGN",
                                //     style: TextStyle(fontWeight: FontWeight.bold)),
                              ],
                            ),
                          ),
                          const SizedBox(height: 25),
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 3),
                            decoration: BoxDecoration(
                              color: Color(0xFFDADADA),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Row(
                              children: [
                                Expanded(
                                  child: Obx(() => Text(
                                      controller.targetAmount.value.toString(),
                                      style: Theme.of(context).textTheme.labelMedium?.copyWith(
                                          fontWeight: FontWeight.w800,
                                          color: TColors.primary,
                                          fontSize: 16
                                      ))),
                                ),
                                Expanded(
                                  child: Container(
                                    decoration: BoxDecoration(border: Border(left: BorderSide(color: Colors.white))),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        Obx(() => DropdownButton<String>(
                                          value: controller.targetCurrency.value,
                                          onChanged: (newCurrency) =>
                                              controller.updateTargetCurrency(newCurrency!),
                                          items: controller.currencies.map((currency) {
                                            return DropdownMenuItem(
                                              value: currency,
                                              child: Text(
                                                currency,
                                                style: Theme.of(context).textTheme.labelMedium?.copyWith(
                                                    fontWeight: FontWeight.w800,
                                                    color: TColors.primary
                                                ),
                                              ),
                                            );
                                          }).toList(),
                                        )),
                                      ],
                                    ),
                                  ),)
                              ],
                            ),
                          ),
                          const SizedBox(height: 25),
                          Obx(() => ElevatedButton(
                            onPressed: () => controller.isConverting.isTrue ? null : controller.fetchConversionRate(),
                            child: Text(controller.isConverting.isTrue ? 'Converting' : 'Convert', style: TextStyle(fontWeight: TSizes.fontWeightLg),),
                            style: ButtonStyle(
                              backgroundColor: WidgetStatePropertyAll(Colors.white),
                              foregroundColor: WidgetStatePropertyAll(TColors.primary)
                            ),
                          ),)
                        ],
                      ),
                    )
                  );
                },
                icon: Icon(
                    Icons.currency_exchange_outlined,
                    size: 18
                )
            ),
          )
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CurrencyWidget(),
          SizedBox(height: 15),
          Obx(() {
            if (tradingOfferController.isFetchOfferByIdLoading.value) {
              return const Center(child: CircularProgressIndicator());
            } else {
              final item = tradingOfferController.offerById.value;
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
                                        text: 'Created ${helperFunctionsController.getFormattedDate(item.createdDate.toString()) ?? 'Unknown Date'} ${helperFunctionsController.getFormattedTime(item.createdDate.toString()) ?? ''}',
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
                if (tradingOfferController.isFetchOfferByIdLoading.value) {
                  return const SizedBox();
                }

                final item = tradingOfferController.offerById.value;

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




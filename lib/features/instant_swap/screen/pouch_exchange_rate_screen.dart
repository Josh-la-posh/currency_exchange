import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:pouch/common/widgets/buttons/elevated_button.dart';
import 'package:pouch/common/widgets/currencyWidget.dart';

import '../../../common/controller/exchange_rate_controller.dart';
import '../../../utils/constants/colors.dart';
import '../../../utils/constants/sizes.dart';
import '../../all_offer/decimal_formatter.dart';

class PouchExchangeRateScreen extends StatelessWidget {
  const PouchExchangeRateScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final ExchangeRateController controller = Get.put(ExchangeRateController());
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        child: Column(
          children: [
            CurrencyWidget(),
            SizedBox(height: 30),
            Container(
              width: MediaQuery.of(context).size.width * 0.9,
              padding: EdgeInsets.symmetric(horizontal: 18, vertical: 35),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  border: Border.all(
                      color: Colors.grey
                  )
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text("Pouch Today's Exchange Rate",
                    style: TextStyle(
                        color: TColors.primary,
                        fontSize: 16,
                        fontWeight: TSizes.fontWeightMd
                    ),
                  ),
                  const SizedBox(height: 20),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 3),
                    decoration: BoxDecoration(
                        color: Color(0xFFDADADA),
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                            color: Colors.grey
                        )
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
                            inputFormatters: [
                              DecimalTextInputFormatter(decimalRange: 2),
                              FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d{0,2}')),
                            ],
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
                    width: 350,
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
                                  onChanged: (newCurrency) {
                                    controller.updateTargetCurrency(newCurrency!);
                                    controller.fetchConversionRate();
                                  },
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
                ],
              ),
            ),
            const SizedBox(height: 40),
            Obx(() => Container(
              padding: EdgeInsets.symmetric(horizontal: 60),
              width: double.infinity,
              child: TElevatedButton(
                  onTap: () => controller.isConverting.isTrue ? null : controller.fetchConversionRate(),
                  buttonText: controller.isConverting.isTrue ? 'Swapping' : 'Swap Now!'),
            )
            )
          ],
        ),
      ),
    );
  }
}

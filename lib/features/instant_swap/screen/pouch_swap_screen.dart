import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:pouch/common/widgets/buttons/elevated_button.dart';
import 'package:pouch/features/instant_swap/screen/pouch_exchange_rate_screen.dart';
import 'package:pouch/features/instant_swap/screen/pouch_swap_success_screen.dart';
import 'package:pouch/utils/constants/colors.dart';

import '../../all_offer/decimal_formatter.dart';
import '../controller/instant_swap_controller.dart';

class PouchSwapScreen extends StatelessWidget {
  final SwapController controller = Get.put(SwapController());

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(title: Text('Swap with Pouch')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20),
            Row(
              children: [
                Icon(Icons.account_balance_wallet, color: TColors.primary, size: width > 450 ? 28 : 24),
                SizedBox(width: width > 450 ? 15 : 6),
                Text('Swap with Pouch',
                  style: TextStyle(
                    color: TColors.primary,
                    fontSize: 18,
                    fontWeight: FontWeight.w500
                  ),
                )
              ],
            ),
            const SizedBox(height: 40),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                GestureDetector(
                  onTap: () => Get.to(() => PouchExchangeRateScreen()),
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 15, vertical: width > 450 ? 12 : 8),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: TColors.primary
                      ),
                      borderRadius: BorderRadius.circular(8)
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Icon(Icons.account_balance_wallet, color: TColors.primary, size: width > 450 ? 24 : 18),
                        SizedBox(width: width > 450 ? 10 : 7),
                        Text('Check Pouch Rate',
                          style: TextStyle(
                              color: TColors.primary,
                              fontSize: width > 450 ? 18 : 16,
                              fontWeight: FontWeight.w500
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            _buildCurrencySelector(context, 'Has', controller.hasCurrency, controller.amount),
            const SizedBox(height: 40),
            _buildRateDisplay(context, controller.needCurrency),
            const SizedBox(height: 40),
            _buildEstimatedAmount(context),
            const SizedBox(height: 40),
            _buildReviewText(),
            const SizedBox(height: 40),
            _buildConfirmButton(),
          ],
        ),
      ),
    );
  }

  Widget _buildCurrencySelector(context, String label, RxString currency, RxDouble amount) {
    final width = MediaQuery.of(context).size.width;
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      decoration: BoxDecoration(color: TColors.secondaryBorder30, borderRadius: BorderRadius.circular(8)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  Text(label,
                      style: TextStyle(
                          fontSize: 12,
                          color: TColors.primary
                      )
                  ),
                  Row(
                    children: [
                      Icon(Icons.settings_input_svideo_sharp, size: 22, color: TColors.primary,),
                      SizedBox(width: 10),
                      DropdownButton<String>(
                        borderRadius: BorderRadius.zero,
                        value: currency.value,
                        items: ['USD', 'NGN', 'CAD', 'EUR', 'GBP'].map((e) =>
                            DropdownMenuItem(
                                value: e,
                                child: Text(e, style: TextStyle(
                                  color: TColors.primary,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w800
                                ),))).toList(),
                        onChanged: (val) => currency.value = val!,
                      ),
                    ],
                  ),
                ],
              ),
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8)
                ),
                alignment: Alignment.center,
                width: width > 450 ? 130 : 100,
                child: TextField(
                  keyboardType: TextInputType.number,
                  inputFormatters: [
                    DecimalTextInputFormatter(decimalRange: 2),
                    FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d{0,2}')),
                  ],
                  decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: '100.00',
                      hintStyle: TextStyle(
                        fontSize: 14,
                        color: TColors.primary,
                        fontWeight: FontWeight.w900
                    )
                  ),
                  style: TextStyle(
                      fontSize: width > 450 ? 16 : 14,
                      color: TColors.primary,
                      fontWeight: FontWeight.w900
                  ),
                  onChanged: (val) => amount.value = double.tryParse(val) ?? 0,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildRateDisplay(context, RxString currency) {
    final width = MediaQuery.of(context).size.width;
    return Obx(() => Container(
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(color: TColors.secondaryBorder30, borderRadius: BorderRadius.circular(8)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            children: [
              Text('Need',
                  style: TextStyle(
                      fontSize: 12,
                      color: TColors.primary
                  )
              ),
              Row(
                children: [
                  Icon(Icons.settings_input_svideo_sharp, size: 22, color: TColors.primary,),
                  SizedBox(width: 10),
                  DropdownButton<String>(
                    borderRadius: BorderRadius.zero,
                    value: currency.value,
                    items: ['USD', 'NGN', 'CAD', 'EUR', 'GBP'].map((e) =>
                        DropdownMenuItem(
                            value: e,
                            child: Text(e, style: TextStyle(
                                color: TColors.primary,
                                fontSize: 14,
                                fontWeight: FontWeight.w800
                            ),))).toList(),
                    onChanged: (val) => currency.value = val!,
                  ),
                ],
              ),
            ],
          ),
          Column(
            children: [
              Text('Pouch Rate', style: TextStyle(fontSize: width > 450 ? 16 : 14, fontWeight: FontWeight.bold, color: TColors.primary)),
              SizedBox(height: 10),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 25, vertical: 10),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8)
                  ),
                  alignment: Alignment.center,
                  child: Text(controller.formattedRate,
                      style: TextStyle(
                          fontSize: width > 450 ? 18 : 15,
                          fontWeight: FontWeight.bold,
                          color: TColors.primary
                      ))),
            ],
          ),
        ],
      ),
    ));
  }

  Widget _buildEstimatedAmount(context) {
    final width = MediaQuery.of(context).size.width;
    return Obx(() => Container(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 30),
      decoration: BoxDecoration(color: TColors.secondaryBorder30, borderRadius: BorderRadius.circular(8)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(Icons.settings_input_svideo_sharp, size: 22, color: TColors.primary,),
              SizedBox(width: 10,),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(controller.needCurrency.value, style: TextStyle(fontSize: width > 450 ? 18 : 16, fontWeight: FontWeight.bold, color: TColors.primary)),
                  Text('Estimated', style: TextStyle(fontSize: width > 450 ? 16 : 14, fontWeight: FontWeight.w400, color: TColors.primary)),
                ],
              ),
            ],
          ),
          Text(controller.estimatedAmount, style: TextStyle(fontSize: width > 450 ? 22 : 16, fontWeight: FontWeight.bold, color: TColors.primary)),
        ],
      ),
    ));
  }

  Widget _buildReviewText() {
    return Center(
      child: RichText(
        textAlign: TextAlign.center,
        text: TextSpan(
          style: TextStyle(
            color: Get.isDarkMode ? Colors.white : Colors.black,
            fontSize: 14,
              letterSpacing: 0.25,
              height: 2
          ),
          children: [
            TextSpan(
              text: 'You are about to swap ${controller.amount} ${controller.hasCurrency} at rate of '
            ),
            TextSpan(
              text: '${controller.needCurrency} ${controller.rate}',
              style: TextStyle(color: TColors.primary)
            ),
            TextSpan(
                text: ' and you will be credited '
            ),
            TextSpan(
                text: '${controller.estimatedAmount} ${controller.needCurrency}',
                style: TextStyle(color: TColors.danger)
            ),
          ]
        ),
      ),
    );
  }

  Widget _buildConfirmButton() {
    return TElevatedButton(
        onTap: () => Get.to(() => PouchSwapSuccessScreen()),
        buttonText: 'Confirm');
  }
}

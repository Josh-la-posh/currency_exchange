import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:pouch/common/widgets/form/custom_switch.dart';

import '../../../common/widgets/buttons/elevated_button.dart';
import '../../../utils/constants/colors.dart';
import '../../all_offer/decimal_formatter.dart';
import '../controller/instant_swap_controller.dart';

class AddNewAutoSwap extends StatelessWidget {
  final SwapController controller = Get.put(SwapController());

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: Text('Create Auto Swap'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(vertical: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Auto swap details',
                    style: TextStyle(
                        color: TColors.primary,
                        fontSize: width > 450 ? 18 : 15,
                        fontWeight: FontWeight.w500
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Switch(value: true, onChanged: (val) {}),
                      // CustomSwitch(value: true, onChanged: () {}),
                      Text('Turn on automatic swapping',
                          style: TextStyle(
                              fontSize: width > 450 ? 11 : 9,
                              color: TColors.primary
                          )
                      ),
                    ],
                  )
                ],
              ),
            ),
            const SizedBox(height: 20),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 13.0, vertical: 10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(22),
                color: TColors.secondaryBorder30,
                border: Border(top: BorderSide(color: Color(0xFFDADADA)))
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      IconButton(
                          onPressed: () => Get.back(),
                          icon: Icon(Icons.close)
                      )
                    ],
                  ),
                  const SizedBox(height: 10),
                  _buildCurrencySelector(context, 'Seller Has', controller.hasCurrency, controller.amount),
                  const SizedBox(height: 40),
                  _buildRateDisplay(context, controller.needCurrency),
                  const SizedBox(height: 20),
                  _buildEstimatedAmount(context),
                  const SizedBox(height: 40),
                  _buildReviewText(),
                  const SizedBox(height: 40),
                  _buildConfirmButton()
                ],
              ),
            )
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
                          fontSize: width > 450 ? 13 : 11,
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
              Text('Seller Need',
                  style: TextStyle(
                      fontSize: width > 450 ? 13 : 11,
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
              Text('Prefer Rate', style: TextStyle(fontSize: width > 450 ? 13 : 10, fontWeight: FontWeight.w400, color: TColors.primary)),
              SizedBox(height: 7),
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
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: TColors.textPrimaryO40),
          color: Get.isDarkMode ? Colors.white12 : Colors.white
      ),
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
                  text: 'If your auto swap is matched, you will be credited ${controller.amount} ${controller.hasCurrency} and debited  '
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
        onTap: () {},
        buttonText: 'Create');
  }
}

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pouch/utils/constants/colors.dart';

import '../controller/instant_swap_controller.dart';

class PouchSwapScreen extends StatelessWidget {
  final SwapController controller = Get.put(SwapController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Swap with Pouch')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildCurrencySelector('Has', controller.hasCurrency, controller.amount),
            const SizedBox(height: 16),
            _buildRateDisplay(),
            const SizedBox(height: 16),
            _buildEstimatedAmount(),
            const Spacer(),
            _buildConfirmButton(),
          ],
        ),
      ),
    );
  }

  Widget _buildCurrencySelector(String label, RxString currency, RxDouble amount) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      decoration: BoxDecoration(color: TColors.secondaryBorder30, borderRadius: BorderRadius.circular(8)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Column(
                children: [
                  Text(label, style: TextStyle(fontSize: 9)),
                  DropdownButton<String>(
                    value: currency.value,
                    items: ['USD', 'NGN' 'CAD', 'EUR', 'GBP'].map((e) => DropdownMenuItem(value: e, child: Text(e))).toList(),
                    onChanged: (val) => currency.value = val!,
                  ),
                ],
              ),
              const SizedBox(width: 40),
              Expanded(
                child: TextField(
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(border: OutlineInputBorder(), hintText: 'Amount'),
                  onChanged: (val) => amount.value = double.tryParse(val) ?? 0,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildRateDisplay() {
    return Obx(() => Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(color: TColors.secondaryBorder30, borderRadius: BorderRadius.circular(8)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            children: [
              Text('Need', style: TextStyle(fontSize: 9)),
              // DropdownButton<String>(
              //   value: currency.value,
              //   items: ['USD', 'NGN' 'CAD', 'EUR', 'GBP'].map((e) => DropdownMenuItem(value: e, child: Text(e))).toList(),
              //   onChanged: (val) => currency.value = val!,
              // ),
            ],
          ),
          Column(
            children: [
              Text('Pouch Rate', style: TextStyle(fontWeight: FontWeight.bold, color: TColors.primary)),
              Text(controller.formattedRate, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            ],
          ),
        ],
      ),
    ));
  }

  Widget _buildEstimatedAmount() {
    return Obx(() => Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(color: TColors.secondaryBorder30, borderRadius: BorderRadius.circular(8)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            children: [
              Text('Estimated', style: TextStyle(fontWeight: FontWeight.bold, color: TColors.primary)),
            ],
          ),
          Text(controller.estimatedAmount, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: TColors.primary)),
        ],
      ),
    ));
  }

  Widget _buildConfirmButton() {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(minimumSize: Size(double.infinity, 50)),
      onPressed: () {},
      child: Text('Confirm'),
    );
  }
}

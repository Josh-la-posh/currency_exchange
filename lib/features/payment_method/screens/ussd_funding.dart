import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:pouch/common/widgets/buttons/elevated_button.dart';
import 'package:pouch/utils/constants/sizes.dart';
import 'package:pouch/utils/helpers/helper_functions.dart';
import 'package:pouch/utils/validators/validation.dart';
import '../../../utils/constants/colors.dart';
import '../../../utils/constants/enums.dart';
import '../../all_offer/decimal_formatter.dart';
import '../controller/payment_controller.dart';

class UssdFundingScreen extends StatelessWidget {
  UssdFundingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();
    final PaymentController paymentController = Get.put(PaymentController());
    final darkMode = THelperFunctions.isDarkMode(context);

    return Scaffold(
      appBar: AppBar(
        leading: const BackButton(),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: TSizes.defaultSpace * 2, vertical: TSizes.defaultSpace),
          child: Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                RichText(
                  text: TextSpan(
                    style: TextStyle(
                      color: darkMode ? Colors.white : Colors.black,
                      fontWeight: FontWeight.w600,
                      fontSize: 12,
                      fontFamily: 'Roboto',
                    ),
                    children: const <TextSpan>[
                      TextSpan(text: 'SELECT YOUR USSD CODE PROVIDER'),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                Obx(() => Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: TColors.secondaryBorder30),
                    borderRadius: const BorderRadius.all(Radius.circular(TSizes.borderRadiusSm)),
                  ),
                  child: DropdownButtonFormField<Bank>(
                    validator: TValidator.bankValidator,
                    decoration: InputDecoration(
                      fillColor: darkMode ? TColors.timeLineBorder : TColors.textFieldBackground,
                    ),
                    autofocus: false,
                    isExpanded: true,
                    value: paymentController.selectedNigBanks.value,
                    icon: RotatedBox(
                      quarterTurns: 3,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 14.8),
                        child: Icon(
                          Icons.arrow_back_ios_rounded,
                          size: 15,
                          color: darkMode ? TColors.white : TColors.textPrimary.withOpacity(0.8),
                        ),
                      ),
                    ),
                    onChanged: (val) {
                      paymentController.setSelectedNigBank(val!);
                      formKey.currentState?.validate();
                    },
                    items: [
                      for (final item in paymentController.nigBanks)
                        DropdownMenuItem<Bank>(
                          value: item,
                          child: SizedBox(
                            child: Row(
                              children: [
                                Text(
                                  getBankName(item),
                                  style: Theme.of(context).textTheme.bodyMedium,
                                ),
                              ],
                            ),
                          ),
                        ),
                    ],
                  ),
                )),
                const SizedBox(height: TSizes.defaultSpace * 2),
                Container(
                  width: double.infinity,
                  alignment: Alignment.centerLeft,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      RichText(
                        text: TextSpan(
                          style: TextStyle(
                            color: darkMode ? Colors.white : Colors.black,
                            fontWeight: FontWeight.w600,
                            fontSize: 12,
                            fontFamily: 'Roboto',
                          ),
                          children: const <TextSpan>[
                            TextSpan(text: 'Amount'),
                          ],
                        ),
                      ),
                      const SizedBox(height: 10),
                      TextFormField(
                        validator: TValidator.numValidator,
                        style: Theme.of(context).textTheme.bodyMedium,
                        keyboardType: TextInputType.number,
                        inputFormatters: [
                          DecimalTextInputFormatter(decimalRange: 2),
                          FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d{0,2}')),
                        ],
                        onChanged: (val) {
                          paymentController.setAmount(val);
                          formKey.currentState?.validate();
                        },
                        decoration: const InputDecoration(
                          contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                          border: OutlineInputBorder(),
                          hintText: 'Amount',
                        ),
                      )
                    ],
                  ),
                ),
                const SizedBox(height: TSizes.defaultSpace * 4),
                Center(
                  child: SizedBox(
                    width: 200,
                    child: Obx(() => TElevatedButton(
                      onTap: paymentController.isFundWalletViaNairaUssd.value ? null : () {
                        if (formKey.currentState!.validate()) {
                          formKey.currentState!.save();
                          paymentController.fundWalletViaNairaUssd(
                              amount: paymentController.amount.value,
                              bank: getBankName(paymentController.selectedNigBanks.value)
                          );
                        }
                      },
                      buttonText: paymentController.isFundWalletViaNairaUssd.value ? 'Loading' : 'Continue',
                    )),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:pouch/common/widgets/buttons/elevated_button.dart';
import 'package:pouch/utils/constants/sizes.dart';
import 'package:pouch/utils/helpers/helper_functions.dart';
import 'package:pouch/utils/validators/validation.dart';
import 'package:pouch/data/modules/app_navigator.dart';
import 'package:pouch/features/wallet/apis/api.dart';
import '../../../utils/constants/colors.dart';
import '../../../utils/constants/enums.dart';
import '../../../utils/layouts/navigation_menu.dart';
import '../../all_offer/decimal_formatter.dart';
import '../../wallet/controller/wallet_controller.dart';

class ForeignFundingScreen extends StatelessWidget {
  ForeignFundingScreen({super.key});
  final controller = Get.find<WalletController>();
  final navigationController = Get.find<NavigationController>();
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
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
                      TextSpan(text: 'SELECT YOUR PREFERRED CURRENCY'),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                Obx(() => Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: TColors.secondaryBorder30),
                    borderRadius: const BorderRadius.all(Radius.circular(TSizes.borderRadiusSm)),
                  ),
                  child: DropdownButtonFormField<ForeignBank>(
                    validator: TValidator.foreignBankValidator,
                    decoration: InputDecoration(
                      fillColor: darkMode ? TColors.timeLineBorder : TColors.textFieldBackground,
                    ),
                    autofocus: false,
                    isExpanded: true,
                    value: controller.selectedForeignCurrency.value,
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
                      controller.setSelectedForeignCurrency(val!);
                      formKey.currentState?.validate();
                    },
                    items: [
                      for (final item in controller.foreignCurrencies)
                        DropdownMenuItem<ForeignBank>(
                          value: item,
                          child: SizedBox(
                            child: Row(
                              children: [
                                Text(
                                  getForeignName(item),
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
                          controller.setAmount(val);
                          formKey.currentState?.validate();
                        },
                        decoration: const InputDecoration(
                          contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                          border: OutlineInputBorder(),
                          hintText: 'Amount',
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: TSizes.defaultSpace * 4),
                Center(
                  child: SizedBox(
                    width: 200,
                    child: Obx(() => TElevatedButton(
                      onTap: controller.isLoading.value ? null : () {
                        if (formKey.currentState!.validate()) {
                          formKey.currentState!.save();
                          controller.fundingFcy(
                              currency: getForeignName(controller.selectedForeignCurrency.value),
                              amount: controller.amount.value,
                              onSuccess: () {
                                navigationController.selectedIndex.value = 3;
                                Get.offAll(() => NavigationMenu());
                              }

                          );
                          // WalletServices.instance.fundFcy(
                          //   walletProvider: walletProvider,
                          //   transactionProvider: Get.find<TransactionProvider>(),
                          //   amount: amount.value,
                          //   currency: getForeignName(selectedCurrency.value!),
                          //   onSuccess: () {
                          //     AppNavigator.instance.removeAllNavigateToNavHandler(DASHBOARD_SCREEN_ROUTE);
                          //   }
                          // );
                        }
                      },
                      buttonText: controller.isLoading.value ? 'Loading ...' : 'Continue',
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

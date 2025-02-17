import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pouch/common/widgets/buttons/elevated_button.dart';
import 'package:pouch/utils/constants/colors.dart';
import 'package:pouch/utils/constants/enums.dart';
import 'package:pouch/utils/shared/error_dialog_response.dart';
import '../../../utils/constants/sizes.dart';
import '../../../utils/helpers/helper_functions.dart';
import '../../../utils/validators/validation.dart';
import '../controller/subscription_controller.dart';

class SubscriptionForm extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<SubscriptionController>();
    final _formKey = GlobalKey<FormState>();
    final darkMode = THelperFunctions.isDarkMode(context);

    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'They have',
            style: Theme.of(context).textTheme.labelSmall,
          ),
          Obx(() => Container(
            decoration: BoxDecoration(
              color: darkMode ? TColors.textPrimary : TColors.textFieldBackground,
              border: Border.all(color: darkMode ? Colors.black : TColors.secondaryBorder30),
              borderRadius: BorderRadius.circular(TSizes.borderRadiusSm),
            ),
            child: DropdownButtonFormField<Currency>(
              dropdownColor: darkMode ? TColors.textPrimary : Colors.white,
              isExpanded: true,
              value: controller.debitedCurrency.value,
              icon: RotatedBox(
                quarterTurns: 3,
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 14.8),
                  child: Icon(
                    Icons.arrow_back_ios_rounded,
                    size: 20,
                    color: TColors.textPrimary.withOpacity(0.8),
                  ),
                ),
              ),
              onChanged: (val) {
                controller.setDebitedCurrency(val as Currency);
              },
              items: [
                for (final item in controller.currencies)
                  DropdownMenuItem<Currency>(
                    value: item,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 0),
                      child: Text(
                        getCurrencyName(item),
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                    ),
                  ),
              ],
            ),
          )),
          const SizedBox(height: TSizes.spaceBtwInputFields),
          Text(
            'They need',
            style: Theme.of(context).textTheme.labelSmall,
          ),
          Obx(() => Container(
            decoration: BoxDecoration(
              color: darkMode ? TColors.textPrimary : TColors.textFieldBackground,
              border: Border.all(color: darkMode ? Colors.black : TColors.secondaryBorder30),
              borderRadius: BorderRadius.circular(TSizes.borderRadiusSm),
            ),
            child: DropdownButtonFormField<Currency>(
              dropdownColor: darkMode ? TColors.textPrimary : Colors.white,
              isExpanded: true,
              value: controller.creditedCurrency.value,
              icon: RotatedBox(
                quarterTurns: 3,
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 14.8),
                  child: Icon(
                    Icons.arrow_back_ios_rounded,
                    size: 20,
                    color: TColors.textPrimary.withOpacity(0.8),
                  ),
                ),
              ),
              onChanged: (val) {
                controller.setCreditedCurrency(val!);
              },
              items: [
                for (final item in controller.currencies)
                  DropdownMenuItem<Currency>(
                    value: item,
                    child: Row(
                      children: [
                        Text(
                          getCurrencyName(item),
                          style: Theme.of(context).textTheme.bodyLarge,
                        ),
                      ],
                    ),
                  ),
              ],
            ),
          )),
          const SizedBox(height: TSizes.spaceBtwInputFields),
          Text(
            'Rate Range per ${getCurrencyName(controller.debitedCurrency.value ?? Currency.USD)}',
            style: Theme.of(context).textTheme.labelSmall,
          ),
          const SizedBox(height: TSizes.spaceBtwInputFields),
          Row(
            children: [
              Expanded(
                child: Obx(() => Container(
                  decoration: BoxDecoration(
                    color: darkMode ? TColors.textPrimary : TColors.textFieldBackground,
                    borderRadius: BorderRadius.circular(TSizes.buttonRadius),
                    border: Border.all(
                      width: 1,
                      color: darkMode ? Colors.black : TColors.secondaryBorder30,
                    ),
                  ),
                  child: TextFormField(
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    validator: TValidator.emptyFieldValidator,
                    onChanged: (val) {
                      controller.setMinRate(val);
                      _formKey.currentState?.validate();
                    },
                    onSaved: (val) => controller.setMinRate(val!),
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      labelText: 'Minimum rate ${controller.debitedCurrency.value == Currency.NGN ? '' : getCurrencyName(controller.debitedCurrency.value ?? Currency.USD)}',
                      labelStyle: TextStyle(
                        fontSize: TSizes.fontSize11,
                        color: darkMode ? Colors.white : TColors.textPrimary.withOpacity(0.7),
                      ),
                      contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 8),
                      border: OutlineInputBorder(
                        borderSide: BorderSide(width: 1, color: Colors.transparent),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(width: 1, color: Colors.transparent),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(width: 1, color: Colors.transparent),
                      ),
                    ),
                  ),
                )),
              ),
              const SizedBox(width: TSizes.xl),
              Expanded(
                child: Obx(() => Container(
                  decoration: BoxDecoration(
                    color: darkMode ? TColors.textPrimary : TColors.textFieldBackground,
                    borderRadius: BorderRadius.circular(TSizes.buttonRadius),
                    border: Border.all(
                      width: 1,
                      color: darkMode ? Colors.black : TColors.secondaryBorder30,
                    ),
                  ),
                  child: TextFormField(
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    validator: TValidator.emptyFieldValidator,
                    onChanged: (val) {
                      controller.setMaxRate(val);
                      _formKey.currentState?.validate();
                    },
                    onSaved: (val) => controller.setMaxRate(val!),
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      labelText: 'Maximum rate ${controller.debitedCurrency.value == Currency.NGN ? '' : getCurrencyName(controller.debitedCurrency.value ?? Currency.USD)}',
                      labelStyle: TextStyle(
                        fontSize: TSizes.fontSize11,
                        color: darkMode ? Colors.white : TColors.textPrimary.withOpacity(0.7),
                      ),
                      contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 8),
                      border: OutlineInputBorder(
                        borderSide: BorderSide(width: 1, color: Colors.transparent),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(width: 1, color: Colors.transparent),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(width: 1, color: Colors.transparent),
                      ),
                    ),
                  ),
                )),
              ),
            ],
          ),
          const SizedBox(height: TSizes.spaceBtwSections * 3),
          Obx(() => TElevatedButton(
            onTap: controller.isCreatingSubscription.value ? null : () {
              if (double.parse(controller.minRate.value) >= double.parse(controller.maxRate.value)) {
                showErrorAlertHelper(errorMessage: 'Maximum rate must be greater than Minimum rate');
                return;
              }
              if (_formKey.currentState!.validate()) {
                _formKey.currentState!.save();
                controller.createSubscription(
                    debitedCurrency: getCurrencyName(controller.debitedCurrency.value),
                    creditedCurrency: getCurrencyName(controller.creditedCurrency.value),
                    minRate: double.parse(controller.minRate.value),
                    maxRate: double.parse(controller.maxRate.value),
                    onSuccess: (){
                      Get.back();
                      controller.clearForm();
                    }
                );
              }
            },
            buttonText: controller.isCreatingSubscription.value ? 'Subscribing ...' : 'Subscribe',
          )),
        ],
      ),
    );
  }
}

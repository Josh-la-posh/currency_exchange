import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pouch/features/all_offer/controllers/create_offer_controller.dart';
import 'package:pouch/utils/constants/enums.dart';
import 'package:pouch/utils/helpers/controller/helper_function_controller.dart';

import '../../../common/widgets/buttons/elevated_button.dart';
import '../../../utils/constants/colors.dart';
import '../../../utils/constants/sizes.dart';
import '../../../utils/helpers/helper_functions.dart';
import '../../../utils/validators/validation.dart';
import '../icons/svg.dart';

class CreateOfferForm extends StatelessWidget {
  final createOfferController = Get.find<CreateOfferController>();
  final helperFunctionsController = Get.find<HelperFunctionsController>();

  @override
  Widget build(BuildContext context) {
    final darkMode = THelperFunctions.isDarkMode(context);
    return Obx(() => Form(
        key: createOfferController.formKey,
        child: Column(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('I have', style: Theme.of(context).textTheme.labelMedium,),
                SizedBox(
                  child: TextFormField(
                    controller: createOfferController.amountController,
                    style: Theme.of(context).textTheme.labelMedium,
                    validator: TValidator.numValidator,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      suffixIcon: DropdownButton<Currency>(
                        dropdownColor: darkMode ? Colors.black : TColors.white,
                        borderRadius: BorderRadius.circular(10),
                        focusColor: Colors.white,
                        autofocus: false,
                        isExpanded: false,
                        value: createOfferController.debitedCurrency.value,
                        underline: const SizedBox(),
                        icon: RotatedBox(
                          quarterTurns: 3,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 14.8),
                            child: Icon(
                              Icons.arrow_back_ios_rounded,
                              size: 12,
                              color: darkMode ? TColors.white : TColors.textPrimaryO80,
                            ),
                          ),
                        ),
                        onChanged: (Currency? val) {
                          if (val != null) {
                            createOfferController.updateDebitedCurrency(val);
                          }
                        },
                        items: Currency.values.map((Currency currency) {
                          return DropdownMenuItem<Currency>(
                            value: currency,
                            child: SizedBox(
                              child: Padding(
                                padding: const EdgeInsets.only(left: 0),
                                child: Text(
                                  getCurrencyName(currency),
                                  style: Theme.of(context).textTheme.labelMedium,
                                ),
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: TSizes.spaceBtwInputFields,),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('I need', style: Theme.of(context).textTheme.labelMedium,),
                TextFormField(
                  decoration: InputDecoration(
                    suffixIcon: DropdownButton<Currency>(
                      dropdownColor: darkMode ? Colors.black : TColors.white,
                      borderRadius: BorderRadius.circular(10),
                      focusColor: Colors.white,
                      autofocus: false,
                      isExpanded: true,
                      value: createOfferController.creditedCurrency.value,
                      underline: const SizedBox(),
                      icon: RotatedBox(
                        quarterTurns: 3,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 14.8),
                          child: Icon(
                            Icons.arrow_back_ios_rounded,
                            size: 12,
                            color: darkMode ? TColors.white : TColors.textPrimaryO80,
                          ),
                        ),
                      ),
                      onChanged: (val) {
                        if (val != null) {
                          createOfferController.updateCreditedCurrency(val);
                        }
                      },
                      items: Currency.values.map((Currency currency) {
                        return DropdownMenuItem<Currency>(
                          value: currency,
                          child: SizedBox(
                            child: Padding(
                              padding: const EdgeInsets.only(left: 8),
                              child: Text(
                                getCurrencyName(currency),
                                style: Theme.of(context).textTheme.labelMedium,
                              ),
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: TSizes.spaceBtwInputFields,),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Preferred rate (per) ${getCurrencyName(createOfferController.debitedCurrency.value)}', style: Theme.of(context).textTheme.labelMedium,),
                TextFormField(
                  controller: createOfferController.rateController,
                  style: Theme.of(context).textTheme.labelMedium,
                  validator: TValidator.numValidator,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    suffixIcon: Padding(
                      padding: const EdgeInsets.only(right: 14.8),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          if (createOfferController.amountController.text != '')
                            AppoxIcon(),
                          const SizedBox(width: TSizes.xl,),
                          if (createOfferController.rateController.text != '')
                            Text('${helperFunctionsController.multipliedString.value} ${getCurrencyName(createOfferController.creditedCurrency.value)}', style: Theme.of(context).textTheme.bodyMedium,),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: TSizes.spaceBtwInputFields,),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Expires in', style: Theme.of(context).textTheme.labelMedium,),
                TextFormField(
                  style: Theme.of(context).textTheme.labelMedium,
                  decoration: InputDecoration(
                    suffixIcon: DropdownButton(
                      dropdownColor: darkMode ? Colors.black : TColors.white,
                      borderRadius: BorderRadius.circular(10),
                      focusColor: Colors.white,
                      autofocus: false,
                      isExpanded: true,
                      value: createOfferController.expiryHour.value,
                      underline: const SizedBox(),
                      icon: Padding(
                        padding: const EdgeInsets.only(right: 14.8),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              Icons.access_time_filled_outlined,
                              size: 13,
                              color: darkMode ? TColors.white : TColors.grey,
                            ),
                            const SizedBox(width: TSizes.sm),
                            Text('HOUR', style: Theme.of(context).textTheme.labelMedium,),
                            const SizedBox(width: TSizes.sm),
                            Icon(
                              Icons.keyboard_arrow_down_rounded,
                              // size: 17,
                              color: darkMode ? TColors.white : TColors.textPrimaryO80,
                            ),
                          ],
                        ),
                      ),
                      onChanged: (value) {
                          createOfferController.updateExpiryHour(value.toString());
                      },
                      items: [
                        for (final hour in createOfferController.expiryHours)
                          DropdownMenuItem(
                            value: hour,
                            child: SizedBox(
                              child: Padding(
                                padding: const EdgeInsets.only(left: 8),
                                child: Text(
                                  hour,
                                  style: Theme.of(context).textTheme.bodyLarge,
                                ),
                              ),
                            ),
                          ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: TSizes.spaceBtwInputFields,),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('You will be debited from', style: Theme.of(context).textTheme.labelMedium,),
                Container(
                  padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                  width: double.infinity,
                  decoration: BoxDecoration(
                      color: darkMode ? TColors.secondaryBorder30 : TColors.textFieldBackground,
                      borderRadius: BorderRadius.circular(6),
                      border: Border.all(
                          color: TColors.secondaryBorder30,
                          width: 1
                      )
                  ),
                  child: Text(
                    '${getCurrencyName(createOfferController.debitedCurrency.value)} wallet',
                    style: Theme.of(context).textTheme.labelMedium,
                  ),
                ),
              ],
            ),
            const SizedBox(height: TSizes.spaceBtwInputFields,),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('You will be credited to', style: Theme.of(context).textTheme.labelMedium,),
                Container(
                  padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                  width: double.infinity,
                  decoration: BoxDecoration(
                      color: darkMode ? TColors.secondaryBorder30 : TColors.textFieldBackground,
                      borderRadius: BorderRadius.circular(6),
                      border: Border.all(
                          color: TColors.secondaryBorder30,
                          width: 1
                      )
                  ),
                  child: Text(
                    '${getCurrencyName(createOfferController.creditedCurrency.value)} wallet',
                    style: Theme.of(context).textTheme.labelMedium,
                  ),
                )
              ],
            ),
            const SizedBox(height: TSizes.spaceBtwSections,),
            TElevatedButton(
                onTap: createOfferController.submitForm,
                buttonText: 'Continue'),
            const SizedBox(height: TSizes.spaceBtwSections,),
          ],
        )
    ));
  }
}

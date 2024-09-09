import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pouch/common/widgets/buttons/elevated_button.dart';
import 'package:pouch/features/subscription/apis/api.dart';
import 'package:pouch/utils/constants/colors.dart';
import 'package:pouch/utils/constants/enums.dart';
import 'package:pouch/utils/constants/image_strings.dart';
import '../../../data/provider/subscription_provider.dart';
import '../../../utils/constants/sizes.dart';
import '../../../utils/helpers/helper_functions.dart';
import '../../../utils/validators/validation.dart';

class SubscriptionForm extends StatefulWidget {
  const SubscriptionForm({super.key});

  @override
  State<SubscriptionForm> createState() => _SubscriptionFormState();
}

class _SubscriptionFormState extends State<SubscriptionForm> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<SubscriptionProvider>(context);
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
          Container(
            decoration: BoxDecoration(
              color: darkMode ? TColors.textPrimary : TColors.textFieldBackground,
              border: Border.all(color: darkMode ? Colors.black : TColors.secondaryBorder30,),
              borderRadius: BorderRadius.circular(TSizes.borderRadiusSm),
            ),
            child: DropdownButtonFormField<Currency>(
              dropdownColor: darkMode ? TColors.textPrimary : Colors.white,
              isExpanded: true,
              value: provider.createSubscription?.debitedCurrency,
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
                provider.setDebitedCurrency(val as Currency);
                _formKey.currentState?.validate();
              },
              items: [
                for (final item in provider.currencies)
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
          ),
          const SizedBox(height: TSizes.spaceBtwInputFields),
          Text(
            'They need',
            style: Theme.of(context).textTheme.labelSmall,
          ),
          Container(
            decoration: BoxDecoration(
              color: darkMode ? TColors.textPrimary : TColors.textFieldBackground,
              border: Border.all(color: darkMode ? Colors.black : TColors.secondaryBorder30,),
              borderRadius: BorderRadius.circular(TSizes.borderRadiusSm),
            ),
            child: DropdownButtonFormField<Currency>(
              dropdownColor: darkMode ? TColors.textPrimary : Colors.white,
              isExpanded: true,
              value: provider.createSubscription?.creditedCurrency,
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
                provider.setCreditedCurrency(val!);
                _formKey.currentState?.validate();
              },
              items: [
                for (final item in provider.currencies)
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
          ),
          const SizedBox(height: TSizes.spaceBtwInputFields),
          Text(
            'Rate Range per ${getCurrencyName(provider.createSubscription?.debitedCurrency ?? Currency.USD)}',
            style: Theme.of(context).textTheme.labelSmall,
          ),
          const SizedBox(height: TSizes.spaceBtwInputFields),
          Row(
            children: [
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    color: darkMode ? TColors.textPrimary : TColors.textFieldBackground,
                    borderRadius: BorderRadius.circular(TSizes.buttonRadius),
                    border: Border.all(
                      width: 1,
                      color: darkMode ? Colors.black : TColors.secondaryBorder30,
                    ),
                  ),
                  child: TextFormField(
                    validator: TValidator.numValidator,
                    onChanged: (val) {
                      provider.setMinRate(val);
                      _formKey.currentState?.validate();
                    },
                    onSaved: (val) => provider.setMinRate(val!),
                    keyboardType: TextInputType.phone,
                    decoration: InputDecoration(
                      labelText: 'Minimum rate ${provider.createSubscription?.debitedCurrency == Currency.NGN ? '' : getCurrencyName(provider.createSubscription?.debitedCurrency ?? Currency.USD)}',
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
                ),
              ),
              const SizedBox(width: TSizes.xl),
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    color: darkMode ? TColors.textPrimary : TColors.textFieldBackground,
                    borderRadius: BorderRadius.circular(TSizes.buttonRadius),
                    border: Border.all(
                      width: 1,
                      color: darkMode ? Colors.black : TColors.secondaryBorder30,
                    ),
                  ),
                  child: TextFormField(
                    validator: TValidator.numValidator,
                    onChanged: (val) {
                      provider.setMaxRate(val);
                      _formKey.currentState?.validate();
                    },
                    onSaved: (val) => provider.setMaxRate(val!),
                    keyboardType: TextInputType.phone,
                    decoration: InputDecoration(
                      labelText: 'Maximum rate ${provider.createSubscription?.debitedCurrency == Currency.NGN ? '' : getCurrencyName(provider.createSubscription?.debitedCurrency ?? Currency.USD)}',
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
                ),
              ),
            ],
          ),
          const SizedBox(height: TSizes.spaceBtwSections * 3),
          TElevatedButton(
            onTap: () {
              if (_formKey.currentState!.validate()) {
                _formKey.currentState!.save();
                SubscriptionService.instance.createSubscription(
                  subscriptionProvider: provider,
                  debitedCurrency: getCurrencyName(provider.createSubscription?.debitedCurrency ?? Currency.USD),
                  creditedCurrency: getCurrencyName(provider.createSubscription?.creditedCurrency ?? Currency.USD),
                  minRate: provider.createSubscription!.minRate,
                  maxRate: provider.createSubscription!.maxRate,
                );
              }
            },
            buttonText: 'Subscribe',
          ),
        ],
      ),
    );
  }
}

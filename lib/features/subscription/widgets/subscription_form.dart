import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:swappr/common/widgets/buttons/elevated_button.dart';
import 'package:swappr/features/subscription/apis/api.dart';
import 'package:swappr/utils/constants/colors.dart';
import 'package:swappr/utils/constants/enums.dart';
import 'package:swappr/utils/constants/image_strings.dart';

import '../../../data/provider/subscription_provider.dart';
import '../../../utils/constants/sizes.dart';
import '../../../utils/validators/validation.dart';

class SubscriptionForm extends StatefulWidget {
  const SubscriptionForm({super.key});

  @override
  State<SubscriptionForm> createState() => _SubscriptionFormState();
}

class _SubscriptionFormState extends State<SubscriptionForm> {
  final _formkey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<SubscriptionProvider>(context);
    return Form(
      key: _formkey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('They have', style: Theme.of(context).textTheme.labelSmall,),
            Container(
              decoration: BoxDecoration(
                  color: TColors.textFieldBackground,
                  border: Border.all(
                      color: TColors.secondaryBorder30),
                  borderRadius: const BorderRadius.all(Radius.circular(TSizes.borderRadiusSm))
              ),
              child: DropdownButtonFormField<Currency>(
                validator: TValidator.currencyValidator,
                dropdownColor: Colors.white,
                focusColor: Colors.white,
                autofocus: false,
                isExpanded: true,
                value: provider.createSubscription?.debitedCurrency,
                // underline: const SizedBox(),
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
                onChanged: (val) => provider.setDebitedCurrency(val as Currency),
                items: [
                  for (final item in provider.currencies)
                    DropdownMenuItem<Currency>(
                      value: item,
                      child: SizedBox(
                        child: Padding(
                          padding: const EdgeInsets.only(left: 0),
                          child: Row(
                            children: [
                              // Container(
                              //   width: 40,
                              //     height: 40,
                              //     child: Image(image: AssetImage(
                              //         item == 'NGN'
                              //             ? TImages.ngnIcon
                              //             : TImages.gbpIcon
                              //     ))
                              // ),
                              Text(
                                getCurrencyName(item),
                                style: Theme.of(context).textTheme.bodyLarge,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            ),
            const SizedBox(height: TSizes.spaceBtwInputFields,),
            Text('They need', style: Theme.of(context).textTheme.labelSmall,),
            Container(
              decoration: BoxDecoration(
                  color: TColors.textFieldBackground,
                  border: Border.all(
                      color: TColors.secondaryBorder30),
                  borderRadius: const BorderRadius.all(Radius.circular(TSizes.borderRadiusSm))
              ),
              child: DropdownButtonFormField<Currency>(
                validator: TValidator.currencyValidator,
                dropdownColor: Colors.white,
                focusColor: Colors.white,
                autofocus: false,
                isExpanded: true,
                value: provider.createSubscription?.creditedCurrency,
                // underline: const SizedBox(),
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
                onChanged: (val) => provider.setCreditedCurrency(val!),
                items: [
                  for (final item in provider.currencies)
                    DropdownMenuItem<Currency>(
                      value: item,
                      child: SizedBox(
                        child: Row(
                          children: [
                            // SizedBox(
                            //     width: 40,
                            //     height: 40,
                            //     child: Image(image: AssetImage(
                            //         item == 'NGN'
                            //             ? TImages.ngnIcon
                            //             : TImages.gbpIcon
                            //     ))
                            // ),
                            Text(
                              getCurrencyName(item),
                              style: Theme.of(context).textTheme.bodyLarge
                            ),
                          ],
                        ),
                      ),
                    ),
                ],
              ),
            ),
            const SizedBox(height: TSizes.spaceBtwInputFields,),
            Text('Rate Range per GBP', style: Theme.of(context).textTheme.labelSmall,),
            const SizedBox(height: TSizes.spaceBtwInputFields,),
            Row(
              children: [
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      color: TColors.textFieldBackground,
                      borderRadius: BorderRadius.circular(TSizes.buttonRadius),
                      border: Border.all(
                        width: 1,
                        color: TColors.secondaryBorder30
                      )
                    ),
                    child: TextFormField(
                      validator: TValidator.numValidator,
                      onChanged: (val) => provider.setMinRate(val),
                      onSaved: (val) {
                        provider.setMinRate(val!);
                      },
                      decoration: InputDecoration(
                        label: Text('Minimum rate ${provider.createSubscription!.debitedCurrency == Currency.NGN ? '' : getCurrencyName(provider.createSubscription!.debitedCurrency)}'),
                        labelStyle: TextStyle(
                          fontSize: TSizes.fontSize11,
                          color: TColors.textPrimary.withOpacity(0.7),
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
                const SizedBox(width: TSizes.xl,),
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                        color: TColors.textFieldBackground,
                        borderRadius: BorderRadius.circular(TSizes.buttonRadius),
                        border: Border.all(
                            width: 1,
                            color: TColors.secondaryBorder30
                        )
                    ),
                    child: TextFormField(
                      validator: TValidator.numValidator,
                      onChanged: (val) => provider.setMaxRate(val),
                      onSaved: (val) {
                        provider.setMaxRate(val!);
                      },
                      decoration: InputDecoration(
                        label: Text('Maximum rate ${provider.createSubscription!.debitedCurrency == Currency.NGN ? '' : getCurrencyName(provider.createSubscription!.debitedCurrency)}'),
                        labelStyle: TextStyle(
                          fontSize: TSizes.fontSize11,
                          color: TColors.textPrimary.withOpacity(0.7),
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
            const SizedBox(height: TSizes.spaceBtwSections * 3,),
            TElevatedButton(
                onTap: (){
                  if (_formkey.currentState!.validate()) {
                    _formkey.currentState!.save();
                      SubscriptionService.instance.createSubscription(
                        subscriptionProvider: provider,
                        debitedCurrency: getCurrencyName(provider.createSubscription!.debitedCurrency),
                        creditedCurrency: getCurrencyName(provider.createSubscription!.creditedCurrency),
                        minRate: provider.createSubscription!.minRate,
                        maxRate: provider.createSubscription!.maxRate,
                      );
                  }
                },
                buttonText: 'Subscribe'
            ),
          ],
    ));
  }
}

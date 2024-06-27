import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:provider/provider.dart';
import 'package:swappr/data/provider/offer_provider.dart';
import 'package:swappr/utils/constants/enums.dart';

import '../../../common/widgets/buttons/elevated_button.dart';
import '../../../utils/constants/colors.dart';
import '../../../utils/constants/sizes.dart';
import '../../../utils/helpers/helper_functions.dart';
import '../../../utils/validators/validation.dart';
import '../screens/create_review_details.dart';
import '../icons/svg.dart';

class CreateOfferForm extends StatefulWidget {
  const CreateOfferForm({super.key});

  @override
  State<CreateOfferForm> createState() => _CreateOfferFormState();
}

class _CreateOfferFormState extends State<CreateOfferForm> {
  final formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    final darkMode = THelperFunctions.isDarkMode(context);
    return Consumer<OfferProvider>(
      builder: (context, offerProvider, _) {
        return Form(
          key: formKey,
          child: Column(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('I have', style: Theme.of(context).textTheme.labelSmall,),
                  SizedBox(
                    child: TextFormField(
                      style: Theme.of(context).textTheme.labelMedium,
                      validator: TValidator.numValidator,
                      onChanged: (value) => offerProvider.updateAmount(value),
                      onSaved: (value) {
                        offerProvider.updateAmount(value!);
                      },
                      decoration: InputDecoration(
                        suffixIcon: DropdownButton<Currency>(
                          dropdownColor: darkMode ? TColors.grey : TColors.white,
                          borderRadius: BorderRadius.circular(10),
                          focusColor: Colors.white,
                          autofocus: false,
                          isExpanded: false,
                          value: offerProvider.debitedCurrency,
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
                            offerProvider.updateDebitedCurrency(val!);
                          },
                          items: [
                            for (final currency in offerProvider.currencies)
                              DropdownMenuItem<Currency>(
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
                              ),
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
                  Text('I need', style: Theme.of(context).textTheme.labelSmall,),
                  TextFormField(
                    decoration: InputDecoration(
                      suffixIcon: DropdownButton<Currency>(
                        dropdownColor: darkMode ? TColors.grey : TColors.white,
                        borderRadius: BorderRadius.circular(10),
                        focusColor: Colors.white,
                        autofocus: false,
                        isExpanded: true,
                        value: offerProvider.creditedCurrency,
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
                        onChanged: (val) => offerProvider.updateCreditedCurrency(val!),
                        items: [
                          for (final currency in offerProvider.currencies)
                            DropdownMenuItem<Currency>(
                              value: currency,
                              child: SizedBox(
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 8),
                                  child: Row(
                                    children: [
                                      // SizedBox(
                                      //     width: 30,
                                      //     height: 30,
                                      //     child: Image(image: AssetImage(
                                      //         currency == 'NGN'
                                      //             ? TImages.ngnIcon
                                      //             : TImages.gbpIcon
                                      //     ))
                                      // ),
                                      Text(
                                        getCurrencyName(currency),
                                        style: Theme.of(context).textTheme.labelMedium,
                                      ),
                                    ],
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
                  Text('Preferred rate ${offerProvider.debitedCurrency != Currency.NGN ? '(per ${getCurrencyName(offerProvider.debitedCurrency)})' : ''}', style: Theme.of(context).textTheme.labelSmall,),
                  TextFormField(
                    style: Theme.of(context).textTheme.labelMedium,
                    validator: TValidator.numValidator,
                    onChanged: (value) => offerProvider.updateRate(value),
                    onSaved: (val) {
                      offerProvider.updateRate(val!);
                    },
                    decoration: InputDecoration(
                      suffixIcon: Padding(
                        padding: const EdgeInsets.only(right: 14.8),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            if (offerProvider.debitedCurrency != Currency.NGN && offerProvider.creditedCurrency != Currency.NGN && offerProvider.rate != 0)
                            AppoxIcon(),
                            const SizedBox(width: TSizes.xl,),
                            if (offerProvider.debitedCurrency != Currency.NGN && offerProvider.creditedCurrency != Currency.NGN && offerProvider.rate != 0)
                            Text('${offerProvider.amount * offerProvider.rate} ${getCurrencyName(offerProvider.creditedCurrency)}', style: Theme.of(context).textTheme.bodyMedium,),
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
                  Text('Expires in', style: Theme.of(context).textTheme.labelSmall,),
                  TextFormField(
                    style: Theme.of(context).textTheme.labelMedium,
                    decoration: InputDecoration(
                      suffixIcon: DropdownButton<int>(
                        dropdownColor: darkMode ? TColors.grey : TColors.white,
                        borderRadius: BorderRadius.circular(10),
                        focusColor: Colors.white,
                        autofocus: false,
                        isExpanded: true,
                        value: offerProvider.expireIn,
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
                          offerProvider.updateExpiryIn(value!);
                        },
                        items: [
                          for (final hour in offerProvider.hours)
                            DropdownMenuItem<int>(
                              value: hour,
                              child: SizedBox(
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 8),
                                  child: Text(
                                    hour.toString(),
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
                  Text('You will be debited from', style: Theme.of(context).textTheme.labelSmall,),
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
                        '${getCurrencyName(offerProvider.debitedCurrency)} wallet',
                      style: Theme.of(context).textTheme.labelMedium,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: TSizes.spaceBtwInputFields,),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('You will be credited to', style: Theme.of(context).textTheme.labelSmall,),
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
                      '${getCurrencyName(offerProvider.creditedCurrency)} wallet',
                      style: Theme.of(context).textTheme.labelMedium,
                    ),
                  )
                ],
              ),
              const SizedBox(height: TSizes.spaceBtwSections,),
              TElevatedButton(
                  onTap: (){
                    if (formKey.currentState!.validate()) {
                      formKey.currentState!.save();
                      if (
                      offerProvider.amount != 0 &&
                          offerProvider.rate != 0 &&
                          offerProvider.expireIn != 0
                      ) {
                        Get.to(() => const CreateReviewDetailsScreen());
                      }
                    }
                    },
                  buttonText: 'Continue'),
              const SizedBox(height: TSizes.spaceBtwSections,),
            ],
          ),
        );
      }
    );
  }
}

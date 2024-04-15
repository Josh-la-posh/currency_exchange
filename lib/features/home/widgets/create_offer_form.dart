import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:provider/provider.dart';
import 'package:swappr/data/provider/offer_provider.dart';
import 'package:swappr/utils/helpers/helper_functions.dart';

import '../../../common/widgets/buttons/elevated_button.dart';
import '../../../utils/constants/colors.dart';
import '../../../utils/constants/image_strings.dart';
import '../../../utils/constants/sizes.dart';
import '../screens/create_review_details.dart';
import '../icons/svg.dart';

class CreateOfferForm extends StatefulWidget {
  const CreateOfferForm({super.key});

  @override
  State<CreateOfferForm> createState() => _CreateOfferFormState();
}

class _CreateOfferFormState extends State<CreateOfferForm> {
  final _formKey = GlobalKey<FormState>();
  final _hasAmountController = TextEditingController();


  int current = 0;

  @override
  void initState() {
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Consumer<OfferProvider>(
      builder: (context, offerProvider, _) => Form(
          child: Column(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('I have', style: Theme.of(context).textTheme.labelSmall,),
                  TextFormField(
                    onChanged: (value) => offerProvider.updateHasAmount(value),
                    decoration: InputDecoration(
                      suffixIcon: DropdownButton(
                        dropdownColor: Colors.white,
                        focusColor: Colors.white,
                        autofocus: false,
                        isExpanded: false,
                        value: offerProvider.sellingCurrency,
                        underline: const SizedBox(),
                        icon: RotatedBox(
                          quarterTurns: 3,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 14.8),
                            child: Icon(
                              Icons.arrow_back_ios_rounded,
                              size: 12,
                              color: TColors.textPrimaryO80,
                            ),
                          ),
                        ),
                        onChanged: (value) {
                          setState(() {
                            offerProvider.sellingCurrency = value!;
                            if (value == 'NGN') {
                              current = 1;
                            } else {current = 0;}
                            Provider.of<OfferProvider>(context, listen: false).updateHasCurrency(value.toString());
                          });
                        },
                        items: [
                          for (final currency in offerProvider.currencies)
                            DropdownMenuItem<String>(
                              value: currency,
                              child: SizedBox(
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 0),
                                  child: Row(
                                    children: [
                                      SizedBox(
                                          width: 30,
                                          height: 30,
                                          child: Image(image: AssetImage(
                                              currency == 'NGN'
                                                  ? TImages.ngnIcon
                                                  : TImages.gbpIcon
                                          ))
                                      ),
                                      Text(
                                        currency,
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
                  Text('I need', style: Theme.of(context).textTheme.labelSmall,),
                  TextFormField(
                    decoration: InputDecoration(
                      suffixIcon: DropdownButton(
                        dropdownColor: Colors.white,
                        focusColor: Colors.white,
                        autofocus: false,
                        isExpanded: true,
                        value: offerProvider.buyingCurrency,
                        underline: const SizedBox(),
                        icon: RotatedBox(
                          quarterTurns: 3,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 14.8),
                            child: Icon(
                              Icons.arrow_back_ios_rounded,
                              size: 12,
                              color: TColors.textPrimary.withOpacity(0.8),
                            ),
                          ),
                        ),
                        onChanged: (String? value) {
                          setState(() {
                            offerProvider.buyingCurrency = value!;
                            if (value == 'NGN') {
                              current = 1;
                            } else {current = 0;}

                            Provider.of<OfferProvider>(context, listen: false).updateNeededCurrency(value.toString());
                          });
                        },
                        items: [
                          for (final currency in offerProvider.availableBuyingCurrencies)
                            DropdownMenuItem<String>(
                              value: currency,
                              child: SizedBox(
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 8),
                                  child: Row(
                                    children: [
                                      SizedBox(
                                          width: 30,
                                          height: 30,
                                          child: Image(image: AssetImage(
                                              currency == 'NGN'
                                                  ? TImages.ngnIcon
                                                  : TImages.gbpIcon
                                          ))
                                      ),
                                      Text(
                                        currency,
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
                  Text('Preferred rate ${offerProvider.sellingCurrency != null ? '(per ${offerProvider.sellingCurrency})' : ''}', style: Theme.of(context).textTheme.labelSmall,),
                  TextFormField(
                    onChanged: (value) => offerProvider.updatePreferredRate(value),
                    decoration: InputDecoration(
                      suffixIcon: Padding(
                        padding: const EdgeInsets.only(right: 14.8),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            if (offerProvider.sellingCurrency != null && offerProvider.createOfferEntity.preferredRate != '')
                            AppoxIcon(),
                            const SizedBox(width: TSizes.xl,),
                            if (offerProvider.sellingCurrency != null && offerProvider.createOfferEntity.preferredRate != '')
                            Text('${THelperFunctions.getStringMultiplication(offerProvider.createOfferEntity.hasAmount, offerProvider.createOfferEntity.preferredRate)} ${offerProvider.buyingCurrency}', style: Theme.of(context).textTheme.bodyLarge,),
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
                  Text('Minimum rate ${offerProvider.sellingCurrency != null ? '(per ${offerProvider.sellingCurrency})' : ''}', style: Theme.of(context).textTheme.labelSmall,),
                  TextFormField(
                    onChanged: (value) => offerProvider.updateMinimumRate(value),
                    decoration: InputDecoration(
                      suffixIcon: Padding(
                        padding: const EdgeInsets.only(right: 14.8),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            if (offerProvider.buyingCurrency != null && offerProvider.createOfferEntity.minimumRate != '')
                            AppoxIcon(),
                            const SizedBox(width: TSizes.xl,),
                            if (offerProvider.buyingCurrency != null && offerProvider.createOfferEntity.minimumRate != '')
                            Text('${THelperFunctions.getStringMultiplication(offerProvider.createOfferEntity.hasAmount, offerProvider.createOfferEntity.minimumRate)} ${offerProvider.buyingCurrency}', style: Theme.of(context).textTheme.bodyLarge,),
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
                    decoration: InputDecoration(
                      suffixIcon: DropdownButton(
                        dropdownColor: Colors.white,
                        focusColor: Colors.white,
                        autofocus: false,
                        isExpanded: true,
                        value: offerProvider.waitingHour,
                        underline: const SizedBox(),
                        icon: Padding(
                          padding: const EdgeInsets.only(right: 14.8),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              ClockIcon(),
                              const SizedBox(width: TSizes.sm),
                              Text('HOUR', style: Theme.of(context).textTheme.labelMedium,),
                              const SizedBox(width: TSizes.sm),
                              Icon(
                                Icons.keyboard_arrow_down_rounded,
                                // size: 17,
                                color: TColors.textPrimaryO80,
                              ),
                            ],
                          ),
                        ),
                        onChanged: (value) {
                          setState(() {
                            offerProvider.waitingHour = value!;
                            Provider.of<OfferProvider>(context, listen: false).updateExpiryHour(value.toString());
                          });
                        },
                        items: [
                          for (final hour in offerProvider.hours)
                            DropdownMenuItem<String>(
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
                  Text('You will be debited from', style: Theme.of(context).textTheme.labelSmall,),
                  TextFormField(
                    decoration: InputDecoration(
                      suffixIcon: DropdownButton(
                        dropdownColor: Colors.white,
                        focusColor: Colors.white,
                        autofocus: false,
                        isExpanded: true,
                        value: offerProvider.buyingCurrency,
                        underline: const SizedBox(),
                        icon: RotatedBox(
                          quarterTurns: 3,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 14.8),
                            child: Icon(
                              Icons.arrow_back_ios_rounded,
                              size: 12,
                              color: TColors.textPrimary.withOpacity(0.8),
                            ),
                          ),
                        ),
                        onChanged: (String? newValue) {
                          setState(() {
                            offerProvider.buyingCurrency = newValue!;
                            if (newValue == 'NGN') {
                              current = 1;
                            } else {current = 0;}
                          });
                        },
                        items: [
                          for (final item in offerProvider.currencies)
                            DropdownMenuItem<String>(
                              value: item,
                              child: SizedBox(
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 8),
                                  child: Row(
                                    children: [
                                      SizedBox(
                                          width: 30,
                                          height: 30,
                                          child: Image(image: AssetImage(
                                              item == 'NGN'
                                                  ? TImages.ngnIcon
                                                  : TImages.gbpIcon
                                          ))
                                      ),
                                      Text(
                                        item,
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
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('You will be credited to', style: Theme.of(context).textTheme.labelSmall,),
                  TextFormField(
                    decoration: InputDecoration(
                      suffixIcon: DropdownButton(
                        dropdownColor: Colors.white,
                        focusColor: Colors.white,
                        autofocus: false,
                        isExpanded: true,
                        value: offerProvider.buyingCurrency,
                        underline: const SizedBox(),
                        icon: RotatedBox(
                          quarterTurns: 3,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 14.8),
                            child: Icon(
                              Icons.arrow_back_ios_rounded,
                              size: 12,
                              color: TColors.textPrimary.withOpacity(0.8),
                            ),
                          ),
                        ),
                        onChanged: (String? newValue) {
                          setState(() {
                            offerProvider.buyingCurrency = newValue!;
                            if (newValue == 'NGN') {
                              current = 1;
                            } else {current = 0;}
                          });
                        },
                        items: [
                          for (final item in offerProvider.currencies)
                            DropdownMenuItem<String>(
                              value: item,
                              child: SizedBox(
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 8),
                                  child: Row(
                                    children: [
                                      SizedBox(
                                          width: 30,
                                          height: 30,
                                          child: Image(image: AssetImage(
                                              item == 'NGN'
                                                  ? TImages.ngnIcon
                                                  : TImages.gbpIcon
                                          ))
                                      ),
                                      Text(
                                        item,
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
              const SizedBox(height: TSizes.spaceBtwSections,),
              TElevatedButton(onTap: (){Get.to(() => const CreateReviewDetailsScreen());}, buttonText: 'Continue'),
              const SizedBox(height: TSizes.spaceBtwSections,),
            ],
          ),
        )
    );
  }
}

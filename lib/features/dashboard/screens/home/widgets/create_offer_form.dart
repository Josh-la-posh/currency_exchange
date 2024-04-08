import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../../../../common/widgets/buttons/elevated_button.dart';
import '../../../../../utils/constants/colors.dart';
import '../../../../../utils/constants/image_strings.dart';
import '../../../../../utils/constants/sizes.dart';
import '../create_review_details.dart';
import '../icons/svg.dart';

class CreateOfferForm extends StatefulWidget {
  const CreateOfferForm({super.key});

  @override
  State<CreateOfferForm> createState() => _CreateOfferFormState();
}

class _CreateOfferFormState extends State<CreateOfferForm> {
  String? _buyingItem;
  String? _sellingItem;
  String? _waitingHour;
  List items = ['GBP', 'NGN'];
  List hours = ['1', '2', '3', '4', '5'];
  int current = 0;

  @override
  void initState() {
    super.initState();
    _buyingItem = items[1];
    _sellingItem = items[0];
    _waitingHour = hours[0];
  }
  @override
  Widget build(BuildContext context) {
    return Form(
      child: Column(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('I have', style: Theme.of(context).textTheme.labelSmall,),
              TextFormField(
                decoration: InputDecoration(
                  suffixIcon: DropdownButton(
                    dropdownColor: Colors.white,
                    focusColor: Colors.white,
                    autofocus: false,
                    isExpanded: false,
                    value: _sellingItem,
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
                    onChanged: (String? newValue) {
                      setState(() {
                        _sellingItem = newValue!;
                        if (newValue == 'NGN') {
                          current = 1;
                        } else {current = 0;}
                      });
                    },
                    items: [
                      for (final item in items)
                        DropdownMenuItem<String>(
                          value: item,
                          child: SizedBox(
                            child: Padding(
                              padding: const EdgeInsets.only(left: 0),
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
                    value: _buyingItem,
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
                        _buyingItem = newValue!;
                        if (newValue == 'NGN') {
                          current = 1;
                        } else {current = 0;}
                      });
                    },
                    items: [
                      for (final item in items)
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
          const SizedBox(height: TSizes.spaceBtwInputFields,),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Preferred rate (per ${_sellingItem})', style: Theme.of(context).textTheme.labelSmall,),
              TextFormField(
                decoration: InputDecoration(
                  suffixIcon: Padding(
                    padding: const EdgeInsets.only(right: 14.8),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        AppoxIcon(),
                        const SizedBox(width: TSizes.xl,),
                        Text('40,000 NGN', style: Theme.of(context).textTheme.bodyLarge,),
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
              Text('Minimum rate (per ${_sellingItem})', style: Theme.of(context).textTheme.labelSmall,),
              TextFormField(
                decoration: InputDecoration(
                  suffixIcon: Padding(
                    padding: const EdgeInsets.only(right: 14.8),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        AppoxIcon(),
                        const SizedBox(width: TSizes.xl,),
                        Text('30,000 NGN', style: Theme.of(context).textTheme.bodyLarge,),
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
                    value: _waitingHour,
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
                    onChanged: (String? newValue) {
                      setState(() {
                        _waitingHour = newValue!;
                        // if (newValue == 'NGN') {
                        //   current = 1;
                        // } else {current = 0;}
                      });
                    },
                    items: [
                      for (final hour in hours)
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
                    value: _buyingItem,
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
                        _buyingItem = newValue!;
                        if (newValue == 'NGN') {
                          current = 1;
                        } else {current = 0;}
                      });
                    },
                    items: [
                      for (final item in items)
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
                    value: _buyingItem,
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
                        _buyingItem = newValue!;
                        if (newValue == 'NGN') {
                          current = 1;
                        } else {current = 0;}
                      });
                    },
                    items: [
                      for (final item in items)
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
    );
  }
}

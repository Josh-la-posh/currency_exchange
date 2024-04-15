import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:swappr/common/widgets/buttons/elevated_button.dart';
import 'package:swappr/utils/constants/colors.dart';
import 'package:swappr/utils/constants/image_strings.dart';

import '../../../utils/constants/sizes.dart';

class SubscriptionForm extends StatefulWidget {
  const SubscriptionForm({super.key});

  @override
  State<SubscriptionForm> createState() => _SubscriptionFormState();
}

class _SubscriptionFormState extends State<SubscriptionForm> {

  String? _buyingItem;
  String? _sellingItem;
  List items = ['GBP', 'NGN'];
  int current = 0;

  @override
  void initState() {
    super.initState();
    _buyingItem = items[0];
    _sellingItem = items[1];
  }

  @override
  Widget build(BuildContext context) {
    return Form(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('They have', style: Theme.of(context).textTheme.labelSmall,),
            Container(
              height: TSizes.textInputFieldHeight,
              decoration: BoxDecoration(
                  color: TColors.textFieldBackground,
                  border: Border.all(
                      color: TColors.secondaryBorder),
                  borderRadius: const BorderRadius.all(Radius.circular(TSizes.borderRadiusSm))
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: DropdownButton(
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
                        size: 20,
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
                            padding: const EdgeInsets.only(left: 0),
                            child: Row(
                              children: [
                                Container(
                                  width: 40,
                                    height: 40,
                                    child: Image(image: AssetImage(
                                        item == 'NGN'
                                            ? TImages.ngnIcon
                                            : TImages.gbpIcon
                                    ))
                                ),
                                Text(
                                  item,
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
            ),
            const SizedBox(height: TSizes.spaceBtwInputFields,),
            Text('They need', style: Theme.of(context).textTheme.labelSmall,),
            Container(
              height: TSizes.textInputFieldHeight,
              decoration: BoxDecoration(
                  color: TColors.textFieldBackground,
                  border: Border.all(
                      color: TColors.secondaryBorder),
                  borderRadius: const BorderRadius.all(Radius.circular(TSizes.borderRadiusSm))
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: DropdownButton(
                  dropdownColor: Colors.white,
                  focusColor: Colors.white,
                  autofocus: false,
                  isExpanded: true,
                  value: _sellingItem,
                  underline: const SizedBox(),
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
                  onChanged: (String? newValue) {
                    setState(() {
                      _sellingItem = newValue!;
                      if (newValue == 'NGN') {
                        current = 1;
                      } else if (newValue == 'EUR') {
                        current = 2;
                      } else {current = 0;}
                    });
                  },
                  items: [
                    for (final item in items)
                      DropdownMenuItem<String>(
                        value: item,
                        child: SizedBox(
                          child: Row(
                            children: [
                              SizedBox(
                                  width: 40,
                                  height: 40,
                                  child: Image(image: AssetImage(
                                      item == 'NGN'
                                          ? TImages.ngnIcon
                                          : TImages.gbpIcon
                                  ))
                              ),
                              Text(
                                item,
                                style: Theme.of(context).textTheme.bodyLarge
                              ),
                            ],
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: TSizes.spaceBtwInputFields,),
            Text('Rate Range per GBP', style: Theme.of(context).textTheme.labelSmall,),
            Row(
              children: [
                Expanded(
                  child: Container(
                    height: TSizes.textInputFieldHeight,
                    decoration: BoxDecoration(
                      color: TColors.textFieldBackground,
                      borderRadius: BorderRadius.circular(TSizes.buttonRadius),
                      border: Border.all(
                        width: 1,
                        color: TColors.secondaryBorder
                      )
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: TSizes.xs, horizontal: TSizes.md),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          RichText(
                              text: TextSpan(
                                  style: Theme.of(context).textTheme.labelSmall,
                                  children: <TextSpan> [
                                    TextSpan(
                                        text: 'Minimum rate (NGN)',
                                        style: TextStyle(
                                          fontSize: TSizes.fontSize9,
                                          color: TColors.textPrimary.withOpacity(0.6),
                                        )
                                    ),
                                  ]
                              )
                          ),
                          Expanded(
                            child: SizedBox(
                              // height: 16,
                              child: TextFormField(
                                decoration: const InputDecoration(
                                  contentPadding: EdgeInsets.all(0),
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
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: TSizes.xl,),
                Expanded(
                  child: Container(
                    height: TSizes.textInputFieldHeight,
                    decoration: BoxDecoration(
                        color: TColors.textFieldBackground,
                        borderRadius: BorderRadius.circular(TSizes.buttonRadius),
                        border: Border.all(
                            width: 1,
                            color: TColors.secondaryBorder
                        )
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: TSizes.xs, horizontal: TSizes.md),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          RichText(
                              text: TextSpan(
                                  style: Theme.of(context).textTheme.labelSmall,
                                  children: <TextSpan> [
                                    TextSpan(
                                        text: 'Maximum rate (NGN)',
                                        style: TextStyle(
                                          fontSize: TSizes.fontSize9,
                                          color: TColors.textPrimary.withOpacity(0.6),
                                        )
                                    ),
                                  ]
                              )
                          ),
                          Expanded(
                            child: SizedBox(
                              // height: 16,
                              child: TextFormField(
                                decoration: const InputDecoration(
                                  contentPadding: EdgeInsets.all(0),
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
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: TSizes.spaceBtwSections,),
            TElevatedButton(onTap: (){}, buttonText: 'Subscribe'),
          ],
    ));
  }
}

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pouch/utils/constants/colors.dart';
import 'package:pouch/utils/helpers/helper_functions.dart';
import '../../features/all_offer/icons/svg.dart';
import '../../utils/constants/sizes.dart';

class CurrencyWidget extends StatelessWidget {
  const CurrencyWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 82,
      decoration: const BoxDecoration(
        // color: TColors.textFieldBackground
      ),
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: [
          SizedBox(
            width: THelperFunctions.screenWidth() / 3,
            child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TransferWiseIcon(),
              const SizedBox(height: TSizes.sm,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  RichText(
                      text: TextSpan(
                          style: Theme.of(context).textTheme.bodySmall,
                          children: const <TextSpan> [
                            TextSpan(
                                text: '1 GBP',
                                style: TextStyle(fontSize: TSizes.fontSize11)
                            )
                          ]
                      )
                  ),
                  const SizedBox(width: TSizes.xs,),
                  ApproximateIcon(),
                  const SizedBox(width: TSizes.xs,),
                  RichText(
                      text: TextSpan(
                          style: Theme.of(context).textTheme.bodySmall,
                          children: const <TextSpan> [
                            TextSpan(
                                text: '400 NGN',
                                style: TextStyle(fontSize: TSizes.fontSize11)
                            )
                          ]
                      )
                  ),
                ],
              ),
              const SizedBox(height: TSizes.xs,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  RichText(
                      text: TextSpan(
                          style: Theme.of(context).textTheme.bodySmall,
                          children: const <TextSpan> [
                            TextSpan(
                                text: '1 EUR',
                                style: TextStyle(fontSize: TSizes.fontSize11)
                            )
                          ]
                      )
                  ),
                  const SizedBox(width: TSizes.xs,),
                  ApproximateIcon(),
                  const SizedBox(width: TSizes.xs,),
                  RichText(
                      text: TextSpan(
                          style: Theme.of(context).textTheme.bodySmall,
                          children: const <TextSpan> [
                            TextSpan(
                                text: '600 NGN',
                                style: TextStyle(fontSize: TSizes.fontSize11)
                            )
                          ]
                      )
                  ),
                ],
              ),
            ],
            ),
          ),
          SizedBox(
            width: THelperFunctions.screenWidth() / 3,
            child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              WorldRemitIcon(),
              const SizedBox(height: TSizes.sm,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  RichText(
                      text: TextSpan(
                          style: Theme.of(context).textTheme.bodySmall,
                          children: const <TextSpan> [
                            TextSpan(
                                text: '1 GBP',
                                style: TextStyle(fontSize: TSizes.fontSize11)
                            )
                          ]
                      )
                  ),
                  const SizedBox(width: TSizes.xs,),
                  ApproximateIcon(),
                  const SizedBox(width: TSizes.xs,),
                  RichText(
                      text: TextSpan(
                          style: Theme.of(context).textTheme.bodySmall,
                          children: const <TextSpan> [
                            TextSpan(
                                text: '400 NGN',
                                style: TextStyle(fontSize: TSizes.fontSize11)
                            )
                          ]
                      )
                  ),
                ],
              ),
              const SizedBox(height: TSizes.xs,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  RichText(
                      text: TextSpan(
                          style: Theme.of(context).textTheme.bodySmall,
                          children: const <TextSpan> [
                            TextSpan(
                                text: '1 EUR',
                                style: TextStyle(fontSize: TSizes.fontSize11)
                            )
                          ]
                      )
                  ),
                  const SizedBox(width: TSizes.xs,),
                  ApproximateIcon(),
                  const SizedBox(width: TSizes.xs,),
                  RichText(
                      text: TextSpan(
                          style: Theme.of(context).textTheme.bodySmall,
                          children: const <TextSpan> [
                            TextSpan(
                                text: '600 NGN',
                                style: TextStyle(fontSize: TSizes.fontSize11)
                            )
                          ]
                      )
                  ),
                ],
              ),
            ],
                      ),
          ),
          SizedBox(
            width: THelperFunctions.screenWidth() / 3,
            child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              AzimoIcon(),
              const SizedBox(height: TSizes.sm,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  RichText(
                      text: TextSpan(
                          style: Theme.of(context).textTheme.bodySmall,
                          children: const <TextSpan> [
                            TextSpan(
                                text: '1 GBP',
                                style: TextStyle(fontSize: TSizes.fontSize11)
                            )
                          ]
                      )
                  ),
                  const SizedBox(width: TSizes.xs,),
                  ApproximateIcon(),
                  const SizedBox(width: TSizes.xs,),
                  RichText(
                      text: TextSpan(
                          style: Theme.of(context).textTheme.bodySmall,
                          children: const <TextSpan> [
                            TextSpan(
                                text: '400 NGN',
                                style: TextStyle(fontSize: TSizes.fontSize11)
                            )
                          ]
                      )
                  ),
                ],
              ),
              const SizedBox(height: TSizes.xs,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  RichText(
                      text: TextSpan(
                          style: Theme.of(context).textTheme.bodySmall,
                          children: const <TextSpan> [
                            TextSpan(
                                text: '1 EUR',
                                style: TextStyle(fontSize: TSizes.fontSize11)
                            )
                          ]
                      )
                  ),
                  const SizedBox(width: TSizes.xs,),
                  ApproximateIcon(),
                  const SizedBox(width: TSizes.xs,),
                  RichText(
                      text: TextSpan(
                          style: Theme.of(context).textTheme.bodySmall,
                          children: const <TextSpan> [
                            TextSpan(
                                text: '600 NGN',
                                style: TextStyle(fontSize: TSizes.fontSize11)
                            )
                          ]
                      )
                  ),
                ],
              ),
            ],
                      ),
          ),]
      ),
    );
  }
}
import 'package:flutter/material.dart';
import '../../../utils/constants/colors.dart';
import '../../../utils/constants/sizes.dart';

class HomeBalanceWidget extends StatelessWidget {
  const HomeBalanceWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: TSizes.defaultSpace * 2),
      child: Container(
        decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(10)),
            boxShadow: [
              BoxShadow(
                  color: TColors.black.withOpacity(0.12),
                  offset: const Offset(1.94,3.87),
                  blurRadius: 1.94,
                  spreadRadius: 1.94
              ),
              BoxShadow(
                  color: TColors.secondaryBorder,
                  offset: const Offset(0.0,0.0),
                  blurRadius: 0,
                  spreadRadius: 0
              ),
            ]
        ),
        child: Padding(
          padding: const EdgeInsets.only(left: TSizes.lg, right: TSizes.lg, top: TSizes.md, bottom: TSizes.xl),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      RichText(
                          text: TextSpan(
                              style: Theme.of(context).textTheme.labelMedium,
                              children: const <TextSpan> [
                                TextSpan(
                                    text:'My Balance',
                                    style: TextStyle(fontWeight: TSizes.fontWeightMd)
                                ),
                              ]
                          )
                      ),
                      const SizedBox(width: TSizes.md),
                      SizedBox(
                        width: 15,
                        child: IconButton(
                            onPressed: () {},
                            icon: Icon(Icons.remove_red_eye_outlined, size: 17,)
                        ),
                      )
                    ],
                  ),
                  Container(
                    width: 30,
                    height: 30,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      color: TColors.danger,
                    ),
                  )
                ],
              ),
              Row(
                children: [
                  RichText(
                      text: TextSpan(
                          style: Theme.of(context).textTheme.titleLarge,
                          children: const <TextSpan> [
                            TextSpan(
                                text:'3600.00',
                                style: TextStyle(fontWeight: TSizes.fontWeightXl, fontSize: 28)
                            ),
                            TextSpan(
                                text:' USD',
                                style: TextStyle(fontWeight: TSizes.fontWeightXl)
                            ),
                          ]
                      )
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

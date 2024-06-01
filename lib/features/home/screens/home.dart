import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:provider/provider.dart';
import 'package:swappr/data/modules/app_navigator.dart';
import 'package:swappr/features/all_offer/screens/all_offer.dart';
import 'package:swappr/features/home/icons/svg.dart';
import 'package:swappr/features/subscription/screens/subscribe.dart';
import 'package:swappr/features/transaction/screens/history.dart';
import 'package:swappr/features/verification/screens/verify_page.dart';
import 'package:swappr/utils/constants/colors.dart';
import 'package:swappr/utils/constants/sizes.dart';
import 'package:swappr/utils/constants/texts.dart';
import '../../../data/provider/offer_provider.dart';
import '../../all_offer/apis/api.dart';
import '../widgets/layout.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  OfferProvider offerProvider = Provider.of<OfferProvider>(
    AppNavigator.instance.navigatorKey.currentContext as BuildContext,
    listen: false
  );


  @override
  void initState() {
    if (offerProvider.offers.isEmpty) {
      OfferService.instance.getAllOffers(
          offerProvider: offerProvider,
          currency: '',
          date: ''
      );
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return DashboardScreenLayout(
      childWidget:SingleChildScrollView(
        child: Container(
          width: double.infinity,
          decoration: BoxDecoration(
              color: TColors.secondaryBorder
          ),
          child: Column(
              children: [
                SizedBox(height: TSizes.defaultSpace,),
                Padding(
                  padding: const EdgeInsets.only(right: TSizes.defaultSpace * 1.5),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      GestureDetector(
                        onTap: () {

                        },
                          child: DrawerIcon(height: 14)
                      ),
                    ],
                  ),
                ),
                SizedBox(height: TSizes.defaultSpace/2,),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: TSizes.defaultSpace * 2),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      boxShadow: [
                        BoxShadow(
                          color: TColors.black.withOpacity(0.12),
                          offset: Offset(1.94,3.87),
                          blurRadius: 1.94,
                          spreadRadius: 1.94
                        ),
                        BoxShadow(
                            color: TColors.secondaryBorder,
                            offset: Offset(0.0,0.0),
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
                                          children: <TextSpan> [
                                            TextSpan(
                                                text:'My Balance',
                                                style: const TextStyle(fontWeight: TSizes.fontWeightMd)
                                            ),
                                          ]
                                      )
                                  ),
                                  SizedBox(width: TSizes.md),
                                  Text('eyes')
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
                                      children: <TextSpan> [
                                        TextSpan(
                                            text:'3600.00',
                                            style: const TextStyle(fontWeight: TSizes.fontWeightXl, fontSize: 28)
                                        ),
                                        TextSpan(
                                            text:' USD',
                                            style: const TextStyle(fontWeight: TSizes.fontWeightXl)
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
                ),
                SizedBox(height: TSizes.defaultSpace,),
                Container(
                  height: 2,
                  padding: EdgeInsets.symmetric(horizontal: TSizes.defaultSpace / 1.5, vertical: TSizes.lg),
                  decoration: BoxDecoration(
                      color: TColors.white.withOpacity(0.32)
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: TSizes.defaultSpace * 2, vertical: TSizes.xs),
                  decoration: BoxDecoration(
                      color: TColors.secondaryBorder,
                      boxShadow: [
                        BoxShadow(
                            color: TColors.black.withOpacity(0.25),
                            offset: Offset(0,4),
                            blurRadius: 4,
                            spreadRadius: 0
                        ),
                      ]
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(height: TSizes.sm),
                          GestureDetector(
                            onTap: () {
                              Get.to(() => const AllOfferScreen());
                            },
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                  width: 40,
                                  height: 40,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(40)
                                  ),
                                  child: Image(image: AssetImage('assets/icons/homeIcons/all_offer.png')),
                                ),
                                SizedBox(height: 7,),
                                RichText(
                                    text: TextSpan(
                                        style: Theme.of(context).textTheme.labelSmall,
                                        children: <TextSpan> [
                                          TextSpan(
                                              text:'All Offer',
                                              style: TextStyle(fontWeight: TSizes.fontWeightMd, color: TColors.textPrimary.withOpacity(0.5))
                                          ),
                                        ]
                                    )
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: TSizes.xl),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                width: 40,
                                height: 40,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(40)
                                ),
                                child: Image(image: AssetImage('assets/icons/homeIcons/subscribe.png')),
                              ),
                              SizedBox(height: 7,),
                              RichText(
                                  text: TextSpan(
                                      style: Theme.of(context).textTheme.labelSmall,
                                      children: <TextSpan> [
                                        TextSpan(
                                            text:'Deposit',
                                            style: TextStyle(fontWeight: TSizes.fontWeightMd, color: TColors.textPrimary.withOpacity(0.5))
                                        ),
                                      ]
                                  )
                              ),
                            ],
                          ),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(height: TSizes.sm),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                width: 40,
                                height: 40,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(40)
                                ),
                                child: Image(image: AssetImage('assets/icons/homeIcons/wallet.png')),
                              ),
                              SizedBox(height: 7,),
                              RichText(
                                  text: TextSpan(
                                      style: Theme.of(context).textTheme.labelSmall,
                                      children: <TextSpan> [
                                        TextSpan(
                                            text:'Wallet',
                                            style: TextStyle(fontWeight: TSizes.fontWeightMd, color: TColors.textPrimary.withOpacity(0.5))
                                        ),
                                      ]
                                  )
                              ),
                            ],
                          ),
                          SizedBox(height: TSizes.xl),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                width: 40,
                                height: 40,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(40)
                                ),
                                child: Image(image: AssetImage('assets/icons/homeIcons/subscribe.png')),
                              ),
                              SizedBox(height: 7,),
                              RichText(
                                  text: TextSpan(
                                      style: Theme.of(context).textTheme.labelSmall,
                                      children: <TextSpan> [
                                        TextSpan(
                                            text:'Withdraw',
                                            style: TextStyle(fontWeight: TSizes.fontWeightMd, color: TColors.textPrimary.withOpacity(0.5))
                                        ),
                                      ]
                                  )
                              ),
                            ],
                          ),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(height: TSizes.sm),
                          GestureDetector(
                            onTap: () {
                              Get.to(() => const SubscribeScreen());
                            },
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                  width: 40,
                                  height: 40,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(40)
                                  ),
                                  child: Image(image: AssetImage('assets/icons/homeIcons/subscribe.png')),
                                ),
                                SizedBox(height: 7,),
                                RichText(
                                    text: TextSpan(
                                        style: Theme.of(context).textTheme.labelSmall,
                                        children: <TextSpan> [
                                          TextSpan(
                                              text:'Subscribe',
                                              style: TextStyle(fontWeight: TSizes.fontWeightMd, color: TColors.textPrimary.withOpacity(0.5))
                                          ),
                                        ]
                                    )
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: TSizes.xl),
                          GestureDetector(
                            onTap: () {
                              Get.to(() => const TransactionHistoryScreen());
                            },
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                  width: 40,
                                  height: 40,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(40)
                                  ),
                                  child: Image(image: AssetImage('assets/icons/homeIcons/subscribe.png')),
                                ),
                                SizedBox(height: 7,),
                                RichText(
                                  textAlign: TextAlign.center,
                                    text: TextSpan(
                                        style: Theme.of(context).textTheme.labelSmall,
                                        children: <TextSpan> [
                                          TextSpan(
                                              text:'Transaction \n history',
                                              style: TextStyle(fontWeight: TSizes.fontWeightMd, color: TColors.textPrimary.withOpacity(0.5), height: 1.4)
                                          ),
                                        ]
                                    )
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: TSizes.sm),
                        ],
                      )
                    ],
                  ),
                ),
                SizedBox(height: TSizes.defaultSpace,),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: TSizes.defaultSpace / 1.5),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: TSizes.lg, vertical: TSizes.xs),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(
                            color: TColors.primary
                          )
                        ),
                        child: Row(
                          children: [
                            Text('Trending Offer',
                              style: TextStyle(
                                color: TColors.primary,
                                fontSize: 16,
                                fontWeight: TSizes.fontWeightNm,
                                fontFamily: TTexts.fontFamily,
                              ),
                            ),
                            SizedBox(width: TSizes.md,),
                            Container(
                              width: 23,
                              height: 23,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(23)
                              ),
                              child: Image(image: AssetImage('assets/icons/homeIcons/trading_offer.png')),
                            ),
                          ],
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Get.to(() => const AllOfferScreen());
                        },
                        child: Row(
                          children: [
                            Text('View All',
                              style: TextStyle(
                                  color: TColors.primary,
                                  fontSize: 12,
                                  fontWeight: TSizes.fontWeightNm,
                                  fontFamily: TTexts.fontFamily
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(height: TSizes.defaultSpace/2,),
                Container(
                  height: 80,
                  width: double.infinity,
                  color: TColors.white,
                ),
                SizedBox(height: TSizes.md,),
                Container(
                  height: 80,
                  width: double.infinity,
                  color: TColors.white,
                ),
                SizedBox(height: TSizes.md,),
                Container(
                  height: 80,
                  width: double.infinity,
                  color: TColors.white,
                ),
                SizedBox(height: TSizes.md,),
              ],
            ),
        ),
      ),
    );
  }
}


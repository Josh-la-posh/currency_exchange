import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:pouch/common/widgets/currencyWidget.dart';
import 'package:pouch/utils/shared/refresh_indicator/refresh_indicator.dart';
import 'package:provider/provider.dart';
import 'package:pouch/features/negotiation_offer/screen/my_bid.dart';
import 'package:pouch/features/negotiation_offer/screen/my_offer.dart';
import 'package:pouch/utils/constants/sizes.dart';
import '../../../common/widgets/custom_shapes/currency_widget_with_back.dart';
import '../../../data/modules/app_navigator.dart';
import '../../../data/modules/background_task.dart';
import '../../../data/provider/offer_provider.dart';
import '../../../utils/constants/colors.dart';
import '../../../utils/helpers/helper_functions.dart';
import '../../all_offer/apis/api.dart';
import '../widget/negotiation_list.dart';

class MyBidAndOfferScreen extends StatefulWidget {
  const MyBidAndOfferScreen({super.key});

  @override
  State<MyBidAndOfferScreen> createState() => _NegotiationOfferScreenState();
}

class _NegotiationOfferScreenState extends State<MyBidAndOfferScreen> {
  OfferProvider offerProvider = Provider.of<OfferProvider>(
      AppNavigator.instance.navigatorKey.currentContext as BuildContext,
      listen: false
  );

  bool showMyOffer = true;
  bool displayMyOffer = false;
  bool displayMyBid = false;

  handleShowMyOffer(val) {
    setState(() {
      showMyOffer = val;
    });
  }

  @override
  void initState() {
    if (offerProvider.myBids.isEmpty) {
      NoLoaderService.instance.getMyBids(
          offerProvider: offerProvider,
          days: '', currency: '',
          onSuccess: () {
            Future.delayed(
                Duration(seconds: 2),
                    () => setState(() {
                  displayMyBid = true;
                })
            );
          },
          onFailure: () {
            setState(() {
              displayMyBid = true;
            });
          }
      );
      setState(() {
        displayMyBid = false;
      });
    } else {
      setState(() {
        displayMyBid = true;
      });
    }
    if (offerProvider.myOffers.isEmpty) {
      NoLoaderService.instance.getMyOffers(
          offerProvider: offerProvider,
          days: '',
          currency: '',
          onFailure: (){
            setState(() {
              displayMyOffer = true;
            });
          },
          onSuccess: (){
            Future.delayed(
                Duration(seconds: 2),
                    () => setState(() {
                  displayMyOffer = true;
                })
            );
          }
      );
      setState(() {
        displayMyOffer = false;
      });
    } else {
      setState(() {
        displayMyOffer = true;
      });
    }
    super.initState();
  }

  Future<void> _refreshOffers() async {
    await NoLoaderService.instance.getMyOffers(offerProvider: offerProvider, days: '', currency: '', onFailure: (){}, onSuccess: (){});
    await NoLoaderService.instance.getMyBids(offerProvider: offerProvider, days: '', currency: '', onFailure: (){}, onSuccess: (){print('okkkk');});
    await Future.delayed(const Duration(seconds: 2),);
  }

  @override
  Widget build(BuildContext context) {
    final darkMode = THelperFunctions.isDarkMode(context);
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(),
        body: Column(
          children: [
            CurrencyWidget(),
            Padding(
              padding: const EdgeInsets.only(left: TSizes.defaultSpace, right: TSizes.defaultSpace, bottom: 10),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        showMyOffer = true;
                      });
                    },
                    child: Container(
                      height: 25,
                      width: 80,
                      decoration: BoxDecoration(
                        color: showMyOffer == true ? TColors.primary : Color(0xFFC1BBC9),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          RichText(
                            textAlign: TextAlign.center,
                              text: TextSpan(
                                  style: Theme.of(context).textTheme.labelSmall,
                                  children: <TextSpan> [
                                    TextSpan(
                                        text: 'My Offers',
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: TSizes.fontWeightLg
                                        )
                                    ),
                                  ]
                              )
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(width: TSizes.defaultSpace * 1.2),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        showMyOffer = false;
                      });
                    },
                    child: Container(
                      height: 25,
                      width: 80,
                      decoration: BoxDecoration(
                        color: showMyOffer == true ? Color(0xFFC1BBC9) : TColors.primary,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          RichText(
                              textAlign: TextAlign.center,
                              text: TextSpan(
                                  style: Theme.of(context).textTheme.labelSmall,
                                  children: <TextSpan> [
                                    TextSpan(
                                        text: 'My Bids',
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: TSizes.fontWeightLg
                                        )
                                    ),
                                  ]
                              )
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: CustomRefreshIndicator(
                  onRefresh: _refreshOffers,
                  child: SingleChildScrollView(
                    physics: AlwaysScrollableScrollPhysics(),
                    child: showMyOffer == true
                        ? MyOfferScreen(darkMode: darkMode, displayMyOffer: displayMyOffer,)
                        : MyBidScreen(darkMode: darkMode, displayMyBids: displayMyOffer,),
                  )
              ),
            )
          ],
        ),
      ),
    );
  }
}


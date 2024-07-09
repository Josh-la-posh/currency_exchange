import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:swappr/features/negotiation_offer/screen/my_bid.dart';
import 'package:swappr/features/negotiation_offer/screen/my_offer.dart';
import 'package:swappr/utils/constants/sizes.dart';
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

  handleShowMyOffer(val) {
    setState(() {
      showMyOffer = val;
    });
  }

  @override
  void initState() {
    if (offerProvider.myOffers.isEmpty || offerProvider.myBids.isEmpty) {
      OfferService.instance.getMyOffers(offerProvider: offerProvider, days: '', currency: '');
      OfferService.instance.getMyBids(offerProvider: offerProvider, days: '', currency: '');
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final darkMode = THelperFunctions.isDarkMode(context);
    print(offerProvider.negotiationsOffers.length);
    return Scaffold(
      backgroundColor: darkMode ? TColors.black.withOpacity(0.8) : TColors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            CurrencyWidgetWithBack(),
            SizedBox(height: TSizes.defaultSpace * 1.5),

            Padding(
              padding: const EdgeInsets.only(left: TSizes.defaultSpace * 2, right: TSizes.defaultSpace),
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
                                        text: 'My Offer',
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
                                        text: 'Bid Offer',
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
                  Spacer(),
                  IconButton(
                    onPressed: (){
                      NoLoaderService.instance.getMyOffers(offerProvider: offerProvider, days: '', currency: '');
                      NoLoaderService.instance.getMyBids(offerProvider: offerProvider, days: '', currency: '');
                    },
                    icon: Icon(Icons.refresh, size: 18, color: darkMode ? Colors.white : TColors.textPrimary,),
                  ),
                ],
              ),
            ),
            showMyOffer == true 
                ? MyOfferScreen(darkMode: darkMode) 
                : MyBidScreen(darkMode: darkMode),
          ],
        ),
      ),
    );
  }
}


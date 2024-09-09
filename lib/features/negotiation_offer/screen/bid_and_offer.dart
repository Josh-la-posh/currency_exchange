import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:pouch/common/widgets/currencyWidget.dart';
import 'package:pouch/features/all_offer/controllers/offer_controller.dart';
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

class MyBidAndOfferScreen extends StatelessWidget {
  final OfferController offerController = Get.put(OfferController());

  @override
  Widget build(BuildContext context) {
    if (offerController.myOffers.isEmpty) {
      offerController.fetchMyOffers(days: '', currency: '');
    }
    if (offerController.myBids.isEmpty) {
      offerController.fetchMyBids(days: '', currency: '');
    }
    final darkMode = THelperFunctions.isDarkMode(context);
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(),
        body: Column(
          children: [
            CurrencyWidget(),
            Padding(
              padding: const EdgeInsets.only(left: TSizes.defaultSpace, right: TSizes.defaultSpace, bottom: 10),
              child: Obx(() => Row(
                children: [
                  GestureDetector(
                    onTap: () => offerController.myOfferIndex.value = 0,
                    child: Container(
                      height: 25,
                      width: 80,
                      decoration: BoxDecoration(
                        color: offerController.myOfferIndex == 0 ? TColors.primary : Color(0xFFC1BBC9),
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
                    onTap: () => offerController.myOfferIndex.value = 1,
                    child: Container(
                      height: 25,
                      width: 80,
                      decoration: BoxDecoration(
                        color: offerController.myOfferIndex == 0 ? Color(0xFFC1BBC9) : TColors.primary,
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
              )),
            ),
            Obx(() => Expanded(
              child: offerController.myOfferIndex == 0
                  ? MyOfferScreen(darkMode: darkMode)
                  : MyBidScreen(darkMode: darkMode),
            ))
          ],
        ),
      ),
    );
  }
}


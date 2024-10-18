import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pouch/common/widgets/currencyWidget.dart';
import 'package:pouch/features/negotiation_offer/controller/negotiation_offer_controller.dart';
import 'package:pouch/features/negotiation_offer/screen/my_bid.dart';
import 'package:pouch/features/negotiation_offer/screen/my_offer.dart';
import 'package:pouch/utils/constants/sizes.dart';
import '../../../data/modules/interceptor.dart';
import '../../../utils/constants/colors.dart';
import '../../../utils/helpers/helper_functions.dart';

class MyBidAndOfferScreen extends StatelessWidget {
  final AppInterceptor appInterceptor = AppInterceptor();
  @override
  Widget build(BuildContext context) {
    NegotiationOfferController controller = Get.put(NegotiationOfferController());
    if (controller.myOffers.isEmpty) {
      controller.fetchMyOffers(days: '', currency: '');
    }
    if (controller.myBids.isEmpty) {
      controller.fetchMyBids(days: '', currency: '');
    }
    final darkMode = THelperFunctions.isDarkMode(context);
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            appInterceptor.cancelOngoingRequest(() {
              controller.resetBoolOnOngoingRequest();
            });
            Get.back();
          },
          icon: const Icon(Icons.arrow_back),
          style: IconButton.styleFrom(
            foregroundColor: Colors.grey,
            iconSize: TSizes.iconBackSize,
          ),
          hoverColor: Colors.transparent,
        ),
        title: Text('My Offers'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: TSizes.defaultSpace, right: TSizes.defaultSpace, bottom: 10),
            child: Obx(() => Row(
              children: [
                GestureDetector(
                  onTap: () => controller.myOfferIndex.value = 0,
                  child: Container(
                    height: 25,
                    width: 80,
                    decoration: BoxDecoration(
                      color: controller.myOfferIndex == 0 ? TColors.primary : Color(0xFFC1BBC9),
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
                  onTap: () => controller.myOfferIndex.value = 1,
                  child: Container(
                    height: 25,
                    width: 80,
                    decoration: BoxDecoration(
                      color: controller.myOfferIndex == 0 ? Color(0xFFC1BBC9) : TColors.primary,
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
            child: controller.myOfferIndex == 0
                ? MyOfferScreen(darkMode: darkMode)
                : MyBidScreen(darkMode: darkMode),
          ))
        ],
      ),
    );
  }
}


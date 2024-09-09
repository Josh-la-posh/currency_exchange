import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:pouch/features/all_offer/controllers/offer_controller.dart';
import 'package:pouch/features/home/controller/home_controller.dart';
import 'package:pouch/utils/shared/refresh_indicator/refresh_indicator.dart';
import 'package:pouch/utils/shimmer/order_shimmer.dart';
import '../../../utils/constants/colors.dart';
import '../../../utils/constants/sizes.dart';
import '../../../utils/helpers/helper_functions.dart';
import '../../negotiation_offer/widget/no_negotiation.dart';

class TrendingOffer extends StatelessWidget {
  final HomeController homeController = Get.put(HomeController());
  final OfferController offerController = Get.put(OfferController());

  @override
  Widget build(BuildContext context) {
    final darkMode = THelperFunctions.isDarkMode(context);
    return Container(
      width: double.infinity,
      child: Obx(() {
        if (homeController.isOfferLoading.value) {
          return OrderShimmer(length: '3');
        } else {
         return CustomRefreshIndicator(
           onRefresh: () => offerController.fetchTrendingOffers(),
           child: SingleChildScrollView(
             physics: AlwaysScrollableScrollPhysics(),
             child: Column(
                children: [
                  offerController.trendingOffers.isEmpty
                      ? NoNegotiationScreen(title: 'Offer',)
                      : ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: offerController.trendingOffers.length > 3 ? 3 : offerController.trendingOffers.length,
                    itemBuilder: (_, index) {
                      final item = offerController.trendingOffers[index];
                      return Column(
                        children: [
                          Container(
                            child: ListTile(
                              tileColor: darkMode ? Colors.black38 : Color(0xFFFDF9FE),
                              dense: true,
                              contentPadding: const EdgeInsets.symmetric(horizontal: TSizes.defaultSpace, vertical: TSizes.sm),
                              onTap: (){
                                offerController.fetchOfferById(
                                    id: item.id.toString(),
                                    currency: item.debitedCurrency.toString(),
                                    onSuccess: () {}
                                );
                              },
                              title: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      RichText(
                                          text: TextSpan(
                                              style: Theme.of(context).textTheme.labelMedium,
                                              children: <TextSpan> [
                                                TextSpan(
                                                    text: 'has: ',
                                                    style: TextStyle(fontSize: 13)
                                                ),
                                                TextSpan(
                                                    text: '${THelperFunctions.moneyFormatter(item.amount.toString())} ${item.debitedCurrency}',
                                                    style: TextStyle(fontWeight: FontWeight.w500)
                                                ),
                                              ]
                                          )
                                      ),
                                      const SizedBox(height: TSizes.md,),
                                      RichText(
                                          text: TextSpan(
                                              style: Theme.of(context).textTheme.labelMedium,
                                              children: <TextSpan> [
                                                TextSpan(
                                                    text: 'needs: ',
                                                    style: TextStyle(fontSize: 13)
                                                ),
                                                TextSpan(
                                                    text: '${item.creditedCurrency}',
                                                    style: TextStyle(fontWeight: FontWeight.w500)
                                                ),
                                              ]
                                          )
                                      ),
                                    ],
                                  ),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      RichText(
                                          text: TextSpan(
                                              style: Theme.of(context).textTheme.labelMedium,
                                              children: <TextSpan> [
                                                TextSpan(
                                                    text: THelperFunctions.formatRate(item.rate.toString()),
                                                    style: TextStyle(color: TColors.primary, fontWeight: FontWeight.w500)
                                                ),
                                                TextSpan(
                                                    text: ' ${item.creditedCurrency} // ${item.debitedCurrency}',
                                                    style: TextStyle(fontSize: TSizes.fontSize12, color: TColors.primary, fontWeight: FontWeight.w500)
                                                ),
                                              ]
                                          )
                                      ),
                                      const SizedBox(height: TSizes.md,),
                                      Row(
                                        children: [
                                          Icon(
                                            Icons.visibility,
                                            size: 15,
                                          ),
                                          const SizedBox(width: TSizes.md,),
                                          RichText(
                                              text: TextSpan(
                                                  style: Theme.of(context).textTheme.labelSmall,
                                                  children: <TextSpan> [
                                                    TextSpan(
                                                        text: '${item.views}',
                                                        style: TextStyle(
                                                          color: darkMode ? TColors.white : TColors.textPrimaryO80,
                                                        )
                                                    ),
                                                  ]
                                              )
                                          ),
                                          const SizedBox(width: TSizes.lg,),
                                          RichText(
                                              text: TextSpan(
                                                  style: Theme.of(context).textTheme.labelSmall,
                                                  children: <TextSpan> [
                                                    TextSpan(
                                                        text: '${THelperFunctions.getTimeDifference(item.createdDate.toString())}',
                                                        style: TextStyle(
                                                          color: darkMode ? TColors.white.withOpacity(0.7) : TColors.textPrimary.withOpacity(0.5),
                                                        )
                                                    ),
                                                  ]
                                              )
                                          ),
                                        ],
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(height: TSizes.md,)
                        ],);},
                  ),
                ],
              ),
           ),
         );
        }
      }),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pouch/utils/shared/refresh_indicator/refresh_indicator.dart';
import '../../../../../utils/helpers/helper_functions.dart';
import '../../../../../utils/layouts/list_layout.dart';
import '../../../controllers/offer_controller.dart';
import '../../../widgets/no_offer.dart';
import '../../../widgets/offer_item.dart';
import 'package:pouch/utils/shimmer/order_shimmer.dart';

class GbpTrendingMarketList extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    OfferController offerController = Get.find();
    if (offerController.trendingGbpOffers.isEmpty) {
      offerController.fetchTrendingGbpOffers();
    }
    return Obx(() {
      if (offerController.isGbpTrendingOffersLoading.value && offerController.trendingGbpOffers.isEmpty) {
        return OrderShimmer();
      } else {
        return CustomRefreshIndicator(
          onRefresh: () => offerController.fetchTrendingGbpOffers(),
          child: Container(
            height: THelperFunctions.screenHeight(),
            child: SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              child: Column(
                children: [
                  offerController.trendingGbpOffers.isEmpty
                      ? const NoOfferScreen()
                      : TListLayout(
                    itemCount: offerController.trendingGbpOffers.length,
                    itemBuilder: (_, index) {
                      final item = offerController.trendingGbpOffers[index];
                      return OfferItem(item: item);
                    },
                  ),
                ],
              ),
            ),
          ),
        );
      }
    });
  }
}

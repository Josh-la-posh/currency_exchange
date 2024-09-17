import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pouch/utils/shared/refresh_indicator/refresh_indicator.dart';
import '../../../../../utils/layouts/list_layout.dart';
import '../../../controllers/offer_controller.dart';
import '../../../widgets/no_offer.dart';
import '../../../widgets/offer_item.dart';
import 'package:pouch/utils/shimmer/order_shimmer.dart';

class GbpTrendingMarketList extends StatelessWidget {
  final offerController = Get.find<OfferController>();

  @override
  Widget build(BuildContext context) {
    if (offerController.trendingGbpOffers.isEmpty) {
      offerController.fetchAllGbpOffers();
    }
    return Obx(() {
      if (offerController.isGbpTrendingOffersLoading.value && offerController.trendingGbpOffers.isEmpty) {
        return OrderShimmer();
      } else {
        return CustomRefreshIndicator(
          onRefresh: () => offerController.fetchTrendingGbpOffers(),
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
        );
      }
    });
  }
}

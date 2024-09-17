import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pouch/utils/shared/refresh_indicator/refresh_indicator.dart';
import '../../../../../utils/layouts/list_layout.dart';
import '../../../controllers/offer_controller.dart';
import '../../../widgets/no_offer.dart';
import '../../../widgets/offer_item.dart';
import 'package:pouch/utils/shimmer/order_shimmer.dart';

class NgnTrendingMarketList extends StatelessWidget {
  final offerController = Get.find<OfferController>();

  @override
  Widget build(BuildContext context) {
    if (offerController.allNgnOffers.isEmpty) {
      offerController.fetchTrendingNgnOffers();
    }
    return Obx(() {
      if (offerController.isNgnTrendingOffersLoading.value && offerController.trendingNgnOffers.isEmpty) {
        return OrderShimmer();
      } else {
        return CustomRefreshIndicator(
          onRefresh: () => offerController.fetchTrendingNgnOffers(),
          child: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            child: Column(
              children: [
                offerController.trendingNgnOffers.isEmpty
                    ? const NoOfferScreen()
                    : TListLayout(
                  itemCount: offerController.trendingNgnOffers.length,
                  itemBuilder: (_, index) {
                    final item = offerController.trendingNgnOffers[index];
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

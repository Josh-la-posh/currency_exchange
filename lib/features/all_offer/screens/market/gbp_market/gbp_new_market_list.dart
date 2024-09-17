import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pouch/utils/shimmer/order_shimmer.dart';
import '../../../../../utils/layouts/list_layout.dart';
import '../../../../../utils/shared/refresh_indicator/refresh_indicator.dart';
import '../../../controllers/offer_controller.dart';
import '../../../widgets/no_offer.dart';
import '../../../widgets/offer_item.dart';

class GbpNewMarketList extends StatelessWidget {
  final offerController = Get.find<OfferController>();

  @override
  Widget build(BuildContext context) {
    if (offerController.newGbpOffers.isEmpty) {
      offerController.fetchNewGbpOffers();
    }
    return Obx(() {
      if (offerController.isGbpNewOffersLoading.value && offerController.newGbpOffers.isEmpty) {
        return OrderShimmer();
      } else {
        return CustomRefreshIndicator(
          onRefresh: () => offerController.fetchNewGbpOffers(),
          child: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            child: Column(
              children: [
                offerController.newGbpOffers.isEmpty
                    ? const NoOfferScreen()
                    : TListLayout(
                  itemCount: offerController.newGbpOffers.length,
                  itemBuilder: (_, index) {
                    final item = offerController.newGbpOffers[index];
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
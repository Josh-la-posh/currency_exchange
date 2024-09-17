import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pouch/utils/shimmer/order_shimmer.dart';
import '../../../../../utils/layouts/list_layout.dart';
import '../../../../../utils/shared/refresh_indicator/refresh_indicator.dart';
import '../../../controllers/offer_controller.dart';
import '../../../widgets/no_offer.dart';
import '../../../widgets/offer_item.dart';

class NgnNewMarketList extends StatelessWidget {
  final offerController = Get.find<OfferController>();

  @override
  Widget build(BuildContext context) {
    if (offerController.newNgnOffers.isEmpty) {
      offerController.fetchNewNgnOffers();
    }
    return Obx(() {
      if (offerController.isNgnNewOffersLoading.value && offerController.newNgnOffers.isEmpty) {
        return OrderShimmer();
      } else {
        return CustomRefreshIndicator(
          onRefresh: () => offerController.fetchNewNgnOffers(),
          child: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            child: Column(
              children: [
                offerController.newNgnOffers.isEmpty
                    ? const NoOfferScreen()
                    : TListLayout(
                  itemCount: offerController.newNgnOffers.length,
                  itemBuilder: (_, index) {
                    final item = offerController.newNgnOffers[index];
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
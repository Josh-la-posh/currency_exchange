import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pouch/utils/shimmer/order_shimmer.dart';
import '../../../../../utils/layouts/list_layout.dart';
import '../../../../../utils/shared/refresh_indicator/refresh_indicator.dart';
import '../../../controllers/offer_controller.dart';
import '../../../widgets/no_offer.dart';
import '../../../widgets/offer_item.dart';

class NgnMarketList extends StatelessWidget {
  final offerController = Get.find<OfferController>();

  @override
  Widget build(BuildContext context) {
    if (offerController.allNgnOffers.isEmpty) {
      offerController.fetchAllNgnOffers();
    }
    return Obx(() {
      if (offerController.isNgnOffersLoading.value && offerController.allNgnOffers.isEmpty) {
        return OrderShimmer();
      } else {
        return CustomRefreshIndicator(
          onRefresh: () => offerController.fetchAllNgnOffers(),
          child: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            child: Column(
              children: [
                offerController.allNgnOffers.isEmpty
                    ? const NoOfferScreen()
                    : TListLayout(
                  itemCount: offerController.allNgnOffers.length,
                  itemBuilder: (_, index) {
                    final item = offerController.allNgnOffers[index];
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

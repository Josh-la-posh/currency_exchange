import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pouch/utils/shimmer/order_shimmer.dart';
import '../../../../../utils/layouts/list_layout.dart';
import '../../../../../utils/shared/refresh_indicator/refresh_indicator.dart';
import '../../../controllers/offer_controller.dart';
import '../../../widgets/no_offer.dart';
import '../../../widgets/offer_item.dart';

class AllNewMarketList extends StatelessWidget {
  final offerController = Get.find<OfferController>();

  @override
  Widget build(BuildContext context) {
    if (offerController.newOffers.isEmpty) {
      offerController.fetchNewOffers();
    }
    return Obx(() {
      if (offerController.isNewOffersLoading.value && offerController.newOffers.isEmpty) {
        return OrderShimmer();
      } else {
        return CustomRefreshIndicator(
          onRefresh: () => offerController.fetchAllOffers(),
          child: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            child: Column(
              children: [
                offerController.newOffers.isEmpty
                    ? const NoOfferScreen()
                    : TListLayout(
                  itemCount: offerController.newOffers.length,
                  itemBuilder: (_, index) {
                    final item = offerController.newOffers[index];
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
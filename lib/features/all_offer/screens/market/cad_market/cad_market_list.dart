import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pouch/utils/shimmer/order_shimmer.dart';
import '../../../../../utils/layouts/list_layout.dart';
import '../../../../../utils/shared/refresh_indicator/refresh_indicator.dart';
import '../../../controllers/offer_controller.dart';
import '../../../widgets/no_offer.dart';
import '../../../widgets/offer_item.dart';

class CadMarketList extends StatelessWidget {
  final offerController = Get.find<OfferController>();

  @override
  Widget build(BuildContext context) {
    if (offerController.allCadOffers.isEmpty) {
      offerController.fetchAllCadOffers();
    }
    return Obx(() {
      if (offerController.isCadOffersLoading.value && offerController.allCadOffers.isEmpty) {
        return OrderShimmer();
      } else {
        return CustomRefreshIndicator(
          onRefresh: () => offerController.fetchAllCadOffers(),
          child: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            child: Column(
              children: [
                offerController.allCadOffers.isEmpty
                    ? const NoOfferScreen()
                    : TListLayout(
                  itemCount: offerController.allCadOffers.length,
                  itemBuilder: (_, index) {
                    final item = offerController.allCadOffers[index];
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

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pouch/utils/shared/refresh_indicator/refresh_indicator.dart';
import '../../../../../utils/helpers/helper_functions.dart';
import '../../../../../utils/layouts/list_layout.dart';
import '../../../controllers/offer_controller.dart';
import '../../../widgets/no_offer.dart';
import '../../../widgets/offer_item.dart';
import 'package:pouch/utils/shimmer/order_shimmer.dart';

class UsdTrendingMarketList extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
  final OfferController offerController = Get.find();
    if (offerController.trendingUsdOffers.isEmpty) {
      offerController.fetchTrendingUsdOffers();
    }
    return Obx(() {
      if (offerController.isUsdTrendingOffersLoading.value && offerController.trendingUsdOffers.isEmpty) {
        return OrderShimmer();
      } else {
        return CustomRefreshIndicator(
          onRefresh: () => offerController.fetchTrendingUsdOffers(),
          child: Container(
            height: THelperFunctions.screenHeight(),
            child: SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              child: Column(
                children: [
                  offerController.trendingUsdOffers.isEmpty
                      ? const NoOfferScreen()
                      : TListLayout(
                    itemCount: offerController.trendingUsdOffers.length,
                    itemBuilder: (_, index) {
                      final item = offerController.trendingUsdOffers[index];
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

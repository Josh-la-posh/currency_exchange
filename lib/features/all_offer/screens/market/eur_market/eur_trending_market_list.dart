import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pouch/utils/shared/refresh_indicator/refresh_indicator.dart';
import '../../../../../utils/helpers/helper_functions.dart';
import '../../../../../utils/layouts/list_layout.dart';
import '../../../controllers/offer_controller.dart';
import '../../../widgets/no_offer.dart';
import '../../../widgets/offer_item.dart';
import 'package:pouch/utils/shimmer/order_shimmer.dart';

class EurTrendingMarketList extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
  final OfferController offerController = Get.find();
    if (offerController.trendingEurOffers.isEmpty) {
      offerController.fetchTrendingEurOffers();
    }
    return Obx(() {
      if (offerController.isEurTrendingOffersLoading.value && offerController.trendingEurOffers.isEmpty) {
        return OrderShimmer();
      } else {
        return CustomRefreshIndicator(
          onRefresh: () => offerController.fetchTrendingEurOffers(),
          child: Container(
            height: THelperFunctions.screenHeight(),
            child: SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              child: Column(
                children: [
                  offerController.trendingEurOffers.isEmpty
                      ? const NoOfferScreen()
                      : TListLayout(
                    itemCount: offerController.trendingEurOffers.length,
                    itemBuilder: (_, index) {
                      final item = offerController.trendingEurOffers[index];
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

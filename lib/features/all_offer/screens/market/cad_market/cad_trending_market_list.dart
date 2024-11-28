import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pouch/utils/shared/refresh_indicator/refresh_indicator.dart';
import '../../../../../utils/helpers/helper_functions.dart';
import '../../../../../utils/layouts/list_layout.dart';
import '../../../controllers/offer_controller.dart';
import '../../../widgets/no_offer.dart';
import '../../../widgets/offer_item.dart';
import 'package:pouch/utils/shimmer/order_shimmer.dart';

class CadTrendingMarketList extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
  final OfferController offerController = Get.find();
    if (offerController.trendingCadOffers.isEmpty) {
      offerController.fetchTrendingCadOffers();
    }
    return Obx(() {
      if (offerController.isCadTrendingOffersLoading.value && offerController.trendingCadOffers.isEmpty) {
        return OrderShimmer();
      } else {
        return CustomRefreshIndicator(
          onRefresh: () => offerController.fetchTrendingCadOffers(),
          child: Container(
            height: THelperFunctions.screenHeight(),
            child: SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              child: Column(
                children: [
                  offerController.trendingCadOffers.isEmpty
                      ? const NoOfferScreen() :
                  TListLayout(
                    itemCount: offerController.trendingCadOffers.length,
                    itemBuilder: (_, index) {
                      final item = offerController.trendingCadOffers[index];
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

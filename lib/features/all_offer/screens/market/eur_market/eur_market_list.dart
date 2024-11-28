import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pouch/utils/shimmer/order_shimmer.dart';
import '../../../../../utils/helpers/helper_functions.dart';
import '../../../../../utils/layouts/list_layout.dart';
import '../../../../../utils/shared/refresh_indicator/refresh_indicator.dart';
import '../../../controllers/offer_controller.dart';
import '../../../widgets/no_offer.dart';
import '../../../widgets/offer_item.dart';

class EurMarketList extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
  final OfferController offerController = Get.find();
    if (offerController.allEurOffers.isEmpty) {
      offerController.fetchAllEurOffers();
    }
    return Obx(() {
      if (offerController.isEurOffersLoading.value && offerController.allEurOffers.isEmpty) {
        return OrderShimmer();
      } else {
        return CustomRefreshIndicator(
          onRefresh: () => offerController.fetchAllEurOffers(),
          child: Container(
            height: THelperFunctions.screenHeight(),
            child: SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              child: Column(
                children: [
                  offerController.allEurOffers.isEmpty
                      ? NoOfferScreen()
                      : TListLayout(
                    itemCount: offerController.allEurOffers.length,
                    itemBuilder: (_, index) {
                      final item = offerController.allEurOffers[index];
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

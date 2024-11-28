import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pouch/utils/shimmer/order_shimmer.dart';
import '../../../../../utils/helpers/helper_functions.dart';
import '../../../../../utils/layouts/list_layout.dart';
import '../../../../../utils/shared/refresh_indicator/refresh_indicator.dart';
import '../../../controllers/offer_controller.dart';
import '../../../widgets/no_offer.dart';
import '../../../widgets/offer_item.dart';

class CadNewMarketList extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
  final OfferController offerController = Get.find();
    if (offerController.newCadOffers.isEmpty) {
      offerController.fetchNewCadOffers();
    }
    return Obx(() {
      if (offerController.isCadNewOffersLoading.value && offerController.newCadOffers.isEmpty) {
        return OrderShimmer();
      } else {
        return CustomRefreshIndicator(
          onRefresh: () => offerController.fetchNewCadOffers(),
          child: Container(
            height: THelperFunctions.screenHeight(),
            child: SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              child: Column(
                children: [
                  offerController.newCadOffers.isEmpty
                      ? const NoOfferScreen()
                      : TListLayout(
                    itemCount: offerController.newCadOffers.length,
                    itemBuilder: (_, index) {
                      final item = offerController.newCadOffers[index];
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
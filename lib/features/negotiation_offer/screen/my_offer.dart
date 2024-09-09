import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pouch/features/all_offer/controllers/offer_controller.dart';
import 'package:pouch/utils/shared/refresh_indicator/refresh_indicator.dart';
import 'package:pouch/utils/shimmer/order_shimmer.dart';
import 'package:pouch/features/negotiation_offer/widget/my_offer_item.dart';
import 'package:pouch/features/negotiation_offer/widget/no_negotiation.dart';
import '../../../utils/layouts/list_layout.dart';

class MyOfferScreen extends StatelessWidget {
  final bool darkMode;
  String? length;
  final OfferController offerController = Get.put(OfferController());
  MyOfferScreen({
    super.key, required this.darkMode, this.length
  });

  Widget build(BuildContext context) {
    return Obx(() {
      if (offerController.isMyOffersLoading.value) {
        return OrderShimmer(length: length);
      } else {
        return CustomRefreshIndicator(
          onRefresh: () => offerController.fetchMyBids(days: '', currency: ''),
          child: SingleChildScrollView(
            physics: AlwaysScrollableScrollPhysics(),
            child: Column(
              children: [
                offerController.myOffers.isEmpty
                    ? LayoutBuilder(builder: (context, constraints) {
                  return const NoNegotiationScreen(title: 'Offer',);
                })
                    : TListLayout(
                    itemCount: length != null
                        ? offerController.myOffers.length < int.parse(length!)
                        ? offerController.myOffers.length
                        : int.parse(length!)
                        : offerController.myOffers.length,
                    itemBuilder: (_, index) {
                      final item = offerController.myOffers[index];
                      return MyOfferItem(item: item);
                    }
                )
              ],
            ),
          ),
        );
      }
    });
  }
}

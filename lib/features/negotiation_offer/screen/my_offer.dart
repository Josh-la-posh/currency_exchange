import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pouch/features/all_offer/controllers/offer_controller.dart';
import 'package:pouch/utils/shared/refresh_indicator/refresh_indicator.dart';
import 'package:pouch/utils/shimmer/order_shimmer.dart';
import 'package:pouch/features/negotiation_offer/widget/my_offer_item.dart';
import 'package:pouch/features/negotiation_offer/widget/no_negotiation.dart';
import '../../../utils/layouts/list_layout.dart';

class MyOfferScreen extends GetView<OfferController> {
  final bool darkMode;
  String? length;
  MyOfferScreen({
    super.key, required this.darkMode, this.length
  });

  Widget build(BuildContext context) {
    return Obx(() {
      if (controller.isMyOffersLoading.value) {
        return OrderShimmer(length: length);
      } else {
        return CustomRefreshIndicator(
          onRefresh: () => controller.fetchMyBids(days: '', currency: ''),
          child: SingleChildScrollView(
            physics: AlwaysScrollableScrollPhysics(),
            child: Column(
              children: [
                controller.myOffers.isEmpty
                    ? LayoutBuilder(builder: (context, constraints) {
                  return const NoNegotiationScreen(title: 'Offer',);
                })
                    : TListLayout(
                    itemCount: length != null
                        ? controller.myOffers.length < int.parse(length!)
                        ? controller.myOffers.length
                        : int.parse(length!)
                        : controller.myOffers.length,
                    itemBuilder: (_, index) {
                      final item = controller.myOffers[index];
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

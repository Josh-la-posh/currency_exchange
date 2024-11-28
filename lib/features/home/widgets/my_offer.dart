import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pouch/features/negotiation_offer/widget/my_offer_item.dart';
import 'package:pouch/utils/shimmer/order_shimmer.dart';
import '../../negotiation_offer/controller/negotiation_offer_controller.dart';
import '../../negotiation_offer/widget/no_negotiation.dart';

class MyOffer extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    final NegotiationOfferController negotiationOfferController = Get.find();
    return Container(
      width: double.infinity,
      child: Obx(() {
        if (negotiationOfferController.isMyOffersLoading.value) {
          return OrderShimmer(length: '3');
        } else {
          return Column(
            children: [
              negotiationOfferController.myOffers.isEmpty
                  ? NoNegotiationScreen(title: 'Offer',)
                  : ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: negotiationOfferController.myOffers.length > 3 ? 3 : negotiationOfferController.myOffers.length,
                itemBuilder: (_, index) {
                  final item = negotiationOfferController.myOffers[index];
                  return MyOfferItem(item: item);
                  },
              ),
            ],
          );
        }
      }),
    );
  }
}

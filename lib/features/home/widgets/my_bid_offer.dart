import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pouch/features/negotiation_offer/widget/my_bid_item.dart';
import 'package:pouch/utils/shimmer/order_shimmer.dart';
import '../../negotiation_offer/controller/negotiation_offer_controller.dart';
import '../../negotiation_offer/widget/no_negotiation.dart';

class MyBidOffer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final NegotiationOfferController negotiationOfferController = Get.find();
    return Container(
      width: double.infinity,
      child: Obx(() {
        if (negotiationOfferController.isMyBidsLoading.value) {
          return OrderShimmer(length: '3');
        } else {
          return Column(
            children: [
              negotiationOfferController.myBids.isEmpty
                  ? NoNegotiationScreen(title: 'Offer',)
                  : ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: negotiationOfferController.myBids.length > 3 ? 3 : negotiationOfferController.myBids.length,
                itemBuilder: (_, index) {
                  final item = negotiationOfferController.myBids[index];
                  return MyBidItem(item: item);
                  },
              ),
            ],
          );
        }
      }),
    );
  }
}

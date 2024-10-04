import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pouch/features/home/controller/home_controller.dart';
import 'package:pouch/features/negotiation_offer/widget/my_bid_item.dart';
import 'package:pouch/utils/shimmer/order_shimmer.dart';
import '../../negotiation_offer/widget/no_negotiation.dart';

class MyBidOffer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    HomeController controller = Get.find();
    return Container(
      width: double.infinity,
      child: Obx(() {
        if (controller.negotiationOfferController.isMyBidsLoading.value) {
          return OrderShimmer(length: '3');
        } else {
          return Column(
            children: [
              controller.negotiationOfferController.myBids.isEmpty
                  ? NoNegotiationScreen(title: 'Offer',)
                  : ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: controller.negotiationOfferController.myBids.length > 3 ? 3 : controller.negotiationOfferController.myBids.length,
                itemBuilder: (_, index) {
                  final item = controller.negotiationOfferController.myBids[index];
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

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pouch/features/all_offer/widgets/offer_item.dart';
import 'package:pouch/features/home/controller/home_controller.dart';
import 'package:pouch/utils/shimmer/order_shimmer.dart';
import '../../../utils/constants/sizes.dart';
import '../../negotiation_offer/widget/no_negotiation.dart';

class TrendingOffer extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    HomeController controller = Get.find();
    return Container(
      padding: EdgeInsets.symmetric(horizontal: TSizes.defaultSpace),
      width: double.infinity,
      child: Obx(() {
        if (controller.offerController.isOfferLoading.value) {
          return OrderShimmer(length: '3');
        } else {
         return Column(
            children: [
              controller.offerController.allOffers.isEmpty
                  ? NoNegotiationScreen(title: 'Offer',)
                  : ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: controller.offerController.allOffers.length > 3 ? 3 : controller.offerController.allOffers.length,
                itemBuilder: (_, index) {
                  final item = controller.offerController.allOffers[index];
                  return OfferItem(item: item);
                  },
              ),
            ],
          );
        }
      }),
    );
  }
}

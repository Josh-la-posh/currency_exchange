import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pouch/features/home/controller/home_controller.dart';
import 'package:pouch/features/negotiation_offer/widget/my_offer_item.dart';
import 'package:pouch/utils/shared/refresh_indicator/refresh_indicator.dart';
import 'package:pouch/utils/shimmer/order_shimmer.dart';
import '../../../utils/constants/colors.dart';
import '../../../utils/constants/sizes.dart';
import '../../../utils/helpers/helper_functions.dart';
import '../../negotiation_offer/widget/no_negotiation.dart';

class MyOffer extends StatelessWidget {
  final controller = Get.find<HomeController>();

  @override
  Widget build(BuildContext context) {
    final darkMode = THelperFunctions.isDarkMode(context);
    return Container(
      width: double.infinity,
      child: Obx(() {
        if (controller.isMyOfferLoading.value) {
          return OrderShimmer(length: '3');
        } else {
          return Column(
            children: [
              controller.offerController.myOffers.isEmpty
                  ? NoNegotiationScreen(title: 'Offer',)
                  : ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: controller.offerController.myOffers.length > 3 ? 3 : controller.offerController.myOffers.length,
                itemBuilder: (_, index) {
                  final item = controller.offerController.myOffers[index];
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

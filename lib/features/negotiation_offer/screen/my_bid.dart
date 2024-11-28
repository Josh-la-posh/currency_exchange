import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pouch/features/negotiation_offer/controller/negotiation_offer_controller.dart';
import 'package:pouch/utils/shared/refresh_indicator/refresh_indicator.dart';
import 'package:pouch/utils/shimmer/order_shimmer.dart';
import 'package:pouch/features/negotiation_offer/widget/my_bid_item.dart';
import 'package:pouch/features/negotiation_offer/widget/no_negotiation.dart';
import '../../../utils/helpers/helper_functions.dart';
import '../../../utils/layouts/list_layout.dart';

class MyBidScreen extends StatelessWidget {
  final bool darkMode;
  String? length;
  MyBidScreen({
    super.key, required this.darkMode, this.length
  });

  Widget build(BuildContext context) {
    final NegotiationOfferController controller = Get.find();
    return Obx(() {
      if (controller.isMyBidsLoading.value) {
        return OrderShimmer(length: length);
      } else {
        return CustomRefreshIndicator(
            onRefresh: () => controller.fetchMyBids(days: '', currency: ''),
            child: Container(
              height: THelperFunctions.screenHeight(),
              child: SingleChildScrollView(
                physics: AlwaysScrollableScrollPhysics(),
                child: Column(
                  children: [
                    controller.myBids.isEmpty
                        ? LayoutBuilder(builder: (context, constraints) {
                      return const NoNegotiationScreen(title: 'Bid',);
                    })
                        : TListLayout(
                        itemCount: length != null
                            ? controller.myBids.length < int.parse(length!)
                            ? controller.myBids.length
                            : int.parse(length!)
                            : controller.myBids.length,
                        itemBuilder: (_, index) {
                          final item = controller.myBids[index];
                          return MyBidItem(item: item);
                        }
                    )
                  ],
                ),
              ),
            ));
      }
    });
  }
}

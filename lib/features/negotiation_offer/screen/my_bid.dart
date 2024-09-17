import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pouch/features/all_offer/controllers/offer_controller.dart';
import 'package:pouch/utils/shared/refresh_indicator/refresh_indicator.dart';
import 'package:pouch/utils/shimmer/order_shimmer.dart';
import 'package:provider/provider.dart';
import 'package:pouch/data/modules/background_task.dart';
import 'package:pouch/features/negotiation_offer/widget/my_bid_item.dart';
import 'package:pouch/features/negotiation_offer/widget/no_negotiation.dart';
import '../../../data/provider/offer_provider.dart';
import '../../../utils/constants/colors.dart';
import '../../../utils/constants/sizes.dart';
import '../../../utils/layouts/list_layout.dart';

class MyBidScreen extends StatelessWidget {
  final bool darkMode;
  String? length;
  final offerController = Get.find<OfferController>();
  MyBidScreen({
    super.key, required this.darkMode, this.length
  });

  Widget build(BuildContext context) {
    return Obx(() {
      if (offerController.isMyBidsLoading.value) {
        return OrderShimmer(length: length);
      } else {
        return CustomRefreshIndicator(
            onRefresh: () => offerController.fetchMyBids(days: '', currency: ''),
            child: SingleChildScrollView(
              physics: AlwaysScrollableScrollPhysics(),
              child: Column(
                children: [
                  offerController.myBids.isEmpty
                      ? LayoutBuilder(builder: (context, constraints) {
                    return const NoNegotiationScreen(title: 'Bid',);
                  })
                      : TListLayout(
                      itemCount: length != null
                          ? offerController.myBids.length < int.parse(length!)
                          ? offerController.myBids.length
                          : int.parse(length!)
                          : offerController.myBids.length,
                      itemBuilder: (_, index) {
                        final item = offerController.myBids[index];
                        return MyBidItem(item: item);
                      }
                  )
                ],
              ),
            ));
      }
    });
  }
}

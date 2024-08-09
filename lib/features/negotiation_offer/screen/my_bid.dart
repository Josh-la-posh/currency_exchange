import 'package:flutter/material.dart';
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
  bool? displayMyBids;
  String? length;
  MyBidScreen({
    super.key, required this.darkMode, this.length, this.displayMyBids
  });

  Widget build(BuildContext context) {
    final offerProvider = Provider.of<OfferProvider>(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          children: [
            displayMyBids == false
                ? OrderShimmer(length: length,)
                : offerProvider.myBids.isEmpty
                ? LayoutBuilder(builder: (context, constraints) {
              return const NoNegotiationScreen(title: 'Bid',);
            })
                : TListLayout(
                itemCount: length != null
                    ? offerProvider.myBids.length < int.parse(length!)
                    ? offerProvider.myBids.length
                    : int.parse(length!)
                    : offerProvider.myBids.length,
                itemBuilder: (_, index) {
                  final item = offerProvider.myBids[index];
                  return MyBidItem(item: item);
                }
            )
          ],
        )
      ],
    );
  }
}

import 'package:flutter/material.dart';
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
  const MyBidScreen({
    super.key, required this.darkMode,
  });

  Widget build(BuildContext context) {
    final offerProvider = Provider.of<OfferProvider>(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(),
        const SizedBox(height: TSizes.md,),
        Column(
          children: [
            offerProvider.myBids.isEmpty
                ? LayoutBuilder(builder: (context, constraints) {
              return const NoNegotiationScreen(title: 'Bid',);
            })
                : TListLayout(
                itemCount: offerProvider.myBids.length,
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

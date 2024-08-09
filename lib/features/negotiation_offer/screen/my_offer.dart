import 'package:flutter/material.dart';
import 'package:pouch/utils/shimmer/order_shimmer.dart';
import 'package:provider/provider.dart';
import 'package:pouch/data/modules/background_task.dart';
import 'package:pouch/features/negotiation_offer/widget/my_offer_item.dart';
import 'package:pouch/features/negotiation_offer/widget/no_negotiation.dart';
import '../../../data/provider/offer_provider.dart';
import '../../../utils/constants/colors.dart';
import '../../../utils/constants/sizes.dart';
import '../../../utils/layouts/list_layout.dart';

class MyOfferScreen extends StatelessWidget {
  final bool darkMode;
  bool? displayMyOffer;
  String? length;
  MyOfferScreen({
    super.key, required this.darkMode, this.length, this.displayMyOffer
  });

  Widget build(BuildContext context) {
    final offerProvider = Provider.of<OfferProvider>(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          children: [
            displayMyOffer == false
                ? OrderShimmer(length: length)
                : offerProvider.myOffers.isEmpty
                ? LayoutBuilder(builder: (context, constraints) {
              return const NoNegotiationScreen(title: 'Offer',);
            })
                : TListLayout(
                itemCount: length != null
                    ? offerProvider.myOffers.length < int.parse(length!)
                    ? offerProvider.myOffers.length
                    : int.parse(length!)
                    : offerProvider.myOffers.length,
                itemBuilder: (_, index) {
                  final item = offerProvider.myOffers[index];
                  return MyOfferItem(item: item);
                }
            )
          ],
        )
      ],
    );
  }
}

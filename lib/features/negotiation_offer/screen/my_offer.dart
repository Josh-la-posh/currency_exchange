import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:swappr/data/modules/background_task.dart';
import 'package:swappr/features/negotiation_offer/widget/my_offer_item.dart';
import 'package:swappr/features/negotiation_offer/widget/no_negotiation.dart';
import '../../../data/provider/offer_provider.dart';
import '../../../utils/constants/colors.dart';
import '../../../utils/constants/sizes.dart';
import '../../../utils/layouts/list_layout.dart';

class MyOfferScreen extends StatelessWidget {
  final bool darkMode;
  const MyOfferScreen({
    super.key, required this.darkMode,
  });

  Widget build(BuildContext context) {
    final offerProvider = Provider.of<OfferProvider>(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: TSizes.md,),
        Column(
          children: [
            offerProvider.myOffers.isEmpty
                ? LayoutBuilder(builder: (context, constraints) {
              return const NoNegotiationScreen(title: 'Offer',);
            })
                : TListLayout(
                itemCount: offerProvider.myOffers.length,
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

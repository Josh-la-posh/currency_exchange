import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pouch/data/modules/background_task.dart';
import 'package:pouch/features/negotiation_offer/widget/no_negotiation.dart';
import '../../../data/provider/offer_provider.dart';
import '../../../utils/constants/colors.dart';
import '../../../utils/constants/sizes.dart';
import '../../../utils/layouts/list_layout.dart';
import 'negotiation_item.dart';

class NegotiationList extends StatelessWidget {
  final bool darkMode;

  const NegotiationList({
    Key? key,
    required this.darkMode,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<OfferProvider>(
      builder: (context, offerProvider, child) {
        final negotiations = offerProvider.negotiationsOffers;

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            negotiations.isEmpty
                ? const NoNegotiationScreen(title: 'Negotiation')
                : TListLayout(
              itemCount: negotiations.length,
              itemBuilder: (_, index) {
                final item = negotiations[index];
                return NegotiationItem(item: item);
              },
            ),
          ],
        );
      },
    );
  }
}

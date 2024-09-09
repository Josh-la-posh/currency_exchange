import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pouch/features/all_offer/controllers/offer_controller.dart';
import 'package:pouch/features/negotiation_offer/widget/no_negotiation.dart';
import '../../../utils/layouts/list_layout.dart';
import 'negotiation_item.dart';

class NegotiationList extends StatelessWidget {
  final OfferController offerController = Get.put(OfferController());
  final bool darkMode;

  NegotiationList({Key? key, required this.darkMode}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final negotiations = offerController.negotiatedOffers;
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
  }
}

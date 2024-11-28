import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pouch/features/negotiation_offer/widget/no_negotiation.dart';
import '../../../utils/layouts/list_layout.dart';
import '../controller/negotiation_offer_controller.dart';
import 'negotiation_item.dart';

class NegotiationList extends StatelessWidget {
  final bool darkMode;

  NegotiationList({Key? key, required this.darkMode}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final NegotiationOfferController controller = Get.find();
    final negotiations = controller.negotiatedOffers;
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

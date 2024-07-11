import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pouch/data/modules/background_task.dart';
import 'package:pouch/features/negotiation_offer/widget/no_negotiation.dart';
import 'package:pouch/features/transaction/widgets/no_transaction.dart';
import '../../../data/provider/offer_provider.dart';
import '../../../utils/constants/colors.dart';
import '../../../utils/constants/sizes.dart';
import '../../../utils/layouts/list_layout.dart';
import 'negotiation_item.dart';

class NegotiationList extends StatelessWidget {
  final bool darkMode;
  const NegotiationList({
    super.key, required this.darkMode,
  });

  @override
  Widget build(BuildContext context) {
    final offerProvider = Provider.of<OfferProvider>(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(),
        const SizedBox(height: TSizes.md,),
        Column(
          children: [
            Container(
              alignment: Alignment.centerLeft,
              width: double.infinity,
              height: 48,
              color: TColors.primaryBackground,
              padding: const EdgeInsets.symmetric(horizontal: TSizes.defaultSpace),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  RichText(
                      text: TextSpan(
                          style: Theme.of(context).textTheme.labelSmall,
                          children: const <TextSpan> [
                            TextSpan(
                                text: 'Negotiation Offer',
                                style: TextStyle(fontSize: TSizes.fontSize13, fontWeight: TSizes.fontWeightMd)
                            )
                          ]
                      )
                  ),
                  IconButton(
                    onPressed: (){
                      NoLoaderService.instance.getAllNegotiatedOOffers(offerProvider: offerProvider);
                    },
                    icon: Icon(Icons.refresh, size: 18, color: darkMode ? Colors.white : TColors.textPrimary,),
                  ),
                ],
              ),
            ),
            offerProvider.negotiationsOffers.isEmpty
                ? LayoutBuilder(builder: (context, constraints) {
                  return const NoNegotiationScreen(title: 'Negotiation',);
                })
                : TListLayout(
                itemCount: offerProvider.negotiationsOffers.length,
                itemBuilder: (_, index) {
                  final item = offerProvider.negotiationsOffers[index];
                  return NegotiationItem(item: item);
                }
            )
          ],
        )
      ],
    );
  }
}

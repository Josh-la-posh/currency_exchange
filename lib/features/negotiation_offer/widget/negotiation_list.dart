import 'package:flutter/material.dart';
import 'package:swappr/features/negotiation_offer/widget/no_negotiation.dart';
import 'package:swappr/features/transaction/widgets/no_transaction.dart';
import '../../../utils/constants/colors.dart';
import '../../../utils/constants/sizes.dart';
import '../../../utils/layouts/list_layout.dart';
import 'negotiation_item.dart';

class NegotiationList extends StatelessWidget {
  const NegotiationList({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    int? offers = 5;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(),
        const SizedBox(height: TSizes.md,),
        offers == 0
            ? LayoutBuilder(builder: (context, constraints) {
          return const NoNegotiationScreen();
        })
            : Column(
          children: [
            Container(
              alignment: Alignment.centerLeft,
              width: double.infinity,
              height: 48,
              color: TColors.primaryBackground,
              padding: const EdgeInsets.symmetric(horizontal: TSizes.defaultSpace),
              child: RichText(
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
            ),
            TListLayout(
                itemCount: offers,
                itemBuilder: (_, index) {
                  // final item = provider.transactions[index];
                  return NegotiationItem();
                }
            )
          ],
        )
      ],
    );
  }
}

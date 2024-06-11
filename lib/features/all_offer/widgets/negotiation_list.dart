import 'package:flutter/material.dart';
import 'package:swappr/features/all_offer/widgets/no_negotiation.dart';
import 'package:swappr/features/transaction/widgets/no_transaction.dart';
import '../../../utils/constants/sizes.dart';
import '../../../utils/layouts/list_layout.dart';
import 'negotiation_item.dart';

class NegotiationList extends StatelessWidget {
  const NegotiationList({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    int? offers = 1;
    return SizedBox(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: TSizes.spaceBtwSections),
          Container(),
          const SizedBox(height: TSizes.md,),
          offers == 0
              ? LayoutBuilder(builder: (context, constraints) {
            return const NoNegotiationScreen();
          })
              : Column(
            children: [
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
      ),
    );
  }
}

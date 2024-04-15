import 'package:flutter/material.dart';
import 'package:swappr/features/subscription/widgets/no_subscription.dart';
import 'package:swappr/features/subscription/widgets/subscription_item.dart';
import '../../../utils/constants/sizes.dart';
import '../../../utils/layouts/list_layout.dart';

class SubscriptionList extends StatelessWidget {
  const SubscriptionList({
    super.key,
  });

  @override
  Widget build(BuildContext context) {

    const int offer = 1;

    return SizedBox(
      child: offer == 0
          ? LayoutBuilder(builder: (context, constraints) {
        return const NoSubscriptionScreen();
      })
          : Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: TSizes.spaceBtwSections),
          Text(
            'Subscribe',
            style: Theme.of(context).textTheme.titleLarge,
          ),
          const SizedBox(height: TSizes.md,),
          Text(
            'Here are the list of offers you have subscribed to:',
            style: Theme.of(context).textTheme.labelMedium,
          ),
          const SizedBox(height: TSizes.md,),
          Column(
            children: [
              TListLayout(
                  itemCount: 3,
                  itemBuilder: (_, index) => const SubscriptionItem()
              )
            ],
          )
        ],
      ),
    );
  }
}

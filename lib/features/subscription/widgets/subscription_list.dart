import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:swappr/data/provider/subscription_provider.dart';
import 'package:swappr/features/subscription/widgets/no_subscription.dart';
import 'package:swappr/features/subscription/widgets/subscription_item.dart';
import '../../../common/styles/spacing_styles.dart';
import '../../../utils/constants/sizes.dart';
import '../../../utils/layouts/list_layout.dart';

class SubscriptionList extends StatelessWidget {
  const SubscriptionList({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<SubscriptionProvider>(context);

    return SizedBox(
      child: provider.subscriptions.isEmpty
          ? LayoutBuilder(builder: (context, constraints) {
                  return const NoSubscriptionScreen();
                })
          : Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: TSizes.defaultSpace / 1.5),
            child: Column(
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
              ],
            ),
          ),
          const SizedBox(height: TSizes.defaultSpace,),
          Column(
            children: [
              TListLayout(
                  itemCount: provider.subscriptions.length,
                  itemBuilder: (_, index) {
                    final item = provider.subscriptions[index];
                    return SubscriptionItem(item: item);
                  }
              )
            ],
          )
        ],
      ),
    );
  }
}

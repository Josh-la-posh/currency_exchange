import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pouch/data/provider/subscription_provider.dart';
import 'package:pouch/features/subscription/widgets/no_subscription.dart';
import 'package:pouch/features/subscription/widgets/subscription_item.dart';
import 'package:pouch/common/styles/spacing_styles.dart';
import 'package:pouch/utils/constants/sizes.dart';
import 'package:pouch/utils/layouts/list_layout.dart';

class SubscriptionList extends StatelessWidget {
  const SubscriptionList({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<SubscriptionProvider>(context);

    return SizedBox(
      child: provider.subscriptions.isEmpty
          ? const NoSubscriptionScreen()
          : Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: TSizes.defaultSpace,),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: TSizes.defaultSpace * 0.8),
            child: RichText(
              text: TextSpan(
                style: Theme.of(context).textTheme.labelMedium,
                children: const <TextSpan>[
                  TextSpan(
                    text: 'Here are the list of offers you have subscribed to:',
                    style: TextStyle(fontSize: 15),
                  )
                ],
              ),
            ),
          ),
          const SizedBox(height: TSizes.defaultSpace,),
          TListLayout(
            itemCount: provider.subscriptions.length,
            itemBuilder: (_, index) {
              final item = provider.subscriptions[index];
              
              return SubscriptionItem(item: item);
            },
          ),
        ],
      ),
    );
  }
}

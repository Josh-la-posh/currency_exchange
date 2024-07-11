import 'package:flutter/material.dart';
import 'package:pouch/utils/helpers/helper_functions.dart';
import 'package:provider/provider.dart';
import 'package:pouch/data/provider/subscription_provider.dart';
import 'package:pouch/features/subscription/widgets/no_subscription.dart';
import 'package:pouch/features/subscription/widgets/subscription_item.dart';
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
                RichText(
                    text: TextSpan(
                        style: Theme.of(context).textTheme.titleLarge,
                        children: const <TextSpan> [
                          TextSpan(
                              text: 'Subscribe',
                              style: TextStyle(
                                  fontSize: TSizes.fontSize22
                              )
                          )
                        ]
                    )
                ),
                const SizedBox(height: TSizes.defaultSpace,),
                Container(
                  width: THelperFunctions.screenWidth() * 0.68,
                  child: RichText(
                      text: TextSpan(
                          style: Theme.of(context).textTheme.labelMedium,
                          children: const <TextSpan> [
                            TextSpan(
                                text: 'Here are the list of offers you have subscribed to:',
                                style: TextStyle(
                                    fontSize: 15
                                )
                            )
                          ]
                      )
                  ),
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

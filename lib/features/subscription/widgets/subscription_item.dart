import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';
import 'package:swappr/data/provider/subscription_provider.dart';
import 'package:swappr/features/subscription/apis/api.dart';
import 'package:swappr/features/subscription/models/subscribeEnity.dart';
import '../../../common/widgets/divider.dart';
import '../../../utils/constants/colors.dart';
import '../../../utils/constants/sizes.dart';

class SubscriptionItem extends StatelessWidget {
  final SubscriptionEntity item;
  SubscriptionItem({
    required this.item,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<SubscriptionProvider>(context);
    return Column(
      children: [
        SizedBox(
          height: TSizes.textReviewHeight * 1.2,
          child: Slidable(
            key: const ValueKey(0),
            endActionPane: ActionPane(
                extentRatio: 0.2,
                motion: const ScrollMotion(),
                // dismissible: DismissiblePane(onDismissed: (){}),
                children: [
                  SlidableAction(
                    onPressed: ((context){
                      SubscriptionService.instance.deleteSubscription(id: item.id, subscriptionProvider: provider);
                    }),
                    backgroundColor: TColors.danger,
                    icon: Icons.delete,
                    // label: 'Delete',

                  ),
                ]
            ),
            child: ListTile(
              dense: true,
              contentPadding: const EdgeInsets.only(left: 0, top: 0, bottom: 0, right: 10),
              title: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      RichText(
                          text: TextSpan(
                              style: Theme.of(context).textTheme.labelMedium,
                              children: <TextSpan> [
                                TextSpan(
                                    text: 'has: ${item.currency}',
                                    style: TextStyle(fontSize: TSizes.fontSize13)
                                ),
                              ]
                          )
                      ),
                      RichText(
                          text: TextSpan(
                              style: Theme.of(context).textTheme.labelMedium,
                              children: <TextSpan> [
                                TextSpan(
                                    text: '${item.minRate} - ${item.maxRate} ${item.currency} // ${item.currency}',
                                    style: TextStyle(fontSize: TSizes.fontSize13, color: TColors.primary)
                                ),
                              ]
                          )
                      ),
                    ],
                  ),
                  const SizedBox(height: TSizes.sm,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [

                      RichText(
                          text: TextSpan(
                              style: Theme.of(context).textTheme.labelMedium,
                              children: <TextSpan> [
                                TextSpan(
                                    text: 'needs: ${item.currency}',
                                    style: TextStyle(fontSize: TSizes.fontSize13)
                                ),
                              ]
                          )
                      ),
                      RichText(
                          text: TextSpan(
                              style: Theme.of(context).textTheme.labelSmall,
                              children: <TextSpan> [
                                TextSpan(
                                    text: 'June 20',
                                    style: TextStyle(color: TColors.textPrimary.withOpacity(0.5))
                                ),
                              ]
                          )
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
        const SizedBox(height: 10,),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: TSizes.defaultSpace),
          child: DividerWidget(),
        )
      ],
    );
  }
}

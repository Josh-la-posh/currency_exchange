import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import '../../../common/widgets/divider.dart';
import '../../../utils/constants/colors.dart';
import '../../../utils/constants/sizes.dart';

class SubscriptionItem extends StatelessWidget {
  const SubscriptionItem({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
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
                      print('I am working');
                    }),
                    backgroundColor: TColors.danger,
                    icon: Icons.delete,
                    // label: 'Delete',

                  ),
                ]
            ),
            child: ListTile(
              dense: true,
              contentPadding: const EdgeInsets.all(0),
              title: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      RichText(
                          text: TextSpan(
                              style: Theme.of(context).textTheme.labelMedium,
                              children: const <TextSpan> [
                                TextSpan(
                                    text: 'has: NGN',
                                    style: TextStyle(fontSize: TSizes.fontSize13)
                                ),
                              ]
                          )
                      ),
                      RichText(
                          text: TextSpan(
                              style: Theme.of(context).textTheme.labelMedium,
                              children: const <TextSpan> [
                                TextSpan(
                                    text: '600 NGN // GBP',
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
                              children: const <TextSpan> [
                                TextSpan(
                                    text: 'needs: GBP',
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

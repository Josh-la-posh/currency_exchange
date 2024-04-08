import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:swappr/common/widgets/buttons/floating_button.dart';
import 'package:swappr/features/dashboard/screens/subscribe/widgets/add_subscription.dart';
import 'package:swappr/features/dashboard/screens/subscribe/widgets/no_subscription.dart';
import 'package:swappr/features/dashboard/screens/subscribe/widgets/subscription_list.dart';
import 'package:swappr/utils/constants/colors.dart';

import '../../../../common/styles/spacing_styles.dart';
import '../../../../utils/constants/sizes.dart';
import '../../../../utils/layouts/list_layout.dart';

class SubscribeScreen extends StatefulWidget {
  const SubscribeScreen({super.key});


  @override
  State<SubscribeScreen> createState() => _SubscribeScreenState();
}

class _SubscribeScreenState extends State<SubscribeScreen> {

  final int subscriptionList = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: TSpacingStyle.dashboardPadding,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Subscribe', style: Theme.of(context).textTheme.titleMedium,),
                  const SizedBox(height: TSizes.xs,),
                  Text('Here are the list of offers you have subscribed to:', style: Theme.of(context).textTheme.labelMedium,),
                ],
              ),
            ),

            if (subscriptionList == 0)
            const NoSubscriptionScreen(),
            // AddSubscription()
            if (subscriptionList > 0)
            Column(
              children: [
                TListLayout(
                    itemCount: 5,
                    itemBuilder: (_, index) => const SubscriptionList()
                )

              ],
            ),
          ],
        ),
      ),
      floatingActionButton: TFloatingButton(
        onPressed: (){Get.to(() => const AddSubscriptionScreen());},
      ),
    );
  }
}



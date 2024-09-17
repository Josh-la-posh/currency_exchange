import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pouch/common/widgets/buttons/floating_button.dart';
import 'package:pouch/features/subscription/controller/subscription_controller.dart';
import 'package:pouch/features/subscription/screens/add_subscription.dart';
import '../../../utils/constants/colors.dart';
import '../../../utils/constants/sizes.dart';
import '../../../utils/helpers/helper_functions.dart';
import '../../../utils/layouts/list_layout.dart';
import '../widgets/no_subscription.dart';
import '../widgets/subscription_item.dart';

class SubscribeScreen extends StatelessWidget {
  final controller = Get.put(SubscriptionController());
  SubscribeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final darkMode = THelperFunctions.isDarkMode(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: darkMode ? TColors.textPrimaryO40 : Colors.white,
        shadowColor: darkMode ? TColors.textPrimaryO40 : Colors.white,
        title: Text('Subscribe', style: Theme.of(context).textTheme.titleMedium),
        centerTitle: true,
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return CircularProgressIndicator();
        }
        if (controller.subscriptions.isEmpty) {
          return NoSubscriptionScreen();
        }
        return Column(
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
              itemCount: controller.subscriptions.length,
              itemBuilder: (_, index) {
                final item = controller.subscriptions[index];

                return SubscriptionItem(item: item);
              },
            ),
          ],
        );
      }),
      floatingActionButton: TFloatingButton(
        onPressed: () {
          Get.to(() => AddSubscriptionScreen());
        },
      ),
    );
  }
}

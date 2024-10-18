import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pouch/common/widgets/buttons/floating_button.dart';
import 'package:pouch/features/subscription/controller/subscription_controller.dart';
import 'package:pouch/features/subscription/screens/add_subscription.dart';
import 'package:pouch/utils/shared/refresh_indicator/refresh_indicator.dart';
import '../../../data/modules/interceptor.dart';
import '../../../utils/constants/colors.dart';
import '../../../utils/constants/sizes.dart';
import '../../../utils/helpers/helper_functions.dart';
import '../../../utils/layouts/list_layout.dart';
import '../widgets/no_subscription.dart';
import '../widgets/subscription_item.dart';

class SubscribeScreen extends StatelessWidget {
  final AppInterceptor appInterceptor = AppInterceptor();

  @override
  Widget build(BuildContext context) {
    SubscriptionController controller = Get.put(SubscriptionController());
    final darkMode = THelperFunctions.isDarkMode(context);

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            appInterceptor.cancelOngoingRequest(() {
              controller.resetBoolOnOutgoingRequests();
            });
            Get.back();
          },
          icon: const Icon(Icons.arrow_back),
          style: IconButton.styleFrom(
            foregroundColor: Colors.grey,
            iconSize: TSizes.iconBackSize,
          ),
          hoverColor: Colors.transparent,
        ),
        backgroundColor: darkMode ? TColors.textPrimaryO40 : Colors.white,
        shadowColor: darkMode ? TColors.textPrimaryO40 : Colors.white,
        title: Text('Subscribe', style: Theme.of(context).textTheme.titleMedium),
        centerTitle: true,
      ),
      body: Obx(() {
        if (controller.isFetchingSubscription.value) {
          return Center(child: CircularProgressIndicator());
        } else {
          return CustomRefreshIndicator(
            onRefresh: () => controller.fetchSubscription(currency: ''),
            child: Container(
              height: THelperFunctions.screenHeight(),
              child: SingleChildScrollView(
                physics: AlwaysScrollableScrollPhysics(),
                child: Column(
                  children: [
                    controller.subscriptions.isEmpty
                        ? NoSubscriptionScreen()
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
                          itemCount: controller.subscriptions.length,
                          itemBuilder: (_, index) {
                            final item = controller.subscriptions[index];

                            return SubscriptionItem(item: item);
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            )
          );
        }
      }),
      floatingActionButton: TFloatingButton(
        onPressed: () {
          Get.to(() => AddSubscriptionScreen());
        },
      ),
    );
  }
}

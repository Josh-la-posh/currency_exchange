import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pouch/common/widgets/buttons/floating_button.dart';
import 'package:pouch/features/instant_swap/controller/instant_swap_controller.dart';
import 'package:pouch/features/instant_swap/widget/empty_autoswap_screen.dart';
import 'package:pouch/features/instant_swap/widget/autoswap_item.dart';
import 'package:pouch/features/subscription/screens/add_subscription.dart';
import 'package:pouch/utils/shared/refresh_indicator/refresh_indicator.dart';
import '../../../data/modules/interceptor.dart';
import '../../../utils/constants/colors.dart';
import '../../../utils/constants/sizes.dart';
import '../../../utils/helpers/helper_functions.dart';
import '../../../utils/layouts/list_layout.dart';
import 'add_new_autoswap.dart';

class InstantSwapScreen extends StatelessWidget {
  final AppInterceptor appInterceptor = AppInterceptor();

  @override
  Widget build(BuildContext context) {
    final SwapController controller = Get.put(SwapController());
    final darkMode = THelperFunctions.isDarkMode(context);

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
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
        title: Text('Auto Swap', style: Theme.of(context).textTheme.titleMedium),
        centerTitle: true,
      ),
      body: Obx(() {
        if (controller.isFetchingAutoData.value) {
          return Center(child: CircularProgressIndicator());
        } else {
          return CustomRefreshIndicator(
              onRefresh: () => controller.fetchAutoswapData(),
              child: Container(
                height: THelperFunctions.screenHeight(),
                child: SingleChildScrollView(
                  physics: AlwaysScrollableScrollPhysics(),
                  child: Column(
                    children: [
                      controller.autoSwaps.isNotEmpty
                          ? EmptyAutoswapScreen()
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
                                    text: 'Here are the list of auto swaps you created:',
                                    style: TextStyle(fontSize: 15),
                                  )
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(height: TSizes.defaultSpace,),
                          TListLayout(
                            // itemCount: controller.autoSwaps.length,
                            itemCount: 5,
                            itemBuilder: (_, index) {
                              // final item = controller.autoSwaps[index];

                              return AutoSwapItem();
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
          Get.to(() => AddNewAutoSwap());
        },
      ),
    );
  }
}

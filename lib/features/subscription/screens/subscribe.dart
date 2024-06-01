import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:provider/provider.dart';
import 'package:swappr/data/provider/subscription_provider.dart';
import 'package:swappr/features/subscription/apis/api.dart';
import 'package:swappr/features/subscription/screens/add_subscription.dart';
import 'package:swappr/features/subscription/screens/layout.dart';
import 'package:swappr/features/subscription/widgets/subscription_list.dart';
import 'package:swappr/utils/constants/sizes.dart';
import '../../../common/styles/spacing_styles.dart';
import '../../../common/widgets/buttons/floating_button.dart';
import '../../../common/widgets/currencyWidget.dart';
import '../../../data/modules/app_navigator.dart';

class SubscribeScreen extends StatefulWidget {
  const SubscribeScreen({super.key});

  @override
  State<SubscribeScreen> createState() => _SubscribeScreenState();
}

class _SubscribeScreenState extends State<SubscribeScreen> {
  SubscriptionProvider provider = Provider.of<SubscriptionProvider>(
      AppNavigator.instance.navigatorKey.currentContext as BuildContext,
      listen: false
  );

  @override
  void initState() {
    if (provider.subscriptions.isEmpty) {
      SubscriptionService.instance.getSubscriptions(
          provider: provider, currency: '');
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return SubscribeScreenLayout(
      childWidget:const SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(top: 20),
          child: Column(
            children: [
              Column(
                children: [
                  SubscriptionList(),
                ],
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: TFloatingButton(
        onPressed: (){Get.to(() => const AddSubscriptionScreen());},
      ),

    );
  }
}


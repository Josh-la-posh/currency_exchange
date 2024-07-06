import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:provider/provider.dart';
import 'package:swappr/common/styles/spacing_styles.dart';
import 'package:swappr/common/widgets/custom_shapes/currency_widget_with_back.dart';
import 'package:swappr/data/provider/subscription_provider.dart';
import 'package:swappr/features/subscription/apis/api.dart';
import 'package:swappr/features/subscription/screens/add_subscription.dart';
import 'package:swappr/features/subscription/widgets/subscription_list.dart';
import '../../../common/widgets/buttons/floating_button.dart';
import '../../../common/widgets/currencyWidget.dart';
import '../../../common/widgets/verify_your_account.dart';
import '../../../data/modules/app_navigator.dart';
import '../../../data/provider/auth_provider.dart';
import '../../../data/provider/verification_provider.dart';
import '../../../utils/helpers/helper_functions.dart';

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
  AuthProvider authProvider = Provider.of<AuthProvider>(
      AppNavigator.instance.navigatorKey.currentContext as BuildContext,
      listen: false
  );
  VerificationProvider verifyProvider = Provider.of<VerificationProvider>(
      AppNavigator.instance.navigatorKey.currentContext as BuildContext,
      listen: false
  );

  @override
  void initState() {
    if (provider.subscriptions.isEmpty) {
      SubscriptionService.instance.getSubscriptions(
          provider: provider, currency: '');
    }
    if (authProvider.user?.isVerified == false) {
      setState(() {
        verifyProvider.showVerifyModal = true;
      });
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final darkMode = THelperFunctions.isDarkMode(context);
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: TSpacingStyle.homePadding,
          child: Column(
            children: [
              CurrencyWidgetWithBack(),
              verifyProvider.showVerifyModal == true
                  ? VerifyYourAccountWidget(
                darkMode: darkMode,
                onTap: () {
                  setState(() {
                    verifyProvider.showVerifyModal = !verifyProvider.showVerifyModal;
                  });
                },
              )
                  : SizedBox(height: 0),
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


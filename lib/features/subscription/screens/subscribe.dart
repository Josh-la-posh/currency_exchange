import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pouch/data/modules/background_task.dart';
import 'package:provider/provider.dart';
import 'package:pouch/common/widgets/buttons/floating_button.dart';
import 'package:pouch/features/subscription/apis/api.dart';
import 'package:pouch/features/subscription/screens/add_subscription.dart';
import 'package:pouch/features/subscription/widgets/subscription_list.dart';
import '../../../data/modules/app_navigator.dart';
import '../../../data/provider/auth_provider.dart';
import '../../../data/provider/subscription_provider.dart';
import '../../../data/provider/verification_provider.dart';
import '../../../utils/constants/colors.dart';
import '../../../utils/helpers/helper_functions.dart';
import '../widgets/no_subscription.dart';

class SubscribeScreen extends StatefulWidget {
  const SubscribeScreen({super.key});

  @override
  State<SubscribeScreen> createState() => _SubscribeScreenState();
}

class _SubscribeScreenState extends State<SubscribeScreen> {
  late SubscriptionProvider subscriptionProvider;
  late AuthProvider authProvider;
  late VerificationProvider verificationProvider;

  @override
  void initState() {
    super.initState();
    subscriptionProvider = Provider.of<SubscriptionProvider>(
        AppNavigator.instance.navigatorKey.currentContext as BuildContext,
        listen: false
    );
    authProvider = Provider.of<AuthProvider>(
        AppNavigator.instance.navigatorKey.currentContext as BuildContext,
        listen: false
    );
    verificationProvider = Provider.of<VerificationProvider>(
        AppNavigator.instance.navigatorKey.currentContext as BuildContext,
        listen: false
    );
    NoLoaderService.instance.getSubscriptions(
        provider: subscriptionProvider,
        currency: ''
    );
    print('The value is not working ${subscriptionProvider.subscriptions.length}');

    if (subscriptionProvider.subscriptions.isEmpty) {
      SubscriptionService.instance.getSubscriptions(
          provider: subscriptionProvider,
          currency: ''
      );
    }
    if (authProvider.user?.isVerified == false) {
      setState(() {
        verificationProvider.showVerifyModal = true;
      });
    }
  }

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
      body: SingleChildScrollView(
        child: subscriptionProvider.subscriptions.isEmpty
            ? const NoSubscriptionScreen()
            : SubscriptionList(),
      ),
      floatingActionButton: TFloatingButton(
        onPressed: () {
          Get.to(() => const AddSubscriptionScreen());
        },
      ),
    );
  }
}

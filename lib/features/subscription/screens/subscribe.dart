import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:swappr/features/subscription/screens/add_subscription.dart';
import 'package:swappr/features/subscription/screens/layout.dart';
import 'package:swappr/features/subscription/widgets/subscription_list.dart';
import '../../../common/widgets/buttons/floating_button.dart';
import '../../../common/widgets/currencyWidget.dart';

class SubscribeScreen extends StatefulWidget {
  const SubscribeScreen({super.key});

  @override
  State<SubscribeScreen> createState() => _SubscribeScreenState();
}

class _SubscribeScreenState extends State<SubscribeScreen> {
  // @override
  // void initState() {
  //   super.initState();
  //   Future.microtask(() => Provider.of<OfferProvider>(context, listen: false).fetchOffers());
  // }

  @override
  Widget build(BuildContext context) {

    return SubscribeScreenLayout(
      childWidget:const SingleChildScrollView(
        child: Column(
          children: [
            CurrencyWidget(),
            Column(
              children: [
                SubscriptionList(),
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


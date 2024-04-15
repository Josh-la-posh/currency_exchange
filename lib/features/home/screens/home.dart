import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:swappr/features/home/screens/create_offer.dart';
import 'package:swappr/features/home/widgets/layout.dart';
import '../../../common/widgets/buttons/floating_button.dart';
import '../../../common/widgets/currencyWidget.dart';
import '../widgets/offer_list.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // @override
  // void initState() {
  //   super.initState();
  //   Future.microtask(() => Provider.of<OfferProvider>(context, listen: false).fetchOffers());
  // }

  @override
  Widget build(BuildContext context) {

    return DashboardScreenLayout(
      childWidget:const SingleChildScrollView(
        child: Column(
            children: [
              CurrencyWidget(),
              Column(
                children: [
                  OfferList(),
                ],
              ),
            ],
          ),
      ),
      floatingActionButton: TFloatingButton(
        onPressed: (){Get.to(() => const CreateOfferScreen());},
      ),

    );
  }
}


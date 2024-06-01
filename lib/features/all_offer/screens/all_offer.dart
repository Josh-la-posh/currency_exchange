import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:provider/provider.dart';
import 'package:swappr/data/modules/app_navigator.dart';
import 'package:swappr/utils/constants/enums.dart';
import '../../../common/widgets/buttons/floating_button.dart';
import '../../../common/widgets/currencyWidget.dart';
import '../../../data/provider/offer_provider.dart';
import '../apis/api.dart';
import '../widgets/layout.dart';
import '../widgets/offer_list.dart';
import 'create_offer.dart';

class AllOfferScreen extends StatefulWidget {
  const AllOfferScreen({super.key});

  @override
  State<AllOfferScreen> createState() => _AllOfferScreenState();
}

class _AllOfferScreenState extends State<AllOfferScreen> {
  OfferProvider offerProvider = Provider.of<OfferProvider>(
    AppNavigator.instance.navigatorKey.currentContext as BuildContext,
    listen: false
  );


  @override
  void initState() {
    if (offerProvider.offers.isEmpty) {
      OfferService.instance.getAllOffers(
          offerProvider: offerProvider,
          currency: '',
          date: ''
      );
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return AllOfferScreenLayout(
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
        onPressed: (){
          offerProvider.updateDebitedCurrency(Currency.Select);
          offerProvider.updateCreditedCurrency(Currency.Select);
          offerProvider.updateAmount('0');
          offerProvider.updateRate('0');
          Get.to(() => const CreateOfferScreen());
          },
      ),

    );
  }
}


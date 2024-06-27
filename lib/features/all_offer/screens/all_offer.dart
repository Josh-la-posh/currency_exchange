import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:provider/provider.dart';
import 'package:swappr/data/modules/app_navigator.dart';
import 'package:swappr/utils/constants/enums.dart';
import 'package:swappr/utils/helpers/helper_functions.dart';
import 'package:swappr/utils/shared/notification/snackbar.dart';
import '../../../common/widgets/buttons/floating_button.dart';
import '../../../common/widgets/currencyWidget.dart';
import '../../../common/widgets/verify_your_account.dart';
import '../../../data/provider/auth_provider.dart';
import '../../../data/provider/offer_provider.dart';
import '../../../data/provider/verification_provider.dart';
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
    if (offerProvider.offers.isEmpty) {
      OfferService.instance.getAllOffers(
          offerProvider: offerProvider,
          currency: '',
          date: ''
      );
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
    return AllOfferScreenLayout(
      childWidget: SingleChildScrollView(
        child: Column(
            children: [
              CurrencyWidget(),
              verifyProvider.showVerifyModal == true
                  ? VerifyYourAccountWidget(
                darkMode: darkMode,
                onTap: () {
                  setState(() {
                    verifyProvider.showVerifyModal = !verifyProvider.showVerifyModal;
                  });
                },
              )
                  : SizedBox(height: 10),
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
          if (authProvider.user?.isVerified == true) {
            handleShowCustomToast(message: "Please verify your account");
          } else {
            offerProvider.updateDebitedCurrency(Currency.NGN);
            offerProvider.updateCreditedCurrency(Currency.NGN);
            offerProvider.updateAmount('0');
            offerProvider.updateRate('0');
            Get.to(() => const CreateOfferScreen());
          }
          },
      ),

    );
  }
}


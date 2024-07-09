import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import '../../../common/widgets/custom_shapes/currency_widget_with_back.dart';
import '../../../data/modules/app_navigator.dart';
import '../../../data/provider/offer_provider.dart';
import '../../../utils/constants/colors.dart';
import '../../../utils/helpers/helper_functions.dart';
import '../../all_offer/apis/api.dart';
import '../widget/negotiation_list.dart';

class NegotiationOfferScreen extends StatefulWidget {
  const NegotiationOfferScreen({super.key});

  @override
  State<NegotiationOfferScreen> createState() => _NegotiationOfferScreenState();
}

class _NegotiationOfferScreenState extends State<NegotiationOfferScreen> {
  OfferProvider offerProvider = Provider.of<OfferProvider>(
      AppNavigator.instance.navigatorKey.currentContext as BuildContext,
      listen: false
  );

  @override
  void initState() {
    if (offerProvider.negotiationsOffers.isEmpty) {
      OfferService.instance.getAllNegotiatedOOffers(
          offerProvider: offerProvider,
      );
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final darkMode = THelperFunctions.isDarkMode(context);
    print(offerProvider.negotiationsOffers.length);
    return Scaffold(
      backgroundColor: darkMode ? TColors.black.withOpacity(0.8) : TColors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            CurrencyWidgetWithBack(),
            NegotiationList(darkMode: darkMode),
          ],
        ),
      ),
    );
  }
}


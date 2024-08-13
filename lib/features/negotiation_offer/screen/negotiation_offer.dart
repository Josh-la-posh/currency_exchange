import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:pouch/common/widgets/currencyWidget.dart';
import 'package:pouch/data/modules/background_task.dart';
import 'package:pouch/utils/shared/refresh_indicator/refresh_indicator.dart';
import 'package:provider/provider.dart';
import '../../../common/widgets/custom_shapes/currency_widget_with_back.dart';
import '../../../data/modules/app_navigator.dart';
import '../../../data/provider/offer_provider.dart';
import '../../../utils/constants/colors.dart';
import '../../../utils/constants/sizes.dart';
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
    _fetchNegotiations();
    super.initState();
  }

  Future<void> _fetchNegotiations() async {
    NoLoaderService.instance.getAllNegotiatedOOffers(
      offerProvider: offerProvider,
    );
  }

  Future<void> _refreshOffers() async {
    await _fetchNegotiations();
    await Future.delayed(const Duration(seconds: 2));
  }

  @override
  Widget build(BuildContext context) {
    final darkMode = THelperFunctions.isDarkMode(context);
    return SafeArea(
      child: Scaffold(
        // backgroundColor: darkMode ? TColors.black.withOpacity(0.8) : TColors.white,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
          centerTitle: true,
          title: RichText(
              text: TextSpan(
                  style: Theme.of(context).textTheme.labelSmall,
                  children: const <TextSpan> [
                    TextSpan(
                        text: 'Offers Review',
                        style: TextStyle(fontSize: TSizes.fontSize16, fontWeight: TSizes.fontWeightMd)
                    )
                  ]
              )
          ),
        ),
        body: Container(
          height: THelperFunctions.screenHeight() - TSizes.appBarHeight,
          child: CustomRefreshIndicator(
              onRefresh: _refreshOffers,
              child: SingleChildScrollView(
                  physics: AlwaysScrollableScrollPhysics(),
                  child: NegotiationList(darkMode: darkMode))
          ),
        ),
      ),
    );
  }
}


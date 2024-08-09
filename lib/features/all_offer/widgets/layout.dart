import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pouch/common/styles/spacing_styles.dart';
import 'package:pouch/data/provider/offer_provider.dart';
import 'package:pouch/features/all_offer/apis/api.dart';
import 'package:pouch/utils/constants/colors.dart';
import 'package:pouch/utils/helpers/helper_functions.dart';
import 'package:pouch/utils/layouts/app_layout.dart';
import 'package:pouch/utils/shared/refresh_indicator/refresh_indicator.dart';

import '../../../data/modules/app_navigator.dart';

class AllOfferScreenLayout extends StatelessWidget {
  final Widget childWidget;
  final Widget floatingActionButton;
  const AllOfferScreenLayout({
    super.key,
    required this.childWidget,
    required this.floatingActionButton
  });

  @override
  Widget build(BuildContext context) {
    var offerProvider = Provider.of<OfferProvider>(
        AppNavigator.instance.navigatorKey.currentContext as BuildContext);
    final darkMode = THelperFunctions.isDarkMode(context);
    return AppLayout(
      currentRoute: RouteType.Home,
      layoutBodyColor: darkMode ? TColors.black.withOpacity(0.8) : TColors.white,
      childWidget: Container(
        padding: TSpacingStyle.homePadding,
        child: CustomRefreshIndicator(
          onRefresh: () async {
            OfferService.instance.getAllOffers(offerProvider: offerProvider, currency: '', date: '');
          },
          child: childWidget,

        ),
      ),
      floatingActionButton: floatingActionButton,
    );
  }
}

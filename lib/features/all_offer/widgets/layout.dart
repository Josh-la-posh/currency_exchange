import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:swappr/common/styles/spacing_styles.dart';
import 'package:swappr/data/provider/offer_provider.dart';
import 'package:swappr/features/all_offer/apis/api.dart';
import 'package:swappr/utils/constants/colors.dart';
import 'package:swappr/utils/helpers/helper_functions.dart';
import 'package:swappr/utils/layouts/app_layout.dart';
import 'package:swappr/utils/shared/refresh_indicator/refresh_indicator.dart';

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
          childWidget: childWidget,

        ),
      ),
      floatingActionButton: floatingActionButton,
    );
  }
}

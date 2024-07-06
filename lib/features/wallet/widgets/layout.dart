import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:swappr/common/styles/spacing_styles.dart';
import 'package:swappr/data/provider/wallet_provider.dart';
import 'package:swappr/features/wallet/apis/api.dart';
import 'package:swappr/utils/layouts/app_layout.dart';

import '../../../data/modules/app_navigator.dart';
import '../../../data/provider/transaction_provider.dart';
import '../../../utils/constants/colors.dart';
import '../../../utils/helpers/helper_functions.dart';
import '../../../utils/shared/refresh_indicator/refresh_indicator.dart';

class WalletScreenLayout extends StatelessWidget {
  final Widget childWidget;
  const WalletScreenLayout({
    super.key,
    required this.childWidget,
  });

  @override
  Widget build(BuildContext context) {
    final darkMode = THelperFunctions.isDarkMode(context);
    var walletProvider = Provider.of<WalletProvider>(
        AppNavigator.instance.navigatorKey.currentContext as BuildContext);
    var transactionProvider = Provider.of<TransactionProvider>(
        AppNavigator.instance.navigatorKey.currentContext as BuildContext);
    return AppLayout(
      currentRoute: RouteType.Wallet,
      layoutBodyColor: darkMode ? TColors.black.withOpacity(0.8) : TColors.white,
      // childWidget: Container(
      //   child: childWidget,
      // ),
      childWidget: Container(
        padding: TSpacingStyle.paddingWithAppBarHeight,
        child: CustomRefreshIndicator(
          onRefresh: () async {
            WalletServices.instance.getWallets(transactionProvider: transactionProvider, walletProvider: walletProvider, currency: '');
          },
          childWidget: childWidget,

        ),
      ),
    );
  }
}

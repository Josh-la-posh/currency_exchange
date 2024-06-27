import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:swappr/common/styles/spacing_styles.dart';
import 'package:swappr/data/provider/transaction_provider.dart';
import 'package:swappr/features/transaction/apis/api.dart';
import 'package:swappr/utils/constants/sizes.dart';
import 'package:swappr/utils/layouts/app_layout.dart';

import '../../../data/modules/app_navigator.dart';
import '../../../utils/constants/colors.dart';
import '../../../utils/helpers/helper_functions.dart';
import '../../../utils/shared/refresh_indicator/refresh_indicator.dart';

class TransactionScreenLayout extends StatelessWidget {
  final Widget childWidget;
  const TransactionScreenLayout({
    super.key,
    required this.childWidget
  });

  @override
  Widget build(BuildContext context) {
    final darkMode = THelperFunctions.isDarkMode(context);
    var transactionProvider = Provider.of<TransactionProvider>(
        AppNavigator.instance.navigatorKey.currentContext as BuildContext);
    return AppLayout(
      currentRoute: RouteType.History,
      layoutBodyColor: darkMode ? TColors.black.withOpacity(0.8) : TColors.white,
      childWidget: Container(
        padding: TSpacingStyle.paddingWithAppBarHeight,
        child: CustomRefreshIndicator(
          onRefresh: () async {
            TransactionService.instance.getTransactions(transactionProvider: transactionProvider);
          },
          childWidget: childWidget,

        ),
      ),
    );
  }
}

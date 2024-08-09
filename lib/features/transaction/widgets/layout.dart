import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pouch/common/styles/spacing_styles.dart';
import 'package:pouch/data/provider/transaction_provider.dart';
import 'package:pouch/features/transaction/apis/api.dart';
import 'package:pouch/utils/constants/sizes.dart';
import 'package:pouch/utils/layouts/app_layout.dart';

import '../../../data/modules/app_navigator.dart';
import '../../../data/modules/background_task.dart';
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
      appbar: AppBar(
        titleSpacing: 30,
        automaticallyImplyLeading: false,
        title:
        RichText(
            text: TextSpan(
                style: Theme.of(context).textTheme.titleLarge,
                children: <TextSpan> [
                  TextSpan(
                      text: 'Transaction History',
                      style: TextStyle(
                          fontSize: TSizes.fontSize20,
                      )
                  )
                ]
            )
        ),
        leading: null,
        // centerTitle: true,
        actions: [
          IconButton(
            onPressed: (){NoLoaderService.instance.getTransactions(transactionProvider: transactionProvider);},
            icon: Icon(Icons.refresh, size: 20, color: darkMode ? Colors.white : TColors.primary,),
          )
        ],
      ),
      currentRoute: RouteType.History,
      layoutBodyColor: darkMode ? TColors.black.withOpacity(0.8) : TColors.white,
      childWidget: Container(
        padding: TSpacingStyle.paddingWithAppBarHeight,
        child: CustomRefreshIndicator(
          onRefresh: () async {
            TransactionService.instance.getTransactions(transactionProvider: transactionProvider);
          },
          child: childWidget,

        ),
      ),
    );
  }
}

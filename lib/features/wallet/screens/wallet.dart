import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:swappr/data/provider/transaction_provider.dart';
import 'package:swappr/features/transaction/apis/api.dart';
import 'package:swappr/features/wallet/widgets/layout.dart';
import 'package:swappr/features/wallet/widgets/wallet_dashboard.dart';
import 'package:swappr/features/wallet/widgets/wallet_list.dart';
import 'package:swappr/utils/helpers/helper_functions.dart';
import '../../../data/modules/app_navigator.dart';
import '../../../data/provider/auth_provider.dart';
import '../../../data/provider/wallet_provider.dart';
import '../apis/api.dart';
import '../widgets/wallet_transaction.dart';

class WalletDashboardScreen extends StatefulWidget {
  const WalletDashboardScreen({super.key});

  @override
  State<WalletDashboardScreen> createState() => _WalletDashboardScreenState();
}

class _WalletDashboardScreenState extends State<WalletDashboardScreen> {


  WalletProvider walletProvider = Provider.of<WalletProvider>(
      AppNavigator.instance.navigatorKey.currentContext as BuildContext,
      listen: false
  );

  AuthProvider authProvider = Provider.of<AuthProvider>(
      AppNavigator.instance.navigatorKey.currentContext as BuildContext,
      listen: false
  );

  TransactionProvider transProvider = Provider.of<TransactionProvider>(
      AppNavigator.instance.navigatorKey.currentContext as BuildContext,
      listen: false
  );

  @override
  void initState() {
    if (walletProvider.wallets.isEmpty) {
      WalletServices.instance.getWallets(
          transactionProvider: transProvider,
          walletProvider: walletProvider,
          currency: ''
      );
    }
    print(walletProvider.showWalletLists);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final darkMode = THelperFunctions.isDarkMode(context);
    return WalletScreenLayout(
        childWidget: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              WalletDashboard(darkMode: darkMode),
              WalletList(darkMode: darkMode),
              if (transProvider.transactions.length > 0)
                WalletTransactionHistory(darkMode: darkMode)
            ],
          ),
        )
    );
  }
}

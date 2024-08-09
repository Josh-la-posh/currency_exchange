import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pouch/features/wallet/widgets/account_list.dart';
import 'package:pouch/utils/shared/refresh_indicator/refresh_indicator.dart';
import 'package:provider/provider.dart';
import 'package:pouch/data/modules/background_task.dart';
import 'package:pouch/data/provider/transaction_provider.dart';
import 'package:pouch/data/provider/wallet_provider.dart';
import 'package:pouch/features/wallet/widgets/wallet_dashboard.dart';
import 'package:pouch/features/wallet/widgets/wallet_list.dart';
import 'package:pouch/utils/helpers/helper_functions.dart';
import '../../../data/modules/app_navigator.dart';
import '../../../utils/constants/sizes.dart';
import '../../payment_method/screens/payment_options.dart';
import '../../withdrawals/screens/withdrawal.dart';

class WalletDashboardScreen extends StatefulWidget {
  const WalletDashboardScreen({super.key});

  @override
  State<WalletDashboardScreen> createState() => _WalletDashboardScreenState();
}

class _WalletDashboardScreenState extends State<WalletDashboardScreen> {
  late final WalletProvider _walletProvider;
  late final TransactionProvider _transactionProvider;

  @override
  void initState() {
    super.initState();
    _walletProvider = Provider.of<WalletProvider>(
      AppNavigator.instance.navigatorKey.currentContext as BuildContext,
      listen: false,
    );
    _transactionProvider = Provider.of<TransactionProvider>(
      AppNavigator.instance.navigatorKey.currentContext as BuildContext,
      listen: false,
    );

    _initializeData();
  }

  void _initializeData() {
    if (_walletProvider.wallets.isEmpty) {
      NoLoaderService.instance.getWallets(
        transactionProvider: _transactionProvider,
        walletProvider: _walletProvider,
        currency: '',
      );
    }
  }

  Future<void> _refreshAssets() async {
    await NoLoaderService.instance.getDefaultWallet(
      walletProvider: _walletProvider,
      transactionProvider: _transactionProvider,
    );
    await Future.delayed(const Duration(seconds: 2));
  }

  @override
  Widget build(BuildContext context) {
    final bool darkMode = THelperFunctions.isDarkMode(context);
    final bool isDarkMode = darkMode; // Alias for clarity
    final backgroundColor = isDarkMode ? Color(0xFF1E1E1E) : Colors.grey[200];
    final borderColor = isDarkMode ? Color(0xFF2E2E2E).withOpacity(0.1) : Colors.grey[400]?.withOpacity(0.1);

    return Scaffold(
      backgroundColor: backgroundColor,
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: TSizes.defaultSpace * 0.8),
        height: THelperFunctions.screenHeight() - kBottomNavigationBarHeight,
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(color: borderColor!),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHeader(context),
            Expanded(
              child: CustomRefreshIndicator(
                onRefresh: _refreshAssets,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      WalletDashboard(darkMode: isDarkMode),
                      SizedBox(height: 15),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          _buildActionContainer(
                            context,
                            Icons.payments_outlined,
                            'Deposit',
                                () => Get.to(() => const PaymentOptionScreen()),
                          ),
                          _buildActionContainer(
                            context,
                            Icons.add_card,
                            'Withdraw',
                                () => Get.to(() => const WithdrawalScreen()),
                          ),
                          _buildActionContainer(
                            context,
                            Icons.add_card_outlined,
                            'Add Wallet',
                                () => _walletProvider.setShowWalletList(),
                          ),
                        ],
                      ),
                      SizedBox(height: 15),
                      WalletList(darkMode: isDarkMode),
                      AccountList(),
                      SizedBox(height: 50),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildActionContainer(BuildContext context, IconData icon, String text, VoidCallback onTap) {
    final bool darkMode = THelperFunctions.isDarkMode(context);
    final backgroundColor = darkMode ? Color(0xFF3E3E3E) : Color(0xFFF6F6F6);
    final iconColor = darkMode ? Colors.white : Colors.black;
    final boxShadowColor = darkMode ? Colors.black.withOpacity(0.5) : Colors.grey.withOpacity(0.2);

    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 70,
        width: (THelperFunctions.screenWidth() - (TSizes.defaultSpace * 0.8 * 2) - 20) / 3,
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: boxShadowColor,
              blurRadius: 5,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 24, color: iconColor),
            SizedBox(height: 2),
            Text(text, style: Theme.of(context).textTheme.labelSmall),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.only(top: 50, bottom: 15),
      child: Text(
        'My Assets',
        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
          fontSize: 20,
          fontWeight: TSizes.fontWeightMd,
        ),
      ),
    );
  }

  Widget _buildWalletList(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'My Accounts',
          style: Theme.of(context).textTheme.labelSmall?.copyWith(fontSize: 14),
        ),
        SizedBox(height: 5),
        ListView.builder(
          itemCount: _walletProvider.wallets.length,
          shrinkWrap: true,
          padding: EdgeInsets.zero,
          physics: NeverScrollableScrollPhysics(),
          itemBuilder: (_, index) {
            final item = _walletProvider.wallets[index];
            final isSelected = item.currency == _walletProvider.defaultWallet?.currency;

            return GestureDetector(
              onTap: () {
                NoLoaderService.instance.defaultWallet(
                  transactionProvider: _transactionProvider,
                  walletProvider: _walletProvider,
                  walletId: item.id.toString(),
                );
              },
              child: Container(
                margin: EdgeInsets.only(bottom: 10),
                padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                decoration: BoxDecoration(
                  color: THelperFunctions.isDarkMode(context) ? Color(0xFF3E3E3E) : Color(0xFFF6F6F6),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('${item.currency} wallet', style: Theme.of(context).textTheme.labelSmall),
                        SizedBox(height: 5),
                        Row(
                          children: [
                            Text(THelperFunctions.moneyFormatter(item.balance.toString()), style: Theme.of(context).textTheme.titleMedium),
                            SizedBox(width: 5),
                            Text(item.currency.toString(), style: Theme.of(context).textTheme.labelSmall),
                          ],
                        ),
                      ],
                    ),
                    if (isSelected)
                      const SizedBox(
                        width: 10,
                        child: Image(image: AssetImage('assets/icons/wallet_check.png')),
                      ),
                  ],
                ),
              ),
            );
          },
        ),
      ],
    );
  }
}

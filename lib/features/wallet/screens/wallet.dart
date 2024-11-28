import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pouch/features/wallet/controller/wallet_controller.dart';
import 'package:pouch/features/wallet/widgets/account_list.dart';
import 'package:pouch/utils/shared/refresh_indicator/refresh_indicator.dart';
import 'package:pouch/features/wallet/widgets/wallet_dashboard.dart';
import 'package:pouch/features/wallet/widgets/wallet_list.dart';
import 'package:pouch/utils/helpers/helper_functions.dart';
import '../../../utils/constants/sizes.dart';
import '../../payment_method/screens/payment_options.dart';
import '../../withdrawals/screens/withdrawal.dart';

class WalletDashboardScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final WalletController controller = Get.find();
    final bool darkMode = THelperFunctions.isDarkMode(context);
    final backgroundColor = darkMode ? Color(0xFF1E1E1E) : Colors.grey[200];
    final borderColor = darkMode ? Color(0xFF2E2E2E).withOpacity(0.1) : Colors.grey[400]?.withOpacity(0.1);

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
                onRefresh: () => controller.fetchWallets(currency: ''),
                child: ListView(
                  children: [
                    WalletDashboard(),
                    SizedBox(height: 15),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        _buildActionContainer(
                          context,
                          Icons.payments_outlined,
                          'Deposit',
                              () => Get.to(() => PaymentOptionScreen()),
                        ),
                        _buildActionContainer(
                          context,
                          Icons.add_card,
                          'Withdraw',
                              () => Get.to(() => WithdrawalScreen()),
                        ),
                        _buildActionContainer(
                          context,
                          Icons.add_card_outlined,
                          'Add Wallet',
                          controller.updateShowWalletList,
                        ),
                      ],
                    ),
                    SizedBox(height: 15),
                    WalletList(),
                    Obx(() => controller.isWalletLoading.isTrue
                        ? const WalletLoadingView()
                        : controller.wallets.isEmpty
                        ? NoWalletView()
                        : AccountList()),
                    SizedBox(height: 50),
                  ],
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

}

class NoWalletView extends StatelessWidget {
  const NoWalletView({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      decoration: BoxDecoration(
        color: THelperFunctions.isDarkMode(context) ? const Color(0xFF3E3E3E) : const Color(0xFFF6F6F6),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const [
          Text('No wallet created'),
        ],
      ),
    );
  }
}

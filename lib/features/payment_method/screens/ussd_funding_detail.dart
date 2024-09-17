import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:pouch/data/modules/background_task.dart';
import 'package:pouch/features/authentication/controllers/auth_controller.dart';
import 'package:provider/provider.dart';
import 'package:pouch/features/home/routes/names.dart';
import 'package:pouch/features/wallet/apis/api.dart';
import '../../../data/modules/app_navigator.dart';
import '../../../data/provider/auth_provider.dart';
import '../../../data/provider/transaction_provider.dart';
import '../../../data/provider/wallet_provider.dart';
import '../../../utils/constants/colors.dart';
import '../../../utils/constants/sizes.dart';
import '../../../utils/helpers/helper_functions.dart';
import '../../../utils/layouts/navigation_menu.dart';
import '../../wallet/controller/wallet_controller.dart';
import '../../wallet/models/ussd_modal.dart';
import '../../wallet/routes/names.dart';

class UssdFundingDetailScreen extends StatelessWidget {
  final walletController = Get.find<WalletController>();
  final controller = Get.find<NavigationController>();
  final authController = Get.find<AuthController>();
  final String? amount;

  UssdFundingDetailScreen({super.key, this.amount});

  @override
  Widget build(BuildContext context) {
    final darkMode = THelperFunctions.isDarkMode(context);
    final item = walletController.ussdDetails.value;
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Container(
        margin: EdgeInsets.only(top: THelperFunctions.screenHeight() * 0.1),
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: TSizes.defaultSpace * 0.8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildReferenceAndEmailSection(context, darkMode),
              SizedBox(height: THelperFunctions.screenHeight() * 0.07),
              _buildTransferDetails(context, darkMode, width, item),
              const SizedBox(height: TSizes.defaultSpace * 4),
              _buildActionButton(context, "Proceed to Wallet", darkMode, () async {
                await walletController.fetchWallets(currency: '');
                controller.selectedIndex.value = 3;
                Get.offAll(() => NavigationMenu());
              }),
              const SizedBox(height: TSizes.defaultSpace),
              _buildActionButton(context, "Proceed to Dashboard", darkMode, () async {
                await walletController.fetchWallets(currency: '');
                controller.selectedIndex.value = 0;
                Get.offAll(() => NavigationMenu());
                // AppNavigator.instance.removeAllNavigateToNavHandler(DASHBOARD_SCREEN_ROUTE);
              }),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildReferenceAndEmailSection(BuildContext context, bool darkMode) {
    final item = walletController.ussdDetails.value;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildTextColumn(
          context,
          title: 'Reference No:',
          content: item.reference ?? '',
          darkMode: darkMode,
        ),
        _buildTextColumn(
          context,
          title: authController.user.value.email ?? '',
          content: 'Pay NGN $amount',
          darkMode: darkMode,
        ),
      ],
    );
  }

  Widget _buildTextColumn(BuildContext context, {required String title, required String content, required bool darkMode}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildRichText(context, title, darkMode, fontSize: 14),
        const SizedBox(height: TSizes.sm),
        _buildRichText(context, content, darkMode, fontSize: 16),
      ],
    );
  }

  Widget _buildRichText(BuildContext context, String text, bool darkMode, {double fontSize = 12}) {
    return RichText(
      text: TextSpan(
        style: TextStyle(
          color: darkMode ? Colors.white : Colors.black,
          fontWeight: FontWeight.w600,
          fontSize: fontSize,
          fontFamily: 'Roboto',
        ),
        children: [TextSpan(text: text)],
      ),
    );
  }

  Widget _buildTransferDetails(BuildContext context, bool darkMode, double width, UssdModel item) {
    return Column(
      children: [
        _buildRichText(context, 'Transfer NGN $amount to', darkMode, fontSize: 20),
        const SizedBox(height: 15),
        _buildRichText(context, 'Paystack Checkout', darkMode, fontSize: 18),
        const SizedBox(height: TSizes.defaultSpace),
        _buildTransferCodeContainer(context, darkMode, width, item),
      ],
    );
  }

  Widget _buildTransferCodeContainer(BuildContext context, bool darkMode, double width, UssdModel item) {
    return Container(
      alignment: Alignment.center,
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 15),
      decoration: _buildContainerDecoration(darkMode),
      child: Column(
        children: [
          const SizedBox(height: TSizes.defaultSpace),
          _buildRichText(context, item.ussd_code ?? '', darkMode, fontSize: width > 380 ? 32 : 26),
          const SizedBox(height: TSizes.defaultSpace / 1.2),
          _buildRichText(context, item.display_text ?? '', darkMode, fontSize: 14),
        ],
      ),
    );
  }

  BoxDecoration _buildContainerDecoration(bool darkMode) {
    return darkMode
        ? BoxDecoration(
      borderRadius: const BorderRadius.all(Radius.circular(10)),
      color: TColors.primary
    )
        : BoxDecoration(
      borderRadius: const BorderRadius.all(Radius.circular(10)),
      boxShadow: [
        BoxShadow(
          color: TColors.black.withOpacity(0.3),
          offset: const Offset(2.3, 3.87),
        ),
        BoxShadow(
          color: const Color(0xFFA58DC4).withOpacity(0.3),
          offset: const Offset(0.0, 0.0),
        ),
        BoxShadow(
          color: Colors.white.withOpacity(0.8),
          offset: const Offset(0.0, 0.0),
        ),
      ],
    );
  }

  Widget _buildActionButton(BuildContext context, String text, bool darkMode, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        alignment: Alignment.center,
        padding: const EdgeInsets.symmetric(vertical: 20),
        decoration: _buildContainerDecoration(darkMode),
        child: _buildRichText(context, text, darkMode, fontSize: 16),
      ),
    );
  }
}

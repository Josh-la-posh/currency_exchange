import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:pouch/features/payment_method/screens/foreign_deposit.dart';
import 'package:pouch/features/payment_method/screens/ussd_funding.dart';
import 'package:pouch/features/wallet/controller/wallet_controller.dart';
import 'package:pouch/utils/constants/image_strings.dart';
import 'package:pouch/utils/constants/sizes.dart';
import 'package:pouch/utils/helpers/helper_functions.dart';

import '../../../common/widgets/buttons/elevated_button.dart';
import '../../../utils/constants/colors.dart';
import '../../../utils/validators/validation.dart';
import '../../all_offer/decimal_formatter.dart';

class PaymentOptionScreen extends StatelessWidget {
  PaymentOptionScreen({Key? key}) : super(key: key);

  WalletController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    final darkMode = THelperFunctions.isDarkMode(context);
    return Scaffold(
      appBar: AppBar(leading: const BackButton()),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(vertical: TSizes.defaultSpace),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildTitle(context, 'Funding method'),
            const SizedBox(height: TSizes.defaultSpace),
            _buildPaymentOptions(context, darkMode),
            const Divider(thickness: 1),
            _buildUSSDOption(context, darkMode),
            const Divider(thickness: 1),
            _buildDepositOption(context, darkMode),
            const Divider(thickness: 1),
            _buildForeignOption(context, darkMode),
          ],
        ),
      ),
    );
  }

  Widget _buildTitle(BuildContext context, String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: TSizes.defaultSpace),
      child: RichText(
        text: TextSpan(
          style: Theme.of(context).textTheme.titleLarge,
          children: [
            TextSpan(
              text: title,
              style: const TextStyle(fontSize: TSizes.fontSize20),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPaymentOptions(BuildContext context, bool darkMode) {
    return Column(
      children: [
        Obx(() => _buildPaymentOptionTile(
          context,
          title: 'Bank transfer',
          image: TImages.bankTransfer,
          darkMode: darkMode,
          isExpanded: controller.showBankTransferOption.value,
          onTap: () {
            controller.toggleBankTransferOption();
          },
          child: _buildBankTransferOptions(context),
        )),
      ],
    );
  }

  Widget _buildPaymentOptionTile(BuildContext context,
      {required String title,
        required String image,
        required bool darkMode,
        required bool isExpanded,
        required VoidCallback onTap,
        Widget? child}) {
    return Column(
      children: [
        ListTile(
          onTap: onTap,
          contentPadding: const EdgeInsets.symmetric(horizontal: TSizes.defaultSpace, vertical: 10),
          title: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              _buildIcon(image, darkMode),
              const SizedBox(width: 15),
              _buildRichText(context, title),
              SizedBox(
                child: isExpanded
                    ? const Icon(Icons.keyboard_arrow_up_outlined)
                    : const Icon(Icons.keyboard_arrow_down_outlined),
              ),
            ],
          ),
        ),
        if (isExpanded && child != null) child,
      ],
    );
  }

  Widget _buildBankTransferOptions(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: TSizes.defaultSpace * 2),
      child: Column(
        children: [
          _buildBankTransferOption(context, 'Flutterwave', TImages.flutterwave, () {
            _showAmountDialog(context, 'Enter Amount', () {
              if (controller.amount.value.isEmpty) {
                controller.setShowErrorText(true);
              } else {
                controller.setShowErrorText(false);
                controller.isFundingWalletViaNairaTransfer.value ? null :
                controller.fundingWalletViaNairaTransfer(amount: controller.amount.value);
              }
            });
          }),
          _buildBankTransferOption(context, 'Paystack', TImages.paystack, () {
            _showAmountDialog(context, 'Enter Amount', () {
              if (controller.amount.value.isEmpty) {
                controller.setShowErrorText(true);
              } else {
                controller.setShowErrorText(false);
                controller.isFundingWalletViaPaystack.value ? null :
                controller.fundingWalletViaPaystack(amount: controller.amount.value);
              }
            });
          }),
        ],
      ),
    );
  }

  Widget _buildBankTransferOption(BuildContext context, String title, String image, VoidCallback onTap) {
    return ListTile(
      onTap: onTap,
      contentPadding: const EdgeInsets.only(left: 25),
      title: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            child: Image(image: AssetImage(image)),
          ),
          const SizedBox(width: 15),
          _buildRichText(context, title, fontSize: 11),
        ],
      ),
    );
  }

  Widget _buildUSSDOption(BuildContext context, bool darkMode) {
    return _buildPaymentOptionTile(
      context,
      title: 'USSD',
      image: TImages.ussd,
      darkMode: darkMode,
      isExpanded: false,
      onTap: () {
        controller.amount.value = '';
        Get.to(() => UssdFundingScreen());
      },
    );
  }

  Widget _buildDepositOption(BuildContext context, bool darkMode) {
    return _buildPaymentOptionTile(
      context,
      title: 'Direct Deposit',
      image: TImages.internetBanking,
      darkMode: darkMode,
      isExpanded: false,
      onTap: () {
        // Handle Direct Deposit
      },
    );
  }

  Widget _buildForeignOption(BuildContext context, bool darkMode) {
    return _buildPaymentOptionTile(
      context,
      title: 'Foreign Deposit',
      image: TImages.ussd,
      darkMode: darkMode,
      isExpanded: false,
      onTap: () {
        controller.amount.value = '';
        Get.to(() => ForeignFundingScreen());
      },
    );
  }

  Widget _buildIcon(String image, bool darkMode) {
    return Container(
      height: 40,
      width: 40,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(40),
        color: darkMode ? TColors.white.withOpacity(0.3) : Colors.transparent,
      ),
      child: Image(image: AssetImage(image)),
    );
  }

  Widget _buildRichText(BuildContext context, String text, {double fontSize = 12}) {
    return RichText(
      text: TextSpan(
        style: Theme.of(context).textTheme.labelSmall,
        children: [
          TextSpan(
            text: text,
            style: TextStyle(fontSize: fontSize, fontWeight: TSizes.fontWeightLg),
          ),
        ],
      ),
    );
  }

  void _showAmountDialog(BuildContext context, String title, VoidCallback onContinue) {
    controller.amount.value = '';
    controller.setShowErrorText(false);
    Get.dialog(
      AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        content: SizedBox(
          height: 240,
          width: 200,
          child: Column(
            children: [
              _buildRichText(context, title, fontSize: 16),
              const SizedBox(height: TSizes.defaultSpace * 1.4),
              _buildAmountInputField(context),
              const SizedBox(height: TSizes.sm),
              Obx(() {
                return Visibility(
                  visible: controller.showErrorText.value,
                  child: _buildRichText(
                    context,
                    'Please, enter an amount',
                    fontSize: 10,
                  ),
                );
              }),
              const SizedBox(height: TSizes.defaultSpace * 1.4),
              SizedBox(
                height: 40,
                width: 140,
                child: TElevatedButton(
                  onTap: onContinue,
                  buttonText: 'Continue',
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAmountInputField(BuildContext context) {
    return TextFormField(
      textAlign: TextAlign.center,
      validator: TValidator.numValidator,
      keyboardType: TextInputType.number,
      inputFormatters: [
        DecimalTextInputFormatter(decimalRange: 2),
        FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d{0,2}')),
      ],
      style: Theme.of(context).textTheme.titleLarge,
      onChanged: (val) {
        controller.setAmount(val);
      },
      onSaved: (val) {
        controller.setAmount(val ?? '');
      },
      decoration: const InputDecoration(
        contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
        border: OutlineInputBorder(),
        hintText: 'Amount',
      ),
    );

  }
}

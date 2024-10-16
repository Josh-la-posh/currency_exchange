import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:pouch/features/wallet/controller/wallet_controller.dart';
import 'package:pouch/common/widgets/buttons/elevated_button.dart';
import 'package:pouch/features/profile/screens/bank_account/add_bank_account.dart';
import 'package:pouch/features/wallet/models/get_bank_account.dart';
import 'package:pouch/utils/constants/colors.dart';
import 'package:pouch/utils/constants/sizes.dart';
import 'package:pouch/utils/helpers/helper_functions.dart';
import 'package:pouch/utils/validators/validation.dart';
import '../../../data/modules/interceptor.dart';
import '../../../utils/layouts/list_layout.dart';
import '../../all_offer/decimal_formatter.dart';
import '../widgets/account_widget.dart';
import '../widgets/withdrawal_sheet.dart';

class WithdrawalScreen extends StatelessWidget {
  WalletController walletController = Get.find();
  final AppInterceptor appInterceptor = AppInterceptor();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  WithdrawalScreen({Key? key}) : super(key: key);

  void _showWithdrawalConfirmSheet(BuildContext context, String amount) {
    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (ctx) => WithdrawalConfirmSheet(amount: amount),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (walletController.bankAccounts.isEmpty) {
      walletController.fetchLocalBank();
    }
    walletController.amount.value = '';
    final bool darkMode = THelperFunctions.isDarkMode(context);
    walletController.selectedWithdrawalAccount.value = GetBankAccountModel();
    final banks = walletController.bankAccounts;
    return Scaffold(
      appBar: _buildAppBar(darkMode),
      backgroundColor: darkMode ? TColors.textPrimaryO40 : Colors.white,
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: TSizes.defaultSpace * 0.8, vertical: 30),
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    _buildBalanceInfo(darkMode),
                    const SizedBox(height: TSizes.defaultSpace * 1.5),
                    _buildAmountSection(darkMode),
                    const SizedBox(height: TSizes.defaultSpace * 2),
                    _buildWithdrawToSection(context, darkMode),
                    const SizedBox(height: TSizes.defaultSpace * 2),
                    _buildBankList(banks, darkMode),
                    const SizedBox(height: TSizes.defaultSpace * 2),
                  ],
                ),
              ),
            ),
            SizedBox(height: 10),
            Obx(() => TElevatedButton(
              onTap: walletController.selectedWithdrawalAccount.value.accountNumber == null
                  ? null
                  : () {
                if (_formKey.currentState!.validate()) {
                  _formKey.currentState!.save();
                  _showWithdrawalConfirmSheet(context, walletController.amount.value);
                }
              },
              buttonText: 'Continue',
            ))
          ],
        ),
      )
    );
  }

  AppBar _buildAppBar(bool darkMode) {
    return AppBar(
      backgroundColor: Colors.transparent,
      shadowColor: Colors.transparent,
      leading: BackButton(
        onPressed: () {
          walletController.selectedWithdrawalAccount.value = GetBankAccountModel();
          appInterceptor.cancelOngoingRequest();
          Get.back();
        },
      ),
      title: Text(
        'Withdraw Money',
        style: TextStyle(
          color: darkMode ? Colors.white : Colors.black,
          fontWeight: FontWeight.w600,
          fontSize: 18,
        ),
      ),
      centerTitle: true,
    );
  }

  Widget _buildAmountSection(bool darkMode) {
    return Container(
      padding: const EdgeInsets.only(top: TSizes.defaultSpace),
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: darkMode ? Colors.white.withOpacity(0.09) : Colors.black.withOpacity(0.09),
        ),
      ),
      child: Column(
        children: [
          _buildAmountLabel(darkMode),
          const SizedBox(height: 30),
          _buildAmountInputField(darkMode),
        ],
      ),
    );
  }

  Widget _buildAmountLabel(bool darkMode) {
    return Obx(() {
      return RichText(
        text: TextSpan(
          style: TextStyle(
            color: darkMode ? Colors.white : Colors.black.withOpacity(0.55),
            fontWeight: FontWeight.w800,
            fontSize: 18,
          ),
          children: [
            const TextSpan(text: 'Amount '),
            TextSpan(
              text: walletController.defaultWallet.value.balance == null ? '***' : '(${walletController.defaultWallet.value.currency})',
              style: const TextStyle(fontSize: 12),
            ),
          ],
        ),
      );
    });
  }

  Widget _buildAmountInputField(bool darkMode) {
    return Form(
      key: _formKey,
      child: TextFormField(
        validator: (val) {
          return TValidator.withdrawalValidator(
            walletController.amount.value,
            double.parse(walletController.defaultWallet.value.balance.toString()),
          );
        },
        textAlign: TextAlign.center,
        keyboardType: TextInputType.number,
        inputFormatters: [
          DecimalTextInputFormatter(decimalRange: 2),
          FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d{0,2}')),
        ],
        decoration: InputDecoration(
          hintText: 'Enter amount',
          hintStyle: TextStyle(
            color: darkMode ? Colors.white : Colors.black.withOpacity(0.3),
            fontWeight: FontWeight.w800,
            fontSize: 24,
          ),
          border: const OutlineInputBorder().copyWith(borderSide: BorderSide.none),
        ),
        style: TextStyle(
          color: darkMode ? Colors.white : Colors.black,
          fontWeight: FontWeight.w800,
          fontSize: 24,
        ),
        onChanged: (val) {
          walletController.setAmount(val);
          _formKey.currentState?.validate();
        },
      ),
    );
  }

  Widget _buildBalanceInfo(bool darkMode) {
    return Column(
      children: [
        Obx(() => RichText(
          text: TextSpan(
            style: TextStyle(
              color: darkMode ? Colors.white : Colors.black,
              fontWeight: FontWeight.w600,
              fontSize: 16,
            ),
            children: [
              TextSpan(
                text: walletController.defaultWallet .value.balance == null
                    ? '*****'
                    : '${walletController.defaultWallet.value.currency} ${THelperFunctions.moneyFormatter(walletController.defaultWallet.value.balance.toString())}',
              ),
            ],
          ),
        )),
        const SizedBox(height: TSizes.md),
        const Text(
          'Available Balance',
          style: TextStyle(
            fontWeight: FontWeight.w800,
            fontSize: 16,
          ),
        ),
      ],
    );
  }

  Widget _buildWithdrawToSection(BuildContext context, bool darkMode) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Icon(
              Icons.wallet_travel_rounded,
              size: 15,
              color: darkMode ? Colors.white : Colors.black,
            ),
            const SizedBox(width: 5),
            Text(
              'Withdraw To',
              style: TextStyle(
                color: darkMode ? Colors.white : Colors.black,
                fontWeight: FontWeight.w600,
                fontSize: 16,
              ),
            ),
          ],
        ),
        _buildAddBankAccountButton(context),
      ],
    );
  }

  Widget _buildAddBankAccountButton(BuildContext context) {
    return GestureDetector(
      onTap: () => Get.to(() => AddBankAccountScreen()),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        decoration: BoxDecoration(
          color: const Color(0xFFD9D9D9),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: const [
            Icon(Icons.add, size: 20),
            Text(
              'Add Bank Account',
              style: TextStyle(
                color: TColors.primary,
                fontWeight: FontWeight.w600,
                fontSize: 12,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBankList(List banks, bool darkMode) {
    return Obx(() {
      if (walletController.isLocalBankLoading.value) {
        return Center(child: CircularProgressIndicator(),);
      } else {
        if (walletController.bankAccounts.isEmpty) {
          return Center(
            child: Text('No bank account saved.'),
          );
        } else {
          return TListLayout(
            itemCount: banks.length,
            itemBuilder: (_, index) {
              final item = banks[index];
              return AccountWidget(item: item, darkMode: darkMode);
            },
          );
        }
      }
    });
  }
}

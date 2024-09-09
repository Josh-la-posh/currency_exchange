import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:pouch/common/widgets/buttons/elevated_button.dart';
import 'package:pouch/features/profile/screens/bank_account/add_bank_account.dart';
import 'package:pouch/utils/constants/colors.dart';
import 'package:pouch/utils/constants/sizes.dart';
import 'package:pouch/utils/helpers/helper_functions.dart';
import 'package:pouch/utils/validators/validation.dart';
import '../../../data/provider/wallet_provider.dart';
import '../../../utils/layouts/list_layout.dart';
import '../../all_offer/decimal_formatter.dart';
import '../widgets/account_widget.dart';
import '../widgets/withdrawal_sheet.dart';

class WithdrawalScreen extends StatefulWidget {
  const WithdrawalScreen({Key? key}) : super(key: key);

  @override
  State<WithdrawalScreen> createState() => _WithdrawalScreenState();
}

class _WithdrawalScreenState extends State<WithdrawalScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String _amount = '';

  void _showWithdrawalConfirmSheet(BuildContext context) {
    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (ctx) => WithdrawalConfirmSheet(amount: _amount),
    );
  }

  @override
  Widget build(BuildContext context) {
    final WalletProvider provider = Provider.of<WalletProvider>(context);
    final List banks = provider.savedBankAccounts;
    final bool darkMode = THelperFunctions.isDarkMode(context);

    return Scaffold(
      appBar: _buildAppBar(provider, darkMode),
      backgroundColor: darkMode ? TColors.textPrimaryO40 : Colors.white,
      body: _buildBody(context, provider, banks, darkMode),
    );
  }

  AppBar _buildAppBar(WalletProvider provider, bool darkMode) {
    return AppBar(
      backgroundColor: Colors.transparent,
      shadowColor: Colors.transparent,
      leading: BackButton(
        onPressed: () {
          provider.saveWithdrawalBank(null);
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

  Widget _buildBody(BuildContext context, WalletProvider provider, List banks,
      bool darkMode) {
    return Container(
      padding: EdgeInsets.only(right: TSizes.defaultSpace * 0.8,
          left: TSizes.defaultSpace * 0.8,
          bottom: 10),
      child: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(height: THelperFunctions.screenHeight() * 0.04),
                  _buildBalanceInfo(provider, darkMode),
                  const SizedBox(height: TSizes.defaultSpace * 1.5),
                  _buildAmountSection(provider, darkMode),
                  const SizedBox(height: TSizes.defaultSpace * 2),
                  _buildWithdrawToSection(context, darkMode),
                  const SizedBox(height: TSizes.defaultSpace * 2),
                  _buildBankList(banks, darkMode),
                  const SizedBox(height: TSizes.defaultSpace * 2),
                ],
              ),
            ),
          ),
          SizedBox(height: 10,),
          Container(
            child: TElevatedButton(
              onTap: provider.selectedWithdrawalAccount == null ? null : () {
                if (_formKey.currentState!.validate()) {
                  _formKey.currentState!.save();
                  _showWithdrawalConfirmSheet(context);
                }
              },
              buttonText: 'Continue',
            ),
          )
        ],
      ),
    );
  }

  Widget _buildAmountSection(WalletProvider provider, bool darkMode) {
    return Container(
      padding: const EdgeInsets.only(top: TSizes.defaultSpace),
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: darkMode ? Colors.white.withOpacity(0.09) : Colors.black
              .withOpacity(0.09),
        ),
      ),
      child: Column(
        children: [
          _buildAmountLabel(provider, darkMode),
          const SizedBox(height: 30),
          _buildAmountInputField(provider, darkMode),
        ],
      ),
    );
  }

  Widget _buildAmountLabel(WalletProvider provider, bool darkMode) {
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
            text: provider.defaultWallet == null ? '***'  : '(${provider.defaultWallet!.currency})',
            style: const TextStyle(fontSize: 12),
          ),
        ],
      ),
    );
  }

  Widget _buildAmountInputField(WalletProvider provider, bool darkMode) {
    return Form(
      key: _formKey,
      child: TextFormField(
        validator: (val) =>
            TValidator.withdrawalValidator(_amount, double.parse(provider
                .defaultWallet!.balance.toString())),
        textAlign: TextAlign.center,
        keyboardType: TextInputType.number,
        inputFormatters: [
          DecimalTextInputFormatter(decimalRange: 2),
          // Apply the formatter here
          FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d{0,2}')),
        ],
        decoration: InputDecoration(
          hintText: 'Enter amount',
          hintStyle: TextStyle(
            color: darkMode ? Colors.white : Colors.black.withOpacity(0.3),
            fontWeight: FontWeight.w800,
            fontSize: 24,
          ),
          border: const OutlineInputBorder().copyWith(
            borderSide: BorderSide.none,
          ),
        ),
        style: TextStyle(
          color: darkMode ? Colors.white : Colors.black,
          fontWeight: FontWeight.w800,
          fontSize: 24,
        ),
        onChanged: (val) {
          _amount = val;
          _formKey.currentState?.validate();
        },
        onSaved: (val) {
          setState(() {
            _amount = val!;
          });
        },
      ),
    );
  }

  Widget _buildBalanceInfo(WalletProvider provider, bool darkMode) {
    return Column(
      children: [
        RichText(
          text: TextSpan(
            style: TextStyle(
              color: darkMode ? Colors.white : Colors.black,
              fontWeight: FontWeight.w600,
              fontSize: 16,
            ),
            children: [
              TextSpan(text: '${provider.defaultWallet == null ? '*****' : provider.defaultWallet!.currency} ${provider.defaultWallet == null ? '' : THelperFunctions.moneyFormatter(provider
                  .defaultWallet!.balance.toString())}'),
            ],
          ),
        ),
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
      onTap: () => Get.to(() => const AddBankAccountScreen()),
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
    return TListLayout(
      itemCount: banks.length,
      itemBuilder: (_, index) {
        final item = banks[index];
        return AccountWidget(item: item, darkMode: darkMode);
      },
    );
  }
}



import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:provider/provider.dart';
import 'package:swappr/common/widgets/buttons/elevated_button.dart';
import 'package:swappr/features/profile/screens/bank_account/add_bank_account.dart';
import 'package:swappr/features/withdrawals/widgets/account_widget.dart';
import 'package:swappr/utils/constants/colors.dart';
import 'package:swappr/utils/constants/image_strings.dart';
import 'package:swappr/utils/constants/sizes.dart';
import 'package:swappr/utils/helpers/helper_functions.dart';

import '../../../data/provider/wallet_provider.dart';
import '../../../utils/layouts/list_layout.dart';
import '../widgets/withdrawal_sheet.dart';

class WithdrawalScreen extends StatefulWidget {
  const WithdrawalScreen({super.key});

  @override
  State<WithdrawalScreen> createState() => _WithdrawalScreenState();
}

class _WithdrawalScreenState extends State<WithdrawalScreen> {
  String amount = '';
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<WalletProvider>(context);
    final banks = provider.savedBankAccounts;
    final darkMode = THelperFunctions.isDarkMode(context);
    return Scaffold(
      appBar: AppBar(
        leading: BackButton()
      ),
      backgroundColor: darkMode ? Colors.black : Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: TSizes.defaultSpace, vertical: TSizes.defaultSpace * 2),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              RichText(
                  text: TextSpan(
                      style: TextStyle(
                          color: darkMode ? Colors.white : Colors.black,
                          fontWeight: FontWeight.w600,
                          fontSize: 22,
                          fontFamily: 'Roboto'
                      ),
                      children: const <TextSpan> [
                        TextSpan(
                          text: 'Withdraw Money',
                        )
                      ]
                  )
              ),
              SizedBox(height: THelperFunctions.screenHeight() * 0.08,),
              Container(
                padding: const EdgeInsets.symmetric(vertical: TSizes.defaultSpace),
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: Colors.black.withOpacity(0.09),
                  )
                ),
                child: Column(
                  children: [
                    RichText(
                        text: TextSpan(
                            style: TextStyle(
                                color: darkMode ? Colors.white : Colors.black.withOpacity(0.55),
                                fontWeight: FontWeight.w800,
                                fontSize: 18,
                                fontFamily: 'Roboto'
                            ),
                            children: <TextSpan> [
                              TextSpan(
                                text: 'Amount ',
                              ),
                              TextSpan(
                                text: '(${provider.defaultWallet!.currency})',
                                style: TextStyle(fontSize: 12)
                              )
                            ]
                        )
                    ),
                    const SizedBox(height: 15,),
                    TextFormField(
                      textAlign: TextAlign.center,
                      decoration: InputDecoration(
                        hintText: 'Enter amount',
                        hintStyle: TextStyle(
                            color: darkMode ? Colors.white : Colors.black.withOpacity(0.3),
                            fontWeight: FontWeight.w800,
                            fontSize: 24,
                            fontFamily: 'Roboto'
                        ),
                        fillColor: Colors.transparent,
                        border: const OutlineInputBorder().copyWith(
                          borderSide: BorderSide.none,
                        ),
                        enabledBorder: const OutlineInputBorder().copyWith(
                          borderSide: BorderSide.none,
                        ),
                        focusedBorder: const OutlineInputBorder().copyWith(
                            borderSide: BorderSide.none
                        ),
                      ),
                      style: TextStyle(
                          color: darkMode ? Colors.white : Colors.black,
                          fontWeight: FontWeight.w800,
                          fontSize: 36,
                          fontFamily: 'Roboto'
                      ),
                      onChanged: (val) => amount = val
                    ),
                  ],
                ),
              ),
              const SizedBox(height: TSizes.defaultSpace * 1.5,),
              RichText(
                  text: TextSpan(
                      style: TextStyle(
                          color: darkMode ? Colors.white : Colors.black,
                          fontWeight: FontWeight.w600,
                          fontSize: 16,
                          fontFamily: 'Roboto'
                      ),
                      children: <TextSpan> [
                        TextSpan(
                          text: '${provider.defaultWallet!.currency} ${provider.defaultWallet!.balance}',
                        )
                      ]
                  )
              ),
              const SizedBox(height: TSizes.md,),
              RichText(
                  text: TextSpan(
                      style: TextStyle(
                          color: darkMode ? Colors.white : Colors.black.withOpacity(0.35),
                          fontWeight: FontWeight.w800,
                          fontSize: 16,
                          fontFamily: 'Roboto'
                      ),
                      children: const <TextSpan> [
                        TextSpan(
                          text: 'Available Balance',
                        )
                      ]
                  )
              ),
              const SizedBox(height: TSizes.defaultSpace * 2,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      const Image(image: AssetImage(TImages.withdrawIcon)),
                      const SizedBox(width: 5,),
                      RichText(
                          text: TextSpan(
                              style: TextStyle(
                                  color: darkMode ? Colors.white : Colors.black,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 16,
                                  fontFamily: 'Roboto'
                              ),
                              children: const <TextSpan> [
                                TextSpan(
                                  text: 'Withdraw Money To',
                                )
                              ]
                          )
                      ),
                    ],
                  ),
                  GestureDetector(
                    onTap: () {
                      Get.to(() => const AddBankAccountScreen());
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      decoration: BoxDecoration(
                        color: const Color(0xFFD9D9D9),
                        borderRadius: BorderRadius.circular(12)
                      ),
                      child: Row(
                        children: [
                          const SizedBox(
                              width: 20,
                              child: Icon(Icons.add, size: 20,)
                          ),
                          RichText(
                              text: const TextSpan(
                                  style: TextStyle(
                                      color: TColors.primary,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 12,
                                      fontFamily: 'Roboto'
                                  ),
                                  children: <TextSpan> [
                                    TextSpan(
                                      text: 'Add Bank Account',
                                    )
                                  ]
                              )
                          ),
                        ],
                      ),
                    ),
                  ),],
              ),
              const SizedBox(height: TSizes.defaultSpace * 2,),

              TListLayout(
                  itemCount: banks.length,
                  itemBuilder: (_, index) {
                    final item = banks[index];
                    return AccountWidget(item: item, darkMode: darkMode);
                  }
              ),
              const SizedBox(height: TSizes.defaultSpace * 2,),
            ],
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Container(
        margin: EdgeInsets.only(bottom: 20, right: TSizes.defaultSpace, left: TSizes.defaultSpace),
        child: provider.selectedWithdrawalAccount == null || amount == ''
            ? SizedBox(
            height: 48,
            width: double.infinity,
            child: ElevatedButton(
                onPressed: null,
                child: Text('Continue')
            )
        )
            : TElevatedButton(
            onTap: () {
              showModalBottomSheet(
                  backgroundColor: Color(0xFF4C3668),
                  // isScrollControlled: true,
                  context: context,
                  builder: (ctx) => WithdrawalConfirmSheet(
                    amount: amount,
                  )
              );
            },
            buttonText: 'Continue'
        ),
      ),
    );
  }
}

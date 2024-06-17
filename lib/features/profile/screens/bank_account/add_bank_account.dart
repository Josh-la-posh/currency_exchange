import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:provider/provider.dart';
import 'package:swappr/common/widgets/buttons/app_bar.dart';
import 'package:swappr/common/widgets/buttons/elevated_button.dart';
import 'package:swappr/common/widgets/buttons/outlined_button.dart';
import '../../../../data/provider/wallet_provider.dart';
import '../../../../utils/constants/colors.dart';
import '../../../../utils/constants/sizes.dart';
import '../../../../utils/helpers/helper_functions.dart';
import '../../../../utils/validators/validation.dart';
import '../../../payment_method/widgets/bank_list.dart';
import '../../../wallet/apis/api.dart';

class AddBankAccountScreen extends StatefulWidget {
  const AddBankAccountScreen({super.key});

  @override
  State<AddBankAccountScreen> createState() => _AddBankAccountScreenState();
}

class _AddBankAccountScreenState extends State<AddBankAccountScreen> {

  String _accountNumber = '';
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {

    var walletProvider = Provider.of<WalletProvider>(context);
    final darkMode = THelperFunctions.isDarkMode(context);

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            walletProvider.bankAccountDetails == null
                ?  Get.back()
                : null;
          },
          icon: walletProvider.bankAccountDetails == null
              ? Icon(Icons.keyboard_arrow_left_outlined)
              : Text(''),
          style: IconButton.styleFrom(
              foregroundColor: TColors.primary,
              iconSize: 35
          ),
        ),
        title: Text(
          'Add Bank Account',
          style: Theme.of(context).textTheme.titleLarge,
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: TSizes.defaultSpace * 2, vertical: TSizes.defaultSpace),
          child: Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [


                if (walletProvider.bankAccountDetails == null)
                RichText(
                    text: TextSpan(
                        style: Theme.of(context).textTheme.bodyMedium,
                        children: const <TextSpan> [
                          TextSpan(
                            text: 'Select Bank Provider',
                            style: TextStyle(
                              fontWeight: FontWeight.w800,
                            )
                          ),
                        ]
                    )
                ),

                const SizedBox(height: TSizes.defaultSpace / 1.7),


                // Search bank list

                BankList(walletProvider: walletProvider),

                const SizedBox(height: TSizes.defaultSpace),

                // Account number
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    RichText(
                        text: TextSpan(
                            style: TextStyle(
                                color: darkMode ? Colors.white : Colors.black,
                                fontWeight: FontWeight.w600,
                                fontSize: 12,
                                fontFamily: 'Roboto'
                            ),
                            children: const <TextSpan> [
                              TextSpan(
                                text: 'Account Number',
                              ),
                            ]
                        )
                    ),
                    const SizedBox(height: 10,),
                    TextFormField(
                      validator: TValidator.acctNumValidator,
                      enabled: walletProvider.bankAccountDetails == null
                          ? true
                          : false,
                      style: Theme.of(context).textTheme.bodyMedium,
                      initialValue: walletProvider.bankAccountDetails == null
                          ? ''
                          : walletProvider.bankAccountDetails?.account_number,
                      onChanged: (val) => _accountNumber = val,
                      onSaved: (val) {
                        setState(() {
                          _accountNumber = val as String;
                        });
                      },

                    ),
                  ],
                ),


                if (walletProvider.bankAccountDetails != null)
                const SizedBox(height: TSizes.defaultSpace),

                // Account name

                if (walletProvider.bankAccountDetails != null)
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    RichText(
                        text: TextSpan(
                            style: TextStyle(
                                color: darkMode ? Colors.white : Colors.black,
                                fontWeight: FontWeight.w600,
                                fontSize: 12,
                                fontFamily: 'Roboto'
                            ),
                            children: const <TextSpan> [
                              TextSpan(
                                text: 'Account Name',
                              ),
                            ]
                        )
                    ),
                    const SizedBox(height: 10,),
                    TextFormField(
                      enabled: false,
                      style: Theme.of(context).textTheme.bodyMedium,
                      initialValue: walletProvider.bankAccountDetails?.account_name,
                      onChanged: (val) => _accountNumber = val,
                      onSaved: (val) {
                        setState(() {
                          _accountNumber = val as String;
                        });
                      },

                    ),
                  ],
                ),

                const SizedBox(height: TSizes.defaultSpace * 4,),


                // Submit Button

                TElevatedButton(
                    onTap: () {
                      final detail = walletProvider.bankAccountDetails;
                      final bank = walletProvider.selectedBank;
                      if (formKey.currentState!.validate()) {
                        formKey.currentState!.save();
                        if (bank == null) {
                          walletProvider.showErrorMessage();
                        } else {
                          if (detail == null) {
                            WalletServices.instance.verifyBankAccount(
                              accountNumber: _accountNumber,
                              bankCode: bank.code.toString(),
                              walletProvider: walletProvider
                            );
                          } else {
                            WalletServices.instance.addLocalBank(
                                accountNumber: detail!.account_number,
                                accountName: detail!.account_name,
                                bankName: bank.name.toString(),
                                bankCode: bank.code.toString(),
                                walletProvider: walletProvider
                            );
                          }
                        }
                      }
                    },
                    buttonText: walletProvider.bankAccountDetails == null
                        ? 'Proceed' : 'Submit'
                ),

                // Cancel Button
                if (walletProvider.bankAccountDetails != null)
                const SizedBox(height: TSizes.defaultSpace),

                if (walletProvider.bankAccountDetails != null)
                TOutlinedButton(
                    onTap: () {
                      setState(() {
                        walletProvider.saveBankAccountDetails(null);
                        _accountNumber = '';
                        walletProvider.setSelectedBank(null);
                        print('bank account detail ${walletProvider.bankAccountDetails}');
                        print('account number ${_accountNumber}');

                      });
                    },
                    buttonText: 'Cancel'
                )



              ],
            ),
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:pouch/common/widgets/buttons/elevated_button.dart';
import 'package:pouch/features/wallet/apis/api.dart';
import 'package:pouch/utils/constants/sizes.dart';
import 'package:pouch/utils/helpers/helper_functions.dart';
import 'package:pouch/utils/validators/validation.dart';
import '../../../data/modules/app_navigator.dart';
import '../../../data/provider/transaction_provider.dart';
import '../../../data/provider/wallet_provider.dart';
import '../../../utils/constants/colors.dart';
import '../../../utils/constants/enums.dart';
import '../../all_offer/decimal_formatter.dart';

class UssdFundingScreen extends StatefulWidget {
  const UssdFundingScreen({super.key});

  @override
  State<UssdFundingScreen> createState() => _UssdFundingScreenState();
}

class _UssdFundingScreenState extends State<UssdFundingScreen> {

  final formKey = GlobalKey<FormState>();
  String _amount = '';


  @override
  Widget build(BuildContext context) {
    var transactionProvider = Provider.of<TransactionProvider>(
        AppNavigator.instance.navigatorKey.currentContext as BuildContext);
    var walletProvider = Provider.of<WalletProvider>(context);
    final darkMode = THelperFunctions.isDarkMode(context);
    return Scaffold(
      appBar: AppBar(
        leading: const BackButton(),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: TSizes.defaultSpace * 2, vertical: TSizes.defaultSpace),
          child: Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // BankList(walletProvider: walletProvider),

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
                            text: 'SELECT YOUR USSD CODE PROVIDER',
                          ),
                        ]
                    )
                ),

                SizedBox(height: 20,),

                // Nigeria bank dropdown

                Container(
                  decoration: BoxDecoration(
                      border: Border.all(
                          color: TColors.secondaryBorder30),
                      borderRadius: const BorderRadius.all(Radius.circular(TSizes.borderRadiusSm))
                  ),
                  child: DropdownButtonFormField<Bank>(
                    validator: TValidator.bankValidator,
                    decoration: InputDecoration(
                      fillColor: darkMode ? TColors.timeLineBorder : TColors.textFieldBackground
                    ),
                    autofocus: false,
                    isExpanded: true,
                    value: walletProvider.selectedNigBank,
                    // underline: const SizedBox(),
                    icon: RotatedBox(
                      quarterTurns: 3,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 14.8),
                        child: Icon(
                          Icons.arrow_back_ios_rounded,
                          size: 15,
                          color: darkMode ? TColors.white : TColors.textPrimary.withOpacity(0.8),
                        ),
                      ),
                    ),
                    onChanged: (val) {
                      walletProvider.setSelectedNigBank(val!);
                      formKey.currentState?.validate();
                    },
                    items: [
                      for (final item in walletProvider.nigBanks)
                        DropdownMenuItem<Bank>(
                          value: item,
                          child: SizedBox(
                            child: Row(
                              children: [
                                Text(
                                    getBankName(item),
                                    style: Theme.of(context).textTheme.bodyMedium
                                ),
                              ],
                            ),
                          ),
                        ),
                    ],
                  ),
                ),

                const SizedBox(height: TSizes.defaultSpace * 2),
                Container(
                  width: double.infinity,
                  alignment: Alignment.centerLeft,
                  // padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                  decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                  //     boxShadow: [
                  //       BoxShadow(
                  //           color: TColors.black.withOpacity(0.1),
                  //           offset: const Offset(1.32,1.87),
                  //           blurRadius: 1.94,
                  //           spreadRadius: 1.94
                  //       ),
                  //       BoxShadow(
                  //           color: const Color(0xFFFDF6FF).withOpacity(0.5),
                  //           offset: const Offset(0.0,0.0),
                  //           blurRadius: 0,
                  //           spreadRadius: 0
                  //       ),
                  //       BoxShadow(
                  //           color: Colors.white.withOpacity(0.8),
                  //           offset: const Offset(0,0.0),
                  //           blurRadius: 1.8,
                  //           spreadRadius: 0
                  //       ),
                  //     ]
                  ),
                  child:
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
                                  text: 'Amount',
                                ),
                              ]
                          )
                      ),
                      SizedBox(height: 10,),
                      TextFormField(
                        validator: TValidator.numValidator,
                        style: Theme.of(context).textTheme.bodyMedium,
                        keyboardType: TextInputType.number,
                        inputFormatters: [
                          DecimalTextInputFormatter(decimalRange: 2),
                          // Apply the formatter here
                          FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d{0,2}')),
                        ],
                        onChanged: (val) {
                          _amount = val;
                          formKey.currentState?.validate();
                        },
                        onSaved: (val) {
                          setState(() {
                            _amount = val as String;
                          });
                        },

                      ),
                    ],
                  ),
                ),
                const SizedBox(height: TSizes.defaultSpace * 4,),
                Center(
                  child: SizedBox(
                      width: 200,
                      child: TElevatedButton(onTap: (){
                        if (formKey.currentState!.validate()) {
                          formKey.currentState!.save();
                          WalletServices.instance.fundWalletNairaUssd(
                              walletProvider: walletProvider,
                              transactionProvider: transactionProvider,
                              amount: _amount,
                              currency: 'NGN',
                              bank: getBankName(walletProvider.selectedNigBank)
                          );
                        }
                      }, buttonText: 'Continue')
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

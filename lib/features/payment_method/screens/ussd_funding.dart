import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:swappr/common/widgets/buttons/elevated_button.dart';
import 'package:swappr/features/payment_method/widgets/bank_list.dart';
import 'package:swappr/features/wallet/apis/api.dart';
import 'package:swappr/utils/constants/sizes.dart';
import 'package:swappr/utils/helpers/helper_functions.dart';
import 'package:swappr/utils/validators/validation.dart';
import '../../../data/modules/app_navigator.dart';
import '../../../data/provider/transaction_provider.dart';
import '../../../data/provider/wallet_provider.dart';
import '../../../utils/constants/colors.dart';

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
          padding: const EdgeInsets.all(TSizes.defaultSpace),
          child: Form(
            key: formKey,
            child: Column(
              children: [
                BankList(walletProvider: walletProvider),
                const SizedBox(height: TSizes.defaultSpace,),
                Container(
                  width: double.infinity,
                  alignment: Alignment.centerLeft,
                  padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                  decoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(Radius.circular(10)),
                      boxShadow: [
                        BoxShadow(
                            color: TColors.black.withOpacity(0.1),
                            offset: const Offset(1.32,1.87),
                            blurRadius: 1.94,
                            spreadRadius: 1.94
                        ),
                        BoxShadow(
                            color: const Color(0xFFFDF6FF).withOpacity(0.5),
                            offset: const Offset(0.0,0.0),
                            blurRadius: 0,
                            spreadRadius: 0
                        ),
                        BoxShadow(
                            color: Colors.white.withOpacity(0.8),
                            offset: const Offset(0,0.0),
                            blurRadius: 1.8,
                            spreadRadius: 0
                        ),
                      ]
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
                                  fontSize: 9,
                                  fontFamily: 'Roboto'
                              ),
                              children: const <TextSpan> [
                                TextSpan(
                                  text: 'Amount',
                                ),
                              ]
                          )
                      ),
                      TextFormField(
                        validator: TValidator.numValidator,
                        style: Theme.of(context).textTheme.bodyMedium,
                        onChanged: (val) => _amount = val,
                        onSaved: (val) {
                          setState(() {
                            _amount = val as String;
                          });
                        },

                      ),
                    ],
                  ),
                ),
                const SizedBox(height: TSizes.defaultSpace * 2,),
                SizedBox(
                    width: 200,
                    child: TElevatedButton(onTap: (){
                      if (formKey.currentState!.validate()) {
                        formKey.currentState!.save();
                        WalletServices.instance.fundWalletNairaUssd(
                            walletProvider: walletProvider,
                            transactionProvider: transactionProvider,
                            amount: int.parse(_amount),
                            currency: 'NGN',
                            bank: walletProvider.selectedBank!.name.toString()
                        );
                      }
                    }, buttonText: 'Continue')
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

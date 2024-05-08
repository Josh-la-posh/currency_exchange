import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:swappr/common/widgets/buttons/elevated_button.dart';
import 'package:swappr/common/widgets/buttons/outlined_button.dart';
import 'package:swappr/common/widgets/divider.dart';
import 'package:swappr/features/profile/apis/wallet_api.dart';
import 'package:swappr/features/profile/models/wallet_model.dart';
import 'package:swappr/utils/constants/colors.dart';
import 'package:swappr/utils/constants/sizes.dart';

import '../../../../common/widgets/buttons/delete_button.dart';
import '../../../../data/provider/transaction_provider.dart';
import '../../../../data/provider/wallet_provider.dart';

class WalletDetails extends StatelessWidget {
  final GetWalletModel wallet;
  final WalletProvider provider;
  // final TransactionProvider transactionProvider;
  const WalletDetails({
    super.key,
    required this.wallet,
    required this.provider,
    // required this.transactionProvider
  });

  @override
  Widget build(BuildContext context) {
    var transactionProvider = Provider.of<TransactionProvider>(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: TSizes.textReviewHeight * 1.2,
          child: Slidable(
            key: const ValueKey(0),
            endActionPane: ActionPane(
                extentRatio: 0.2,
                motion: const ScrollMotion(),
                // dismissible: DismissiblePane(onDismissed: (){}),
                children: [
                  SlidableAction(
                    onPressed: ((context){
                    }),
                    backgroundColor: TColors.danger,
                    icon: Icons.delete,
                    // label: 'Delete',

                  ),
                ]
            ),
            child: ListTile(
              title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                    children: [
                      Container(
                        height: 10,
                        width: 10,
                        decoration: BoxDecoration(
                          color: wallet.isActive == true ? Colors.green : TColors.danger,
                          borderRadius: BorderRadius.circular(30)
                        ),
                      ),
                      const SizedBox(width: TSizes.md,),
                      Text(
                        '${wallet.currency}',
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Text(
                        '${wallet.currency} ${wallet.balance}',
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      const SizedBox(width: TSizes.md,),
                      TElevatedButton(
                          onTap: (){
                            _showModalDialog(context, wallet.currency, provider, transactionProvider);
                          },
                          buttonText: 'Fund'
                      )
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
        const DividerWidget()
      ],
    );
  }
}



_showModalDialog(BuildContext context, String? currency, WalletProvider provider, TransactionProvider transactionProvider) {
  String? amount;
  final formKey = GlobalKey<FormState>();
  showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          child: Container(
            color: TColors.white,
            constraints: BoxConstraints(maxHeight: 304),
            child: Padding(
              padding: EdgeInsets.all(25),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Fund Account',
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                      IconButton(
                          onPressed: (){Get.back();},
                          icon: Icon(Icons.close_outlined)
                      )
                    ],
                  ),
                  SizedBox(height: TSizes.spaceBtwSections,),
                  Text(
                    'Enter the amount you want to fund your wallet with below',
                    style: Theme.of(context).textTheme.labelMedium,
                  ),
                  SizedBox(height: TSizes.spaceBtwElements,),
                  Form(
                    key: formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          TextFormField(
                            style: TextStyle(fontSize: TSizes.fontSize16),
                            decoration: InputDecoration(
                              prefixIcon: SizedBox(
                                width: 60,
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      currency!,
                                      style: Theme.of(context).textTheme.titleMedium,
                                    ),
                                  ],
                                ),
                              )
                            ),
                            onChanged: (val) => amount = val,
                            onSaved: (val) {
                              amount = val as String;
                            },
                          ),
                          Visibility(
                            visible: provider.showErrorText,
                            child: Text(
                              'Field cannot be empty',
                              style: TextStyle(color: TColors.danger),
                            )
                          ),
                          SizedBox(height: TSizes.lg,),
                          Center(
                            child: SizedBox(
                              width: 100,
                              child: TElevatedButton(
                                  onTap: (){
                                    if (amount == null || amount!.isEmpty) {
                                      provider.showErrorMessage();
                                    } else {
                                      _showConfirmDialog(context, amount, currency, provider, transactionProvider);
                                    }
                                  },
                                  buttonText: 'Pay'
                              ),
                            ),
                          )
                        ],
                      )
                  )
                ],
              ),
            ),
          ),
        );
      }
  );
}


_showConfirmDialog(BuildContext context, String? amount, String? currency, WalletProvider walletProvider, TransactionProvider transactionProvider) {
  showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          child: Container(
            color: TColors.white,
            constraints: BoxConstraints(maxHeight: 200, maxWidth: 200),
            child: Padding(
              padding: EdgeInsets.all(25),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'You are about to pay $currency $amount',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  SizedBox(height: TSizes.spaceBtwElements,),
                  Row(
                    children: [
                      Expanded(
                        child: TElevatedButton(
                            onTap: (){
                              WalletServices.instance.fundWalletNairaTransfer(amount: amount.toString(), walletProvider: walletProvider, transactionProvider: transactionProvider);
                              Get.back();
                            },
                            buttonText: 'Proceed'
                        ),
                      ),
                      SizedBox(width: TSizes.lg,),
                      Expanded(
                        child: TOutlinedButton(
                            textColor: TColors.danger,
                            onTap: (){Get.back();},
                            buttonText: 'Cancel'
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
        );
      }
  );
}
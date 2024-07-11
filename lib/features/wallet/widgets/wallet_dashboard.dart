import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:pouch/data/modules/background_task.dart';
import 'package:pouch/data/provider/transaction_provider.dart';
import 'package:pouch/features/payment_method/screens/payment_options.dart';
import 'package:pouch/features/wallet/apis/api.dart';
import 'package:pouch/utils/constants/enums.dart';
import 'package:pouch/utils/helpers/helper_functions.dart';
import '../../../data/provider/wallet_provider.dart';
import '../../../utils/constants/colors.dart';
import '../../../utils/constants/sizes.dart';
import '../../../utils/constants/texts.dart';

class WalletDashboard extends StatefulWidget {
  final bool darkMode;
  const WalletDashboard({super.key, required this.darkMode});

  @override
  State<WalletDashboard> createState() => _WalletDashboardState();
}

class _WalletDashboardState extends State<WalletDashboard> {
  @override
  Widget build(BuildContext context) {
    var walletProvider = Provider.of<WalletProvider>(context);
    var transactionProvider = Provider.of<TransactionProvider>(context);
    return Container(
        padding: const EdgeInsets.only(top: 10, bottom: 40),
        width: double.infinity,
        decoration: BoxDecoration(
          // color: TColors.primary.withOpacity(0.3),
        ),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                IconButton(
                  onPressed: (){},
                  icon: Icon(Icons.notifications_none, size: 30, color: widget.darkMode ? Colors.white : TColors.primary,),
                )
              ],
            ),
            // const SizedBox(height: 15,),
            Container(
              padding: const EdgeInsets.only(top: 5, left: 20, right: 30, bottom: 20),
              decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(Radius.circular(10)),
                  boxShadow: [
                    BoxShadow(
                        color: const Color(0xFF111E32).withOpacity(0.3),
                        offset: const Offset(1.8,3.9),
                        blurRadius: 1.24,
                    ),
                    const BoxShadow(
                        color: TColors.white,
                        offset: Offset(0.0,0.0),
                        blurRadius: 0,
                        spreadRadius: 0
                    ),
                    BoxShadow(
                        color: Color(0xFFE2BBE9).withOpacity(0.2),
                        offset: const Offset(0.0,0.0),
                        blurRadius: 0,
                        spreadRadius: 0
                    ),
                  ]
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  IconButton(
                    onPressed: (){NoLoaderService.instance.getDefaultWallet(walletProvider: walletProvider, transactionProvider: transactionProvider);},
                    icon: Icon(Icons.refresh, size: 20, color: widget.darkMode ? Colors.white : TColors.primary,),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 20, top:  20),
                    child: Row(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              width: THelperFunctions.screenWidth() * 0.45,
                              child: FittedBox(
                                fit: BoxFit.fill,
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text(walletProvider.defaultWallet == null
                                        ? '---------'
                                        : '${walletProvider.showWalletBalance == false ? '*****' : THelperFunctions.moneyFormatter(walletProvider.defaultWallet!.balance.toString())}',
                                      style: TextStyle(
                                          fontSize: 35,
                                          fontWeight: FontWeight.w800,
                                          fontFamily: 'Work Sans',
                                          color: Color(0xFF331D50)
                                      ),
                                    ),
                                    Text(
                                      walletProvider.defaultWallet == null
                                          ? ''
                                          : ' ${walletProvider.defaultWallet?.currency}',
                                      style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.w800,
                                          fontFamily: 'Roboto',
                                          color: Colors.black
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Text(
                              'Wallet Balance',
                              style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                  fontFamily: 'Work Sans',
                                  color: const Color(0xFF37517E).withOpacity(0.8)
                              ),
                            ),
                          ],
                        ),
                        Spacer(),
                        IconButton(
                            onPressed: () {
                              setState(() {
                                walletProvider.setShowWalletBalance(!walletProvider.showWalletBalance);
                              });
                            },
                            icon: walletProvider.showWalletBalance == false
                                ? Icon(Icons.visibility_off, color: TColors.textPrimaryO80, size: 17,)
                                : Icon(Icons.visibility, color: TColors.textPrimaryO80, size: 17,)
                        )
                      ],
                    ),
                  ),
                  const SizedBox(height: 30,),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(
                          child: Container(
                            height: 40,
                            child: OutlinedButton(
                              onPressed: (){Get.to(() => const PaymentOptionScreen());},
                              style: ButtonStyle(
                                backgroundColor: const MaterialStatePropertyAll(
                                  Color(0xFF2D1B1D),
                                ),
                                side: MaterialStatePropertyAll(
                                    BorderSide(
                                        color: widget.darkMode ? TColors.primary : Colors.white
                                    )
                                ),
                                shape: MaterialStatePropertyAll(
                                    RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(12),
                                    )
                                ),
                              ),
                              child: FittedBox(
                                fit: BoxFit.fill,
                                child: Text(
                                  'Deposit',
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w400,
                                      fontFamily: 'Work Sans',
                                      color: widget.darkMode ? TColors.primary : Colors.white
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 10,),
                        Expanded(
                          child: Container(
                            height: 40,
                            decoration: BoxDecoration(
                              color: Color(0xFF2D1B1D),
                                borderRadius: BorderRadius.circular(12),
                                border: Border.all(
                                    color: Color(0xFF2D1B1D),
                                )
                            ),
                            child: PopupMenuButton(
                                offset: const Offset(-10, 30),
                                color: const Color(0xFFBBADCD),
                                padding: EdgeInsets.zero,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12),
                                    side: const BorderSide(
                                        color: TColors.primary
                                    )
                                ),
                                icon: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      'Wallets',
                                      style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w400,
                                          fontFamily: 'Work Sans',
                                          color: widget.darkMode ? TColors.primary : Colors.white
                                      ),
                                    ),
                                    SizedBox(
                                      width: 4,
                                      child: Icon(
                                        Icons.keyboard_arrow_down_outlined,
                                        color: Colors.white,
                                        size: 18,
                                      ),
                                    )
                                  ],
                                ),
                                itemBuilder: (_) =>  List.generate(
                                  walletProvider.wallets.length, (index) => PopupMenuItem(
                                  onTap: () {
                                    NoLoaderService.instance.defaultWallet(
                                        transactionProvider: transactionProvider,
                                        walletProvider: walletProvider ,walletId: walletProvider.wallets[index].id.toString());
                                  },
                                  height: 20,
                                  padding: const EdgeInsets.only(top: 10, bottom: 10, left: 10, right: 0),
                                  value: getWalletCurrencyName(walletProvider.selectedWalletCurrency),
                                  child: Row(
                                    children: [
                                      Text(
                                        '${walletProvider.wallets[index].currency.toString()} Wallet',
                                        style: TextStyle(
                                            fontSize: 10,
                                            fontFamily: TTexts.fontFamily,
                                            fontWeight: TSizes.fontWeightNm,
                                            color: widget.darkMode ? TColors.black : Colors.white
                                        ),
                                      ),
                                      const SizedBox(width: 30,),
                                      if (walletProvider.wallets[index].currency == walletProvider.defaultWallet?.currency)
                                      const SizedBox(
                                        width: 10,
                                        child: Image(image: AssetImage('assets/icons/wallet_check.png')),
                                      )
                                    ],
                                  ),
                                ),),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      );
  }
}

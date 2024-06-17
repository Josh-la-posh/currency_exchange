import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:swappr/features/payment_method/screens/payment_options.dart';
import 'package:swappr/utils/constants/enums.dart';
import 'package:swappr/utils/helpers/helper_functions.dart';
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
    return Container(
        padding: const EdgeInsets.only(top: 20, left: 10, right: 10, bottom: 25),
        width: double.infinity,
        decoration: BoxDecoration(
          color: TColors.primary.withOpacity(0.3),
        ),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  height: 35,
                  width: 35,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(35),
                      color: TColors.black
                  ),
                ),
                IconButton(
                  onPressed: (){},
                  icon: const Icon(Icons.notifications_none, size: 30,),
                )
              ],
            ),
            const SizedBox(height: 15,),
            Container(
              padding: const EdgeInsets.only(top: 5, left: 20, right: 10, bottom: 40),
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
                        color: TColors.primary.withOpacity(0.3),
                        offset: const Offset(0.0,0.0),
                        blurRadius: 0,
                        spreadRadius: 0
                    ),
                  ]
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              'Wallet Address',
                              style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                  fontFamily: 'Work Sans',
                                  color: const Color(0xFF111E32).withOpacity(0.8)
                              ),
                            ),
                            IconButton(
                                onPressed: () {},
                                icon: Row(
                                  children: [
                                    Icon(Icons.circle, size: 8, color: TColors.textPrimaryO80,),
                                    Icon(Icons.circle, size: 8, color: TColors.textPrimaryO80,),
                                    Icon(Icons.circle, size: 8, color: TColors.textPrimaryO80,),
                                  ],
                                )
                            )
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              '233566...3444',
                              style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w400,
                                  fontFamily: 'Work Sans',
                                  color: const Color(0xFF111E32).withOpacity(0.8)
                              ),
                            ),
                            IconButton(
                                onPressed: () {
                                  setState(() {
                                    walletProvider.setShowWalletBalance(!walletProvider.showWalletBalance);
                                  });
                                },
                                icon: walletProvider.showWalletBalance == false
                                    ? Icon(Icons.visibility_off, color: TColors.textPrimaryO80,)
                                    : Icon(Icons.visibility, color: TColors.textPrimaryO80,)
                            )
                          ],
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IntrinsicWidth(
                              // width: 120,
                              child: TextFormField(
                                initialValue:  walletProvider.selectedWallet == null
                                    ? '****'
                                    : '${walletProvider.selectedWallet?.balance}',
                                  style: TextStyle(
                                      fontSize: 35,
                                      fontWeight: FontWeight.w800,
                                      fontFamily: 'Work Sans',
                                      color: Color(0xFF331D50)
                                  ),
                                enabled: false,
                                obscureText: walletProvider.showWalletBalance == false ? true : false,
                                obscuringCharacter: '*',
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  contentPadding: EdgeInsets.zero,
                                  fillColor: Colors.transparent,
                                  isDense: false,
                                ),

                              ),
                            ),
                            // Text(
                            //   walletProvider.selectedWallet == null
                            //       ? '****'
                            //       : '${walletProvider.selectedWallet?.balance}',
                            //   style: TextStyle(
                            //       fontSize: 35,
                            //       fontWeight: FontWeight.w800,
                            //       fontFamily: 'Work Sans',
                            //       color: Color(0xFF331D50)
                            //   ),
                            // ),
                            Text(
                              walletProvider.selectedWallet == null
                                  ? ' '
                                  : ' ${walletProvider.selectedWallet?.currency}',
                              style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w800,
                                  fontFamily: 'Roboto',
                                  color: Colors.black
                              ),
                            ),
                          ],
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
                  ),
                  const SizedBox(height: 30,),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(
                          child: SizedBox(
                            height: 40,
                            // width: 130,
                            child: OutlinedButton(
                              onPressed: (){Get.to(() => const PaymentOptionScreen());},
                              style: ButtonStyle(
                                backgroundColor: const MaterialStatePropertyAll(
                                    Colors.transparent
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
                              child:
                              Text(
                                'Fund',
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
                        const SizedBox(width: 10,),
                        Expanded(
                          child: Container(
                            height: 40,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12),
                                border: Border.all(
                                    color: widget.darkMode ? TColors.primary : Colors.white
                                )
                            ),
                            child: PopupMenuButton(
                                offset: const Offset(-10, 30),
                                color: const Color(0xFFBBADCD),
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
                                      'Digital purse',
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w400,
                                          fontFamily: 'Work Sans',
                                          color: widget.darkMode ? TColors.primary : Colors.white
                                      ),
                                    ),
                                    SizedBox(
                                      width: 5,
                                      child: Icon(Icons.keyboard_arrow_down_outlined, color: TColors.primary,),
                                    )
                                  ],
                                ),
                                itemBuilder: (_) =>  List.generate(
                                  walletProvider.wallets.length, (index) => PopupMenuItem(
                                  onTap: () {
                                    walletProvider.setSelectedWallet(walletProvider.wallets[index]);
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
                                      if (walletProvider.wallets[index].currency == walletProvider.selectedWallet?.currency)
                                      const SizedBox(
                                        width: 10,
                                        child: Image(image: AssetImage('assets/icons/wallet_check.png')),
                                      )
                                    ],
                                  ),
                                ),
                                ),
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

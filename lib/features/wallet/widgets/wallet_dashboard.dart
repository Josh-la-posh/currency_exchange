import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:swappr/utils/helpers/helper_functions.dart';

import '../../../data/provider/wallet_provider.dart';
import '../../../utils/constants/colors.dart';
import '../../../utils/constants/sizes.dart';
import '../../../utils/constants/texts.dart';

class WalletDashboard extends StatelessWidget {
  const WalletDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    var walletProvider = Provider.of<WalletProvider>(context);
    final darkMode = THelperFunctions.isDarkMode(context);
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
                                icon: const Row(
                                  children: [
                                    Icon(Icons.circle, size: 8,),
                                    Icon(Icons.circle, size: 8,),
                                    Icon(Icons.circle, size: 8,),
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
                                onPressed: () {},
                                icon: const Icon(Icons.remove_red_eye_outlined)
                            )
                          ],
                        ),
                        const Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              '4000.00',
                              style: TextStyle(
                                  fontSize: 35,
                                  fontWeight: FontWeight.w800,
                                  fontFamily: 'Work Sans',
                                  color: Color(0xFF331D50)
                              ),
                            ),
                            Text(
                              ' USD',
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
                              onPressed: (){},
                              style: ButtonStyle(
                                backgroundColor: const MaterialStatePropertyAll(
                                    Colors.transparent
                                ),
                                side: const MaterialStatePropertyAll(
                                    BorderSide(
                                        color: Colors.white
                                    )
                                ),
                                shape: MaterialStatePropertyAll(
                                    RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(12),
                                    )
                                ),
                              ),
                              child:
                              const Text(
                                'Fund',
                                style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w400,
                                    fontFamily: 'Work Sans',
                                    color: Colors.white
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
                                    color: Colors.white
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
                                icon: const Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      'Digital purse',
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w400,
                                          fontFamily: 'Work Sans',
                                          color: Colors.white
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
                                    walletProvider.setSelectedWallet(walletProvider.wallets[index].currency);
                                  },
                                  height: 20,
                                  padding: const EdgeInsets.only(top: 10, bottom: 10, left: 10, right: 0),
                                  value: walletProvider.wallets[index].currency.toString(),
                                  child: Row(
                                    children: [
                                      Text(
                                        '${walletProvider.wallets[index].currency.toString()} Wallet',
                                        style: TextStyle(
                                            fontSize: 10,
                                            fontFamily: TTexts.fontFamily,
                                            fontWeight: TSizes.fontWeightNm,
                                            color: darkMode ? TColors.black : Colors.white
                                        ),
                                      ),
                                      const SizedBox(width: 30,),
                                      if (walletProvider.wallets[index].currency == walletProvider.selectedWallet)
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

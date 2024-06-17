import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:swappr/utils/constants/texts.dart';
import 'package:swappr/utils/shared/notification/snackbar.dart';
import '../../../data/provider/wallet_provider.dart';
import '../../../utils/constants/colors.dart';
import '../../../utils/constants/sizes.dart';

class HomeBalanceWidget extends StatefulWidget {
  final bool darkMode;
  const HomeBalanceWidget({super.key, required this.darkMode});

  @override
  State<HomeBalanceWidget> createState() => _HomeBalanceWidgetState();
}

class _HomeBalanceWidgetState extends State<HomeBalanceWidget> {
  @override
  Widget build(BuildContext context) {
    var walletProvider = Provider.of<WalletProvider>(context);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: TSizes.defaultSpace * 2),
      child: Container(
        decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(10)),
            color: widget.darkMode ? TColors.black.withOpacity(0.8) : TColors.secondaryBorder,
            boxShadow: [
              BoxShadow(
                  color: TColors.black.withOpacity(0.12),
                  offset: const Offset(1.94,3.87),
                  blurRadius: 1.94,
                  spreadRadius: 1.94
              ),
              BoxShadow(
                  color: TColors.secondaryBorder,
                  offset: const Offset(0.0,0.0),
                  blurRadius: 0,
                  spreadRadius: 0
              ),
            ]
        ),
        child: Padding(
          padding: const EdgeInsets.only(left: TSizes.lg, right: TSizes.lg, top: TSizes.md, bottom: TSizes.xl),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      RichText(
                          text: TextSpan(
                              style: Theme.of(context).textTheme.labelMedium,
                              children: <TextSpan> [
                                TextSpan(
                                    text:'My Balance',
                                    style: TextStyle(
                                        fontWeight: TSizes.fontWeightMd,
                                        // color: TColors.textPrimaryO80
                                    )
                                ),
                              ]
                          )
                      ),
                      const SizedBox(width: TSizes.md),
                      SizedBox(
                        // width: 15,
                        child: IconButton(
                            onPressed: () {
                              setState(() {
                                walletProvider.setShowWalletBalance(!walletProvider.showWalletBalance);
                              });
                            },
                            icon: walletProvider.showWalletBalance == false
                                ? Icon(Icons.visibility_off,)
                                : Icon(Icons.visibility,)
                        ),
                      )
                    ],
                  ),
                  GestureDetector(
                    onTap: () {
                      handleShowCustomToast(message: 'I am working');
                    },
                    child: Container(
                      width: 30,
                      height: 30,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        color: TColors.danger,
                      ),
                    ),
                  )
                ],
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  IntrinsicWidth(
                    child: TextFormField(
                      initialValue:  walletProvider.selectedWallet == null
                          ? '****'
                          : '${walletProvider.selectedWallet?.balance}',
                      style: TextStyle(
                          fontSize: 28,
                          fontWeight: TSizes.fontWeightXl,
                          fontFamily: TTexts.fontFamily,
                          // color: TColors.textPrimaryO80
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
                  Text(
                    walletProvider.selectedWallet == null
                        ? ' '
                        : ' ${walletProvider.selectedWallet?.currency}',
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: TSizes.fontWeightXl,
                        fontFamily: 'Roboto',
                        color: TColors.textPrimaryO80
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

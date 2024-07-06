import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:swappr/features/wallet/apis/api.dart';
import 'package:swappr/features/wallet/models/default_wallet_model.dart';
import 'package:swappr/utils/constants/texts.dart';
import 'package:swappr/utils/shared/notification/snackbar.dart';
import '../../../data/modules/app_navigator.dart';
import '../../../data/provider/wallet_provider.dart';
import '../../../utils/constants/colors.dart';
import '../../../utils/constants/sizes.dart';
import '../../../utils/helpers/helper_functions.dart';

class HomeBalanceWidget extends StatefulWidget {
  final bool darkMode;
  final bool displayBalance;
  const HomeBalanceWidget({super.key, required this.darkMode, required this.displayBalance});

  @override
  State<HomeBalanceWidget> createState() => _HomeBalanceWidgetState();
}

class _HomeBalanceWidgetState extends State<HomeBalanceWidget> {

  @override
  Widget build(BuildContext context) {
    final walletProvider = Provider.of<WalletProvider>(context);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: TSizes.defaultSpace),
      child: Container(
        decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(10)),
            color: TColors.darkPurple,
            // boxShadow: [
            //   BoxShadow(
            //       color: TColors.black.withOpacity(0.12),
            //       offset: const Offset(1.94,3.87),
            //       blurRadius: 1.94,
            //       spreadRadius: 1.94
            //   ),
            //   BoxShadow(
            //       color: TColors.secondaryBorder,
            //       offset: const Offset(0.0,0.0),
            //       blurRadius: 0,
            //       spreadRadius: 0
            //   ),
            // ]
        ),
        child: Padding(
          padding: const EdgeInsets.only(left: TSizes.defaultSpace, right: TSizes.lg, top: TSizes.md, bottom: TSizes.xl),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  RichText(
                      text: TextSpan(
                          style: Theme.of(context).textTheme.labelMedium,
                          children: <TextSpan> [
                            TextSpan(
                                text:'My Balance',
                                style: TextStyle(
                                    fontWeight: TSizes.fontWeightMd,
                                    color: widget.darkMode ? TColors.grey : Colors.white
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
                            ? Icon(Icons.visibility_off_outlined, color: widget.darkMode ? TColors.grey : Colors.white, size: 17,)
                            : Icon(Icons.visibility_outlined, color: widget.darkMode ? TColors.grey : Colors.white, size: 17,)
                    ),
                  )
                ],
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  RichText(
                      text: TextSpan(
                          style: Theme.of(context).textTheme.labelMedium,
                          children: <TextSpan> [
                            TextSpan(
                                text: widget.displayBalance == false
                                    ? '---'
                                    : walletProvider.defaultWallet == null
                                    ? '---'
                                    : '${walletProvider.showWalletBalance == false ? '*****' : THelperFunctions.moneyFormatter(walletProvider.defaultWallet!.balance.toString())}',
                              style: TextStyle(
                                  fontSize: 28,
                                  fontWeight: TSizes.fontWeightXl,
                                  color: widget.darkMode ? TColors.grey : Colors.white
                              ),
                            ),
                          ]
                      )
                  ),
                  RichText(
                      text: TextSpan(
                          style: Theme.of(context).textTheme.labelMedium,
                          children: <TextSpan> [
                            TextSpan(
                              text:
                              widget.displayBalance == false
                                  ? ''
                                  : walletProvider.defaultWallet == null
                                  ? ''
                                  : '${walletProvider.showWalletBalance == false ? '' : walletProvider.defaultWallet?.currency}',
                              style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: TSizes.fontWeightLg,
                                  color: widget.darkMode ? TColors.grey : Colors.white
                              ),
                            ),
                          ]
                      )
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

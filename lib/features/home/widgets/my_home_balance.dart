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
  const HomeBalanceWidget({super.key, required this.darkMode});

  @override
  State<HomeBalanceWidget> createState() => _HomeBalanceWidgetState();
}

class _HomeBalanceWidgetState extends State<HomeBalanceWidget> {
  WalletProvider walletProvider = Provider.of<WalletProvider>(
      AppNavigator.instance.navigatorKey.currentContext as BuildContext,
      listen: false
  );
  @override
  void initState() {
    if (walletProvider.defaultWallet == null) {
      WalletServices.instance.getDefaultWallet(walletProvider: walletProvider);
      Future.delayed(
          Duration(seconds: 5),
              () => fetchDefaultWallet
      );
    }
    super.initState();
  }


  Future<void> fetchDefaultWallet()  async {
    try {
      if (walletProvider.defaultWallet == null) {
        DefaultWalletModel? defaultWalletDetail = await walletProvider.defaultWallet;
        setState(() {
          walletProvider.defaultWalletDetail = defaultWalletDetail;
          print('first ${defaultWalletDetail?.balance}');
        });
      } else {
        DefaultWalletModel? defaultWalletDetail = await walletProvider.defaultWallet;
        setState(() {
          walletProvider.defaultWalletDetail = defaultWalletDetail;
          print('second ${defaultWalletDetail?.balance}');
        });
      }
    } catch (e) {
      print('Error fetching wallet: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
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
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(walletProvider.defaultWallet == null
                      ? '---'
                      : ' ${walletProvider.showWalletBalance == false ? '*****' : walletProvider.defaultWallet?.balance}',
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: TSizes.fontWeightXl,
                      fontFamily: TTexts.fontFamily,
                    ),
                  ),
                  Text(
                    walletProvider.defaultWallet == null
                        ? ' '
                        : ' ${walletProvider.defaultWallet?.currency}',
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

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:pouch/data/modules/background_task.dart';
import 'package:pouch/data/provider/transaction_provider.dart';
import 'package:pouch/features/payment_method/screens/payment_options.dart';
import 'package:pouch/utils/constants/enums.dart';
import 'package:pouch/utils/helpers/helper_functions.dart';
import '../../../data/modules/app_navigator.dart';
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

  late WalletProvider walletProvider;
  late TransactionProvider transProvider;

  @override
  void initState() {
    super.initState();
    walletProvider = Provider.of<WalletProvider>(
        AppNavigator.instance.navigatorKey.currentContext as BuildContext,
        listen: false
    );
    transProvider = Provider.of<TransactionProvider>(
        AppNavigator.instance.navigatorKey.currentContext as BuildContext,
        listen: false
    );

    if (walletProvider.wallets.isEmpty) {
      NoLoaderService.instance.getWallets(
          transactionProvider: transProvider,
          walletProvider: walletProvider,
          currency: ''
      );
    }
  }

  Future<void> _refreshAssets() async {
    await NoLoaderService.instance.getWallets(
        transactionProvider: transProvider,
        walletProvider: walletProvider,
        currency: ''
    );
    await Future.delayed(const Duration(seconds: 2));
  }

  @override
  Widget build(BuildContext context) {
    final bool darkMode = THelperFunctions.isDarkMode(context);
    final double width = MediaQuery.of(context).size.width;
    walletProvider = Provider.of<WalletProvider>(context);
    transProvider = Provider.of<TransactionProvider>(context);

    return Container(
      padding: const EdgeInsets.only(top: 5, right: 20, bottom: 20),
      decoration: BoxDecoration(
        color: TColors.primary,
        borderRadius: const BorderRadius.all(Radius.circular(16)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          _buildBalanceHeader(width),
          // const SizedBox(height: 30),
          // _buildActionButtons(),
        ],
      ),
    );
  }

  Widget _buildBalanceHeader(double width) {
    return Padding(
      padding: const EdgeInsets.only(left: 20, top: 20),
      child: Row(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Wallet Balance',
                style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                    fontFamily: 'Work Sans',
                    color: Colors.white
                ),
              ),
              SizedBox(height: 5),
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    walletProvider.defaultWallet == null
                        ? '---------'
                        : '${walletProvider.showWalletBalance ? THelperFunctions.moneyFormatter(walletProvider.defaultWallet!.balance.toString()) : '*****'}',
                    style: TextStyle(
                        fontSize: width > 400 ? 35 : 22,
                        fontWeight: FontWeight.w800,
                        fontFamily: 'Work Sans',
                        color: Colors.white
                    ),
                  ),
                  Text(
                    walletProvider.defaultWallet == null
                        ? ''
                        : ' ${walletProvider.showWalletBalance ? walletProvider.defaultWallet?.currency : ''}',
                    style: TextStyle(
                        fontSize: width > 400 ? 16 : 14,
                        fontWeight: FontWeight.w500,
                        fontFamily: 'Roboto',
                        color: Colors.white
                    ),
                  ),
                ],
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
            icon: Icon(
              walletProvider.showWalletBalance ? Icons.visibility_outlined : Icons.visibility_off_outlined,
              color: Colors.white,
              size: 17,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActionButtons() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          _buildOutlinedButton('Deposit', () => Get.to(() => const PaymentOptionScreen())),
          const SizedBox(width: 10),
          _buildPopupMenuButton(),
        ],
      ),
    );
  }

  Widget _buildOutlinedButton(String text, VoidCallback onPressed) {
    return Expanded(
      child: Container(
        height: 40,
        child: OutlinedButton(
          onPressed: onPressed,
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(Colors.transparent),
            side: MaterialStateProperty.all(BorderSide(color: Colors.white)),
            shape: MaterialStateProperty.all(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          ),
          child: FittedBox(
            fit: BoxFit.fill,
            child: Text(
              text,
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
    );
  }

  Widget _buildPopupMenuButton() {
    return Expanded(
      child: Container(
        height: 40,
        decoration: BoxDecoration(
          color: Colors.transparent,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.white),
        ),
        child: PopupMenuButton<String>(
          offset: const Offset(-10, 30),
          color: const Color(0xFFBBADCD),
          padding: EdgeInsets.zero,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
            side: const BorderSide(color: TColors.primary),
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
                    color: Colors.white
                ),
              ),
              SizedBox(
                width: 4,
                child: Icon(
                  Icons.keyboard_arrow_down_outlined,
                  color: Colors.white,
                  size: 18,
                ),
              ),
            ],
          ),
          itemBuilder: (context) => List.generate(
            walletProvider.wallets.length,
                (index) => PopupMenuItem<String>(
              onTap: () {
                NoLoaderService.instance.defaultWallet(
                    transactionProvider: transProvider,
                    walletProvider: walletProvider,
                    walletId: walletProvider.wallets[index].id.toString()
                );
              },
              height: 20,
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
              value: getWalletCurrencyName(walletProvider.selectedWalletCurrency),
              child: Row(
                children: [
                  Text(
                    '${walletProvider.wallets[index].currency} Wallet',
                    style: TextStyle(
                        fontSize: 10,
                        fontFamily: TTexts.fontFamily,
                        fontWeight: TSizes.fontWeightNm,
                        color: widget.darkMode ? TColors.black : Colors.white
                    ),
                  ),
                  const SizedBox(width: 30),
                  if (walletProvider.wallets[index].currency == walletProvider.defaultWallet?.currency)
                    const SizedBox(
                      width: 10,
                      child: Image(image: AssetImage('assets/icons/wallet_check.png')),
                    ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

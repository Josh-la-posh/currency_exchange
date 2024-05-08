import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:swappr/data/provider/wallet_provider.dart';
import 'package:swappr/features/profile/screens/wallet/no_wallet.dart';
import 'package:swappr/features/profile/widgets/wallet/wallet_details.dart';

import '../../../../utils/constants/sizes.dart';
import '../../../../utils/layouts/list_layout.dart';

class WalletListScreen extends StatelessWidget {
  const WalletListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var walletProvider = Provider.of<WalletProvider>(context);
    return walletProvider.wallets.isEmpty
        ? LayoutBuilder(builder: (context, constraints) {
          return const NoWalletScreen();
        })
        : SingleChildScrollView(
          child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Wallet', style: Theme.of(context).textTheme.headlineLarge,),
            const SizedBox(height: TSizes.md,),
            Text(
              'Here are a list of wallets you have created.',
              style: Theme.of(context).textTheme.labelMedium,
            ),
            const SizedBox(height: TSizes.spaceBtwItems,),
            TListLayout(
                itemCount: walletProvider.wallets.length,
                itemBuilder: (_, index) {
                  final wallet = walletProvider.wallets[index];
                  return WalletDetails(wallet: wallet, provider: walletProvider,);
                }
            ),
          ],
        ),
      );
  }
}

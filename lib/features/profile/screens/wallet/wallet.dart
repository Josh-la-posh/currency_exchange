import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:swappr/common/widgets/buttons/app_bar_widget.dart';
import 'package:swappr/data/provider/wallet_provider.dart';
import 'package:swappr/features/profile/apis/wallet_api.dart';
import 'package:swappr/features/profile/widgets/layout.dart';
import 'package:swappr/utils/constants/sizes.dart';
import '../../../../common/widgets/buttons/floating_button.dart';
import '../../../../data/modules/app_navigator.dart';
import '../../../../data/provider/auth_provider.dart';
import '../../../../utils/constants/colors.dart';
import '../../../../utils/layouts/list_layout.dart';
import '../../widgets/wallet/wallet_details.dart';
import '../../widgets/wallet/wallet_lists.dart';
import 'create_wallet.dart';

class WalletScreen extends StatefulWidget {
  const WalletScreen({super.key});

  @override
  State<WalletScreen> createState() => _WalletScreenState();
}

class _WalletScreenState extends State<WalletScreen> {
  var walletProvider = Provider.of<WalletProvider>(
      AppNavigator.instance.navigatorKey.currentContext as BuildContext);

  var authProvider = Provider.of<AuthProvider>(
      AppNavigator.instance.navigatorKey.currentContext as BuildContext);

  @override
  void initState() {
    if (walletProvider.wallets.isEmpty) {
      WalletServices.instance.getWallets(
          walletProvider: walletProvider);
      // print('Get the wallet ${walletProvider.wallets}');
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ProfileScreenLayout(
      childWidget: const Column(
        children: [
          AppBarWidget(heading: '',),
          SizedBox(height: TSizes.lg,),
          WalletListScreen()
        ],
      ),
      floatingActionButton: TFloatingButton(
        onPressed: (){
          showModalBottomSheet(
              backgroundColor: TColors.white,
              isScrollControlled: true,
              context: context,
              builder: (ctx) => const CreateWalletScreen()
          );
        },
      ),
    );
  }
}


import 'package:flutter/material.dart';
import 'package:swappr/common/widgets/buttons/app_bar_widget.dart';
import 'package:swappr/features/profile/widgets/bank/bank_account_list.dart';
import 'package:swappr/features/profile/widgets/layout.dart';
import 'package:swappr/utils/constants/sizes.dart';
import '../../../../common/widgets/buttons/floating_button.dart';
import '../../../../utils/constants/colors.dart';
import 'create_bank_account.dart';

class BankAccountScreen extends StatefulWidget {
  const BankAccountScreen({super.key});

  @override
  State<BankAccountScreen> createState() => _BankAccountScreenState();
}

class _BankAccountScreenState extends State<BankAccountScreen> {
  // var walletProvider = Provider.of<WalletProvider>(
  //     AppNavigator.instance.navigatorKey.currentContext as BuildContext);
  //
  // var authProvider = Provider.of<AuthProvider>(
  //     AppNavigator.instance.navigatorKey.currentContext as BuildContext);

  @override
  void initState() {
    // if (walletProvider.wallets.isEmpty) {
    //   WalletServices.instance.getWallets(
    //       walletProvider: walletProvider);
    //   // print('Get the wallet ${walletProvider.wallets}');
    // }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ProfileScreenLayout(
      childWidget: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AppBarWidget(heading: '',),
          SizedBox(height: TSizes.lg,),
          BankAccountListScreen()
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


import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:provider/provider.dart';
import 'package:swappr/common/widgets/buttons/app_bar_widget.dart';
import 'package:swappr/features/profile/screens/bank_account/add_bank_account.dart';
import 'package:swappr/features/profile/widgets/bank/bank_account_list.dart';
import 'package:swappr/features/profile/widgets/layout.dart';
import 'package:swappr/utils/constants/sizes.dart';
import '../../../../common/widgets/buttons/floating_button.dart';
import '../../../../data/modules/app_navigator.dart';
import '../../../../data/provider/wallet_provider.dart';
import '../../../../utils/constants/colors.dart';
import '../../../wallet/apis/api.dart';
import 'create_bank_account.dart';

class BankAccountScreen extends StatefulWidget {
  const BankAccountScreen({super.key});

  @override
  State<BankAccountScreen> createState() => _BankAccountScreenState();
}

class _BankAccountScreenState extends State<BankAccountScreen> {
  WalletProvider walletProvider = Provider.of<WalletProvider>(
      AppNavigator.instance.navigatorKey.currentContext as BuildContext,
      listen: false
  );

  @override
  void initState() {
    if (walletProvider.savedBankAccounts.isEmpty) {
      WalletServices.instance.getLocalBank(
          walletProvider: walletProvider,
      );
    }
    if (walletProvider.bankList.isEmpty) {
      WalletServices.instance.getBankList(
          walletProvider: walletProvider);
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ProfileScreenLayout(
      childWidget: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const AppBarWidget(heading: '',),
          const SizedBox(height: TSizes.lg,),
          BankAccountListScreen()
        ],
      ),
      floatingActionButton: TFloatingButton(
        onPressed: (){
          Get.to(() => const AddBankAccountScreen());
        },
      ),
    );
  }
}


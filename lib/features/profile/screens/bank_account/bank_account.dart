import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pouch/features/profile/screens/bank_account/add_bank_account.dart';
import 'package:pouch/features/profile/screens/bank_account/no_bank_account.dart';
import 'package:pouch/utils/constants/sizes.dart';
import 'package:pouch/utils/helpers/helper_functions.dart';
import 'package:pouch/utils/shared/refresh_indicator/refresh_indicator.dart';
import '../../../../common/widgets/buttons/floating_button.dart';
import '../../../../utils/layouts/list_layout.dart';
import '../../../wallet/controller/bank_controller.dart';
import '../../widgets/bank/bank_item.dart';

class BankAccountScreen extends StatelessWidget {
  final BankController bankController = Get.put(BankController());
  @override
  Widget build(BuildContext context) {
    final banks = bankController.bankAccounts;
    if (bankController.bankAccounts.isEmpty) {
      bankController.fetchLocalBank();
    }
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: const Icon(Icons.arrow_back),
          style: IconButton.styleFrom(
            foregroundColor: Colors.grey,
            iconSize: TSizes.iconBackSize,
          ),
          hoverColor: Colors.transparent,
        ),
        title: Text(
          'Bank Accounts',
          style: Theme.of(context).textTheme.titleMedium,
        ),
        centerTitle: true,
      ),
      body: Obx(() {
        if (bankController.isLocalBankLoading.value) {
          return Center(child: CircularProgressIndicator());
        } else {

          if (bankController.bankAccounts.isEmpty) {
            return NoWalletScreen();
          } else {
            return CustomRefreshIndicator(
              onRefresh: () => bankController.fetchLocalBank(),
              child: Container(
                height: THelperFunctions.screenHeight(),
                child: SingleChildScrollView(
                  physics: AlwaysScrollableScrollPhysics(),
                  child: Column(
                    children: [
                      TListLayout(
                        itemCount: banks.length,
                        itemBuilder: (_, index) {
                          final item = banks[index];
                          return BankAccountItem(item: item);
                        },
                      ),
                    ],
                  ),
                ),
              ),
            );
          }
        }
      }),
      floatingActionButton: TFloatingButton(
        onPressed: (){
          Get.to(() => AddBankAccountScreen());
        },
      ),
    );
  }
}


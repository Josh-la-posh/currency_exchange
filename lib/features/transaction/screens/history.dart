import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pouch/features/transaction/controller/transaction_controller.dart';
import 'package:pouch/utils/constants/colors.dart';
import 'package:pouch/utils/constants/sizes.dart';
import 'package:pouch/utils/helpers/helper_functions.dart';
import 'package:pouch/utils/shared/refresh_indicator/refresh_indicator.dart';
import '../../../utils/layouts/list_layout.dart';
import '../widgets/no_transaction.dart';
import '../widgets/transaction_item.dart';

class TransactionHistoryScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    TransactionController controller = Get.put(TransactionController());
    final darkMode = THelperFunctions.isDarkMode(context);
    final backgroundColor = darkMode ? TColors.textPrimaryO40 : Colors.white;
    final screenHeight = THelperFunctions.screenHeight();

    return Scaffold(
      backgroundColor: darkMode ? Colors.black.withOpacity(0.5) : Colors.black.withOpacity(0.01),
      body: Container(
        height: screenHeight - TSizes.bottomNavBar,
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
                color: darkMode ? Color(0xFF2E2E2E).withOpacity(0.1) : Colors.grey[400]!.withOpacity(0.1)
                ),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHeader(context, darkMode),
            const SizedBox(height: 1),
            Expanded(
              child: Container(
                color: backgroundColor,
                child: Obx(() {
                  if (controller.isTransactionLoading.value) {
                    return Center(child: CircularProgressIndicator());
                  } else {
                    return CustomRefreshIndicator(
                      onRefresh: () => controller.fetchTransactions(),
                      child: Container(
                        height: THelperFunctions.screenHeight(),
                        child: SingleChildScrollView(
                          physics: AlwaysScrollableScrollPhysics(),
                          child: Column(
                            children: [
                              controller.transactions.isEmpty
                                  ? const NoTransactionScreen()
                                  : TListLayout(
                                itemCount: controller.transactions.length,
                                itemBuilder: (_, index) {
                                  final item = controller.transactions[index];
                                  return TransactionItem(item: item);
                                  },
                              )
                            ],
                          ),
                        ),
                      ),
                    );
                  }
                }),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context, bool darkMode) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.only(
        top: 50,
        bottom: 10,
        right: TSizes.defaultSpace * 0.8,
        left: TSizes.defaultSpace * 0.8,
      ),
      decoration: BoxDecoration(
        color: darkMode ? TColors.textPrimaryO40 : Colors.white,
        border: Border(
          bottom: BorderSide(
            color: darkMode ? Colors.black : Colors.black.withOpacity(0.1),
          ),
        ),
      ),
      child: Text(
        'Transaction History',
        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
          fontSize: 20,
          fontWeight: TSizes.fontWeightMd,
        ),
      ),
    );
  }
}

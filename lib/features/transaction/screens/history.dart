import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pouch/data/modules/background_task.dart';
import 'package:pouch/data/provider/transaction_provider.dart';
import 'package:pouch/utils/constants/colors.dart';
import 'package:pouch/utils/constants/sizes.dart';
import 'package:pouch/utils/helpers/helper_functions.dart';
import 'package:pouch/utils/shared/refresh_indicator/refresh_indicator.dart';
import '../widgets/transaction_list.dart';

class TransactionHistoryScreen extends StatefulWidget {
  const TransactionHistoryScreen({super.key});

  @override
  State<TransactionHistoryScreen> createState() => _TransactionHistoryScreenState();
}

class _TransactionHistoryScreenState extends State<TransactionHistoryScreen> {
  late final TransactionProvider _transactionProvider;

  @override
  void initState() {
    super.initState();
    _transactionProvider = Provider.of<TransactionProvider>(
      context,
      listen: false,
    );

    if (_transactionProvider.transactions.isEmpty) {
      _fetchTransactions();
    }
  }

  Future<void> _fetchTransactions() async {
    await NoLoaderService.instance.getTransactions(
      transactionProvider: _transactionProvider,
    );
  }

  Future<void> _refreshTransactions() async {
    await _fetchTransactions();
    await Future.delayed(const Duration(seconds: 2));
  }

  @override
  Widget build(BuildContext context) {
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
                child: CustomRefreshIndicator(
                  onRefresh: _refreshTransactions,
                  child: SingleChildScrollView(
                    physics: AlwaysScrollableScrollPhysics(),
                    child: const TransactionList(),
                  ),
                ),
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

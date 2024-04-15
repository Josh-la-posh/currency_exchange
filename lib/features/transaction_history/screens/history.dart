import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:swappr/features/subscription/widgets/subscription_list.dart';
import 'package:swappr/features/transaction_history/widgets/layout.dart';
import 'package:swappr/features/transaction_history/widgets/transaction_list.dart';
import '../../../common/widgets/currencyWidget.dart';

class TransactionHistoryScreen extends StatefulWidget {
  const TransactionHistoryScreen({super.key});

  @override
  State<TransactionHistoryScreen> createState() => _TransactionHistoryScreenState();
}

class _TransactionHistoryScreenState extends State<TransactionHistoryScreen> {
  // @override
  // void initState() {
  //   super.initState();
  //   Future.microtask(() => Provider.of<OfferProvider>(context, listen: false).fetchOffers());
  // }

  @override
  Widget build(BuildContext context) {

    return const TransactionScreenLayout(
      childWidget:SingleChildScrollView(
        child: Column(
          children: [
            TransactionList(),
          ],
        ),
      ),

    );
  }
}


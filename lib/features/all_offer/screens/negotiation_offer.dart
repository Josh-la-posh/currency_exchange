import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:swappr/features/all_offer/widgets/negotiation_list.dart';
import 'package:swappr/features/transaction/widgets/layout.dart';

class NegotiationOfferScreen extends StatefulWidget {
  const NegotiationOfferScreen({super.key});

  @override
  State<NegotiationOfferScreen> createState() => _NegotiationOfferScreenState();
}

class _NegotiationOfferScreenState extends State<NegotiationOfferScreen> {

  @override
  Widget build(BuildContext context) {
    return const TransactionScreenLayout(
      childWidget:SingleChildScrollView(
        child: Column(
          children: [
            NegotiationList(),
          ],
        ),
      ),
    );
  }
}


import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import '../../../common/widgets/custom_shapes/currency_widget_with_back.dart';
import '../widget/negotiation_list.dart';

class NegotiationOfferScreen extends StatefulWidget {
  const NegotiationOfferScreen({super.key});

  @override
  State<NegotiationOfferScreen> createState() => _NegotiationOfferScreenState();
}

class _NegotiationOfferScreenState extends State<NegotiationOfferScreen> {

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            CurrencyWidgetWithBack(),
            NegotiationList(),
          ],
        ),
      ),
    );
  }
}


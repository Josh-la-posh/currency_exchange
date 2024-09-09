import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pouch/utils/helpers/helper_functions.dart';

import '../../../utils/constants/colors.dart';
import '../../../utils/constants/sizes.dart';
import '../../all_offer/models/offer.dart';

class MyNotificationOfferDetail extends StatelessWidget {
  final Rx<OfferEntity>? item = Get.arguments['item'];

  MyNotificationOfferDetail({super.key});

  @override
  Widget build(BuildContext context) {
    final darkMode = THelperFunctions.isDarkMode(context);
    return Scaffold(
      backgroundColor: darkMode ? TColors.textPrimaryO40 : Colors.white,
      appBar: AppBar(
        backgroundColor: darkMode ? TColors.textPrimary.withOpacity(0) : Colors.white,
        surfaceTintColor: darkMode ? TColors.textPrimary.withOpacity(0) : Colors.white,
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
          'Offer Details',
          style: Theme.of(context).textTheme.titleMedium,
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Obx(() {
          final offer = item?.value;
          if (offer == null) {
            return Center(child: Text('No offer available'));
          }

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                children: [
                  _buildDetailRow(
                    context,
                    title: 'I have',
                    value: '${offer.amount} ${offer.debitedCurrency}',
                  ),
                  _buildDetailRow(
                    context,
                    title: 'I need',
                    value: offer.creditedCurrency.toString(),
                  ),
                  _buildDetailRow(
                    context,
                    title: 'Preferred Rate',
                    value:
                    '${THelperFunctions.formatRate(offer.rate.toString())} ${offer.creditedCurrency} // ${offer.debitedCurrency}',
                  ),
                  _buildDetailRow(
                    context,
                    title: 'Status',
                    value: offer.status.toString(),
                    valueStyle: TextStyle(
                      fontWeight: TSizes.fontWeightLg,
                      color: _getStatusColor(offer.status.toString()),
                    ),
                  ),
                  _buildDetailContainer(
                    context,
                    title: 'I have',
                    icon: Icons.settings,
                    value: offer.debitedCurrency.toString(),
                    amount: THelperFunctions.moneyFormatter(offer.amount.toString()),
                    darkMode: darkMode,
                  ),
                  const SizedBox(height: TSizes.defaultSpace),
                  _buildDetailContainer(
                    context,
                    title: 'I get',
                    icon: Icons.settings,
                    value: offer.creditedCurrency.toString(),
                    amount: THelperFunctions.moneyFormatter(
                      THelperFunctions.getStringMultiplication(
                        offer.amount.toString(),
                        offer.rate.toString(),
                      ),
                    ),
                    darkMode: darkMode,
                  ),
                ],
              ),
            ],
          );
        }),
      ),
    );
  }

  Widget _buildDetailRow(BuildContext context, {required String title, required String value, TextStyle? valueStyle}) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: TSizes.defaultSpace),
      height: TSizes.textReviewHeight,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          RichText(
            text: TextSpan(
              style: Theme.of(context).textTheme.labelMedium,
              children: <TextSpan>[
                TextSpan(text: title),
              ],
            ),
          ),
          RichText(
            text: TextSpan(
              style: Theme.of(context).textTheme.labelMedium,
              children: <TextSpan>[
                TextSpan(text: value, style: valueStyle ?? const TextStyle(fontWeight: TSizes.fontWeightLg)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Utility function to get color based on status
  Color _getStatusColor(String status) {
    switch (status) {
      case 'COMPLETED':
        return Colors.green;
      case 'EXPIRED':
        return Colors.red;
      case 'CREATED':
        return Colors.blue;
      default:
        return Colors.yellow;
    }
  }

  // Utility function to build a detail container
  Widget _buildDetailContainer(BuildContext context, {required String title, required IconData icon, required String value, required String amount, required bool darkMode}) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: TSizes.defaultSpace / 2),
      height: TSizes.textReviewHeight,
      decoration: BoxDecoration(
        color: TColors.secondaryBorder30,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 25.0),
            child: RichText(
              text: TextSpan(
                style: Theme.of(context).textTheme.labelSmall,
                children: <TextSpan>[
                  TextSpan(
                    text: title,
                    style: TextStyle(fontSize: 10, color: darkMode ? TColors.white : TColors.primary),
                  ),
                ],
              ),
            ),
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(icon, size: 18, color: TColors.grey),
              const SizedBox(width: 5),
              RichText(
                text: TextSpan(
                  style: Theme.of(context).textTheme.labelMedium,
                  children: <TextSpan>[
                    TextSpan(
                      text: value,
                      style: TextStyle(fontWeight: FontWeight.w700, color: darkMode ? TColors.white : TColors.primary),
                    ),
                  ],
                ),
              ),
              const Spacer(),
              RichText(
                text: TextSpan(
                  style: Theme.of(context).textTheme.labelMedium,
                  children: <TextSpan>[
                    TextSpan(
                      text: amount,
                      style: TextStyle(fontWeight: FontWeight.w700, color: darkMode ? TColors.white : TColors.primary),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

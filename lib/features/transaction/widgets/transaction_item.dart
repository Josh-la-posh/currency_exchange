import 'package:flutter/material.dart';
import 'package:pouch/features/transaction/models/transaction_entity.dart';
import 'package:pouch/features/transaction/widgets/transaction_details.dart';
import 'package:pouch/utils/constants/image_strings.dart';
import 'package:pouch/utils/helpers/helper_functions.dart';
import '../../../utils/constants/colors.dart';
import '../../../utils/constants/sizes.dart';
import '../icons/svg.dart';

class TransactionItem extends StatelessWidget {
  final TransactionEntity item;

  const TransactionItem({
    super.key,
    required this.item,
  });

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final statusColor = _getStatusColor(item.status);
    final formattedAmount = _formatAmount(context, item, width);
    final rateInfo = _getRateInfo(item, width);
    final transactionTime = _getTransactionTime(item);

    return ListTile(
      tileColor: Colors.transparent,
      contentPadding: EdgeInsets.symmetric(
        vertical: 5,
        horizontal: TSizes.defaultSpace * 0.8,
      ),
      onTap: () {
        showModalBottomSheet(
          isScrollControlled: true,
          context: context,
          builder: (cdx) => TransactionDetails(item: item),
        );
      },
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _buildTransactionInfo(context, width, formattedAmount, statusColor),
          _buildRateAndTime(rateInfo, transactionTime),
        ],
      ),
    );
  }






  Column _buildTransactionInfo(BuildContext context, double width, RichText formattedAmount, Color statusColor) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.only(top: 5),
              child: item.transactionType == 'Exchange' 
                  ? TransactionIcon(height: 18) 
                  : item.transactionType == 'Debit'
                  ? Icon(Icons.keyboard_double_arrow_down_outlined, size: 22, color: Color(0xFFFF0944),)
                  : Icon(Icons.keyboard_double_arrow_up_outlined, size: 22, color: Color(0xFF04FF69),),
            ),
            const SizedBox(width: TSizes.md),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                formattedAmount,
                Text(
                  item.status ?? '',
                  style: TextStyle(
                    fontSize: width > 360 ? 10 : 9,
                    fontWeight: FontWeight.w700,
                    color: statusColor,
                  ),
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }

  Column _buildRateAndTime(String rateInfo, String transactionTime) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        if (rateInfo.isNotEmpty) Text(rateInfo, style: TextStyle(
          fontSize: THelperFunctions.screenWidth() > 360 ? 14 : 12,
          fontWeight: TSizes.fontWeightLg,
        ),),
        Text(
          transactionTime,
          style: const TextStyle(
            color: TColors.primary,
            fontSize: 10,
            fontWeight: FontWeight.w700,
          ),
        ),
      ],
    );
  }

  RichText _formatAmount(BuildContext context, TransactionEntity item, double width) {
    return RichText(
      text: TextSpan(
        style: Theme.of(context).textTheme.titleSmall,
        children: [
          if (item.rate != null)
            TextSpan(
              text: '${THelperFunctions.moneyFormatter(item.debitedAmount.toString())}',
              style: TextStyle(
                fontSize: width > 360 ? 14 : 12,
                fontWeight: TSizes.fontWeightLg,
              ),
            ),
          if (item.rate != null)
          TextSpan(
            text: ' ${item.debitedCurrency} ',
            style: TextStyle(
              fontSize: width > 360 ? 14 : 12,
              fontWeight: TSizes.fontWeightLg,
            ),
          ),
          if (item.rate != null)
            WidgetSpan(
              child: Image.asset(TImages.handIcon, height: 15, color: TColors.primary),
            ),
          TextSpan(
            text: '${THelperFunctions.moneyFormatter(item.amount.toString())} ',
            style: TextStyle(
              fontSize: width > 360 ? 14 : 12,
              fontWeight: TSizes.fontWeightLg,
            ),
          ),
          TextSpan(
            text: item.creditedCurrency ?? item.debitedCurrency,
            style: TextStyle(
              fontSize: width > 360 ? 14 : 12,
              fontWeight: TSizes.fontWeightLg,
            ),
          ),
        ],
      ),
    );
  }

  String _getRateInfo(TransactionEntity item, double width) {
    if (item.rate == null) return '';
    return '${(THelperFunctions.formatRate(item.rate.toString()))} ${item.debitedCurrency} // ${item.creditedCurrency}';
  }

  String _getTransactionTime(TransactionEntity item) {
    return '${THelperFunctions.getFormattedDate(item.createdDate.toString())} ${THelperFunctions.getFormattedTime(item.createdDate.toString())}';
  }

  Color _getStatusColor(String? status) {
    switch (status?.toLowerCase()) {
      case 'in progress':
        return TColors.golden;
      case 'successful':
      case 'success':
        return TColors.primary;
      default:
        return TColors.danger;
    }
  }
}

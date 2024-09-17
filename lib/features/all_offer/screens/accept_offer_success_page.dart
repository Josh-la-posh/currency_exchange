import 'package:flutter/material.dart';
import 'package:pouch/common/widgets/custom_time_line.dart';
import 'package:pouch/utils/helpers/helper_functions.dart';
import 'package:pouch/utils/layouts/list_layout.dart';
import '../../../utils/constants/colors.dart';
import '../widgets/success_page.dart';

class AcceptOfferSuccessPage extends StatelessWidget {
  final String amount;
  final String creditedCurrency;
  const AcceptOfferSuccessPage({super.key, required this.amount, required this.creditedCurrency});

  @override
  Widget build(BuildContext context) {
    final darkMode = THelperFunctions.isDarkMode(context);
    return Scaffold(
        body: SuccessScreenWidget(
          text: 'You have successfully being credited with ${amount} ${creditedCurrency}.',
          child: TListLayout(
              itemCount: 3,
              itemBuilder: (_, index) => MyTimeLine(
                isFirst: index == 0 ? true : false,
                isLast: index == 2 ? true : false,
                isDone: index == 2 ? false : true,
                startChild: Container(
                  padding: const EdgeInsets.only(bottom: 17),
                  child: RichText(
                      text: TextSpan(
                          style: Theme.of(context).textTheme.labelSmall,
                          children: <TextSpan> [
                            TextSpan(
                                text: THelperFunctions.getFormattedTime(DateTime.now().toString()),
                                style: TextStyle(
                                    color: darkMode ? Colors.white : TColors.textPrimary.withOpacity(0.6),
                                    height: 1.5
                                )
                            ),
                          ]
                      )
                  ),
                ),
                endChild: Container(
                    padding: const EdgeInsets.only(bottom: 17),
                    child: Text(
                      index == 0
                          ? 'You accepted this offer'
                          : index == 1
                          ? 'We received your funds'
                          : 'Your $creditedCurrency $amount is on its way to you',
                      style: Theme.of(context).textTheme.labelMedium,)
                ),
              )
          ),
        )
    );
  }
}


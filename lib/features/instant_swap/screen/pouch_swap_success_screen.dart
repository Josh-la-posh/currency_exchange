import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pouch/utils/constants/colors.dart';

import '../../../common/widgets/custom_time_line.dart';
import '../../../utils/layouts/list_layout.dart';
import '../../all_offer/widgets/success_page.dart';

class PouchSwapSuccessScreen extends StatelessWidget {
  const PouchSwapSuccessScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SuccessScreenWidget(
      onTap: () {Get.back();},
      text: 'You have successfully swapped',
      child: TListLayout(
          itemCount: 4,
          itemBuilder: (_, index) => MyTimeLine(
            isFirst: index == 0 ? true : false,
            isLast: index == 3 ? true : false,
            isDone: index == 4 ? false : true,
            startChild: Container(
              padding: const EdgeInsets.only(bottom: 17),
              child: SizedBox(),
              // child: RichText(
              //     text: TextSpan(
              //         style: Theme.of(context).textTheme.labelSmall,
              //         children: <TextSpan> [
              //           TextSpan(
              //               text: THelperFunctions.getFormattedTime(DateTime.now().toString()),
              //               style: TextStyle(
              //                   height: 1.5
              //               )
              //           ),
              //         ]
              //     )
              // ),
            ),
            endChild: Container(
              color: Colors.white,
                padding: const EdgeInsets.only(bottom: 25, left: 20),
                margin: EdgeInsets.only(right: 20),
                child: RichText(
                  text: index == 0 ?
                  TextSpan(
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 14,
                      fontWeight: FontWeight.w500
                    ),
                    children: [
                      TextSpan(
                        text: 'Amount Swapped: '
                      ),
                      TextSpan(
                        text: '\$20.00',
                        style: TextStyle(color: TColors.primary)
                      )
                    ]
                  ) :
                  index == 1 ? TextSpan(
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 14,
                          fontWeight: FontWeight.w500
                      ),
                      children: [
                        TextSpan(
                            text: 'Pouch Rate: '
                        ),
                        TextSpan(
                            text: '1 USD ',
                            style: TextStyle(color: TColors.primary)
                        ),
                        WidgetSpan(child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(width: 25),
                            Icon(Icons.arrow_forward, color: TColors.primary, size: 22,),
                            SizedBox(width: 25,),
                          ],
                        )),
                        TextSpan(
                            text: ' NGN 1,560',
                            style: TextStyle(color: TColors.primary)
                        ),
                      ]
                  ) :
                  index == 2 ? TextSpan(
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 14,
                          fontWeight: FontWeight.w500
                      ),
                      children: [
                        TextSpan(
                            text: 'Amount Debited: '
                        ),
                        TextSpan(
                            text: '\$20.00',
                            style: TextStyle(color: TColors.primary)
                        )
                      ]
                  ) :
                  TextSpan(
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 14,
                          fontWeight: FontWeight.w500
                      ),
                      children: [
                        TextSpan(
                            text: 'Total Amount Credited: '
                        ),
                        TextSpan(
                            text: 'NGN 31,000',
                            style: TextStyle(color: TColors.primary)
                        )
                      ]
                  ),
                ),
                // child: Text(
                //   index == 0
                //       ? 'You accepted this offer'
                //       : index == 1
                //       ? 'We received your funds'
                //       : 'Your ${THelperFunctions.moneyFormatter(item!.amount.toString())} ${item!.creditedCurrency} is on its way to you',
                //   style: Theme.of(context).textTheme.labelMedium,)
            ),
          )
      ),
    );
  }
}

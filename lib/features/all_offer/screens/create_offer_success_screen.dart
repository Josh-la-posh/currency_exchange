import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:pouch/common/widgets/custom_time_line.dart';
import 'package:pouch/data/provider/offer_provider.dart';
import 'package:pouch/utils/constants/enums.dart';
import 'package:pouch/utils/helpers/helper_functions.dart';
import 'package:pouch/utils/layouts/list_layout.dart';
import '../../../utils/constants/colors.dart';
import '../widgets/success_page.dart';

class CreateOfferSuccessPage extends StatelessWidget {
  const CreateOfferSuccessPage({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<OfferProvider>(context);
    return Scaffold(
      body: SuccessScreenWidget(
        text: 'You have successfully created an offer',
          child: TListLayout(
              itemCount: 4,
              itemBuilder: (_, index) => MyTimeLine(
                  isFirst: index == 0 ? true : false,
                  isLast: index == 3 ? true : false,
                  isDone: index == 3 ? false : true,
                startChild: Container(
                  padding: const EdgeInsets.only(bottom: 17),
                  child: RichText(
                      text: TextSpan(
                          style: Theme.of(context).textTheme.labelSmall,
                          children: <TextSpan> [
                            TextSpan(
                                text: index == 3
                                    ? ''
                                    : THelperFunctions.getFormattedTime(provider.offerResponse!.createdDate) ==
                                        THelperFunctions.getFormattedTime(DateTime.now().toString())
                                          ? 'Now'
                                          : THelperFunctions.getFormattedTime(provider.offerResponse!.createdDate),
                                style: TextStyle(
                                    // color: TColors.textPrimary.withOpacity(0.6),
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
                          ? 'You created this offer'
                          : index == 1
                          ? 'We received your funds'
                          : index == 2
                          ? 'Waiting for a match'
                          : 'Your funds is on its way to you',
                      style: Theme.of(context).textTheme.labelMedium,)
                ),
              )
          ),
      )
    );
  }
}


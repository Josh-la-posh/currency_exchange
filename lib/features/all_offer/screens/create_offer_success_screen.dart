import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:swappr/common/widgets/custom_time_line.dart';
import 'package:swappr/utils/layouts/list_layout.dart';
import '../../../utils/constants/colors.dart';
import '../widgets/success_page.dart';

class CreateOfferSuccessPage extends StatelessWidget {
  const CreateOfferSuccessPage({super.key});

  @override
  Widget build(BuildContext context) {
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
                                text: index == 3 ? '': '11:23',
                                style: TextStyle(
                                    color: TColors.textPrimary.withOpacity(0.6),
                                    height: 1.5
                                )
                            ),
                          ]
                      )
                  ),
                ),
                endChild: Container(
                  padding: const EdgeInsets.only(bottom: 17),
                    child: Text('You created this offer', style: Theme.of(context).textTheme.labelMedium,)
                ),
              )
          ),
      )
    );
  }
}


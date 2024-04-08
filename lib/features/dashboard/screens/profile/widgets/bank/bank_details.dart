import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:swappr/common/widgets/divider.dart';
import 'package:swappr/utils/constants/colors.dart';
import 'package:swappr/utils/constants/sizes.dart';

import '../../../../../../common/widgets/buttons/delete_button.dart';

class BankDetails extends StatelessWidget {
  const BankDetails({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: TSizes.textReviewHeight * 1.2,
          child: Slidable(
            key: const ValueKey(0),
            endActionPane: ActionPane(
                extentRatio: 0.2,
                motion: const ScrollMotion(),
                // dismissible: DismissiblePane(onDismissed: (){}),
                children: [
                  SlidableAction(
                    onPressed: ((context){
                      print('I am working');
                    }),
                    backgroundColor: TColors.danger,
                    icon: Icons.delete,
                    // label: 'Delete',

                  ),
                ]
            ),
            child: ListTile(
              title: Row(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Natwest Account',
                        style: Theme.of(context).textTheme.labelMedium,
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            '60-00-08',
                            style: Theme.of(context).textTheme.labelSmall,
                          ),
                          const SizedBox(width: TSizes.md,),
                          Container(
                            height: 5,
                            width: 5,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              color: const Color(0XFFC4C4C4),
                            ),
                          ),
                          const SizedBox(width: TSizes.md,),
                          Text(
                            '445347697',
                            style: Theme.of(context).textTheme.labelSmall,
                          ),
                        ],
                      )

                    ],
                  )
                ],
              ),
            ),
          ),
        ),
        const DividerWidget()
      ],
    );
  }
}

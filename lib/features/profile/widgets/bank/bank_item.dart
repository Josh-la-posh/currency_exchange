import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:swappr/utils/constants/image_strings.dart';
import 'package:swappr/utils/constants/texts.dart';

import '../../../../utils/constants/colors.dart';
import '../../../../utils/constants/sizes.dart';

class BankAccountItem extends StatelessWidget {
  const BankAccountItem({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: TSizes.textReviewHeight * 1.4,
          // padding: const EdgeInsets.only(left: TSizes.defaultSpace / 1.5),
          child: Slidable(
            key: const ValueKey(0),
            endActionPane: ActionPane(
                extentRatio: 0.2,
                motion: const ScrollMotion(),
                // dismissible: DismissiblePane(onDismissed: (){}),
                children: [
                  Builder(
                      builder: (cont) {
                        return SizedBox(
                          height: 68,
                          width: 60,
                          child: ElevatedButton(
                              onPressed: () {
                                print('I am working');
                                Slidable.of(cont)!.close();
                              },
                              style: ElevatedButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10)
                                ),
                                backgroundColor: TColors.danger,
                                padding: EdgeInsets.all(0)
                              ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                SizedBox(
                                    height: 24,
                                    width: 24,
                                    child: Image(image: AssetImage(TImages.trashIcon))
                                ),
                                Text(
                                  'Delete',
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontFamily: TTexts.fontFamily,
                                    fontWeight: FontWeight.w400,
                                    color: Colors.white
                                  ),
                                )
                              ],
                            ),
                          ),
                        );
                      }
                  )
                  // SlidableAction(
                  //   onPressed: ((context){}),
                  //   backgroundColor: TColors.danger,
                  //   // label: 'Delete',
                  // ),
                ]
            ),
            child: ListTile(
              dense: true,
              contentPadding: const EdgeInsets.only(left: TSizes.defaultSpace / 1.5, top: 0, bottom: 0, right: TSizes.defaultSpace / 1.5),
              title: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    height: 27,
                    width: 27,
                    color: Colors.black,
                  ),
                  SizedBox(width: 10,),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      RichText(
                          text: TextSpan(
                              style: Theme.of(context).textTheme.labelMedium,
                              children: <TextSpan> [
                                TextSpan(
                                  text: 'Natwest Account',
                                )
                              ]
                          )
                      ),
                      RichText(
                          text: TextSpan(
                              style: Theme.of(context).textTheme.labelSmall,
                              children: <TextSpan> [
                                TextSpan(
                                  text: '60-00-08 * 445347697',
                                )
                              ]
                          )
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
        Container(
          height: 1,
          color: Color(0XFFD9D9D9),
        )
      ],
    );
  }
}

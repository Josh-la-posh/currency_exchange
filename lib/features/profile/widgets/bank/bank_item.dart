import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import 'package:pouch/features/wallet/controller/wallet_controller.dart';
import 'package:pouch/features/wallet/models/get_bank_account.dart';
import 'package:pouch/utils/constants/image_strings.dart';
import 'package:pouch/utils/constants/texts.dart';

import '../../../../utils/constants/colors.dart';
import '../../../../utils/constants/sizes.dart';

class BankAccountItem extends StatelessWidget {
  final GetBankAccountModel item;
  BankAccountItem({Key? key, required this.item}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    WalletController walletController = Get.find();
    return Column(
      children: [
        SizedBox(
          height: TSizes.textReviewHeight * 1.4,
          child: Slidable(
            key: ValueKey(item.id),
            endActionPane: ActionPane(
                extentRatio: 0.2,
                motion: const ScrollMotion(),
                children: [
                  Builder(
                      builder: (cont) {
                        return SizedBox(
                          height: 68,
                          width: 60,
                          child: ElevatedButton(
                              onPressed: () {
                                Slidable.of(cont)!.close();
                                walletController.deleteLocalBankAccount(id: item.id.toString());
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
                ]
            ),
            child: ListTile(
              dense: true,
              contentPadding: const EdgeInsets.only(left: TSizes.defaultSpace / 1.5, top: 0, bottom: 0, right: TSizes.defaultSpace / 1.5),
              title: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
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
                                  text: '${item.bankName}',
                                )
                              ]
                          )
                      ),
                      RichText(
                          text: TextSpan(
                              style: Theme.of(context).textTheme.labelSmall,
                              children: <TextSpan> [
                                TextSpan(
                                  text: '${item.accountNumber}',
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

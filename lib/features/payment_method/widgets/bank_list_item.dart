import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pouch/features/wallet/models/bank_list.dart';
import 'package:pouch/utils/constants/image_strings.dart';

import '../../../utils/helpers/helper_functions.dart';
import '../../wallet/controller/bank_controller.dart';

class BankListItem extends StatelessWidget {
  final BankListModel bankDetail;
  BankListItem({super.key, required this.bankDetail});

  @override
  Widget build(BuildContext context) {
    final BankController bankController = Get.find();
    final darkMode = THelperFunctions.isDarkMode(context);
    return ListTile(
        onTap: () {
          bankController.selectedBank(bankDetail);
          bankController.filteredBanks.clear();
        },
        contentPadding: const EdgeInsets.symmetric(horizontal: 0),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
              width: THelperFunctions.screenWidth() * 0.7,
              child: RichText(
                  text: TextSpan(
                      style: TextStyle(
                          color: darkMode ? Colors.white : Colors.black,
                          fontWeight: FontWeight.w500,
                          fontSize: 12,
                          fontFamily: 'Roboto'
                      ),
                      children: <TextSpan> [
                        TextSpan(
                          text: bankDetail.name,
                        ),
                      ]
                  )
              ),
            ),
            if (bankController.selectedBank.value == bankDetail)
            const SizedBox(
                height: 36,
                width: 36,
                child: Image(image: AssetImage(TImages.walletCheck))
            )
          ],
        ),
      );
  }
}

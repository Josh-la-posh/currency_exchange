import 'package:flutter/material.dart';
import 'package:pouch/data/provider/wallet_provider.dart';
import 'package:pouch/features/wallet/models/bank_list.dart';
import 'package:pouch/utils/constants/image_strings.dart';
import 'package:pouch/utils/constants/sizes.dart';

import '../../../utils/helpers/helper_functions.dart';

class BankListItem extends StatelessWidget {
  final BankListModel bankDetail;
  final WalletProvider walletProvider;
  const BankListItem({super.key, required this.bankDetail, required this.walletProvider});

  @override
  Widget build(BuildContext context) {
    final darkMode = THelperFunctions.isDarkMode(context);
    return ListTile(
        onTap: () {
          walletProvider.setSelectedBank(bankDetail);
          walletProvider.filteredBanks = [];
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
            if (walletProvider.selectedBank == bankDetail)
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

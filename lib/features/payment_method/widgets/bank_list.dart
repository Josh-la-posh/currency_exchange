import 'package:flutter/material.dart';
import 'package:swappr/features/payment_method/widgets/bank_list_item.dart';
import 'package:swappr/utils/helpers/helper_functions.dart';

import '../../../data/provider/wallet_provider.dart';
import '../../../utils/constants/colors.dart';
import '../../../utils/constants/sizes.dart';

class BankList extends StatelessWidget {
  final WalletProvider walletProvider;
  const BankList({super.key, required this.walletProvider});

  @override
  Widget build(BuildContext context) {
    final darkMode = THelperFunctions.isDarkMode(context);
    return Column(
      children: [
        Container(
            width: double.infinity,
            alignment: Alignment.center,
            // padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
            decoration: BoxDecoration(
                borderRadius: const BorderRadius.all(Radius.circular(10)),
                boxShadow: [
                  BoxShadow(
                      color: TColors.black.withOpacity(0.1),
                      offset: const Offset(1.32,1.87),
                      blurRadius: 1.94,
                      spreadRadius: 1.94
                  ),
                  BoxShadow(
                      color: const Color(0xFFFDF6FF).withOpacity(0.5),
                      offset: const Offset(0.0,0.0),
                      blurRadius: 0,
                      spreadRadius: 0
                  ),
                  BoxShadow(
                      color: Colors.white.withOpacity(0.8),
                      offset: const Offset(0,0.0),
                      blurRadius: 1.8,
                      spreadRadius: 0
                  ),
                ]
            ),
            child: TextField(
              decoration: const InputDecoration(
                  prefixIcon: Icon(Icons.search),
                  hintText: 'Search Bank'
              ),
              style: Theme.of(context).textTheme.labelMedium,
              onChanged: (text) {
                walletProvider.filterBanks(text);
              },
            )
        ),
        const SizedBox(height: TSizes.defaultSpace,),

        if (walletProvider.filteredBanks.length > 1)
        SizedBox(
          height: THelperFunctions.screenHeight() * 0.4,
          child: ListView.builder(
              itemCount: walletProvider.filteredBanks.length,
              shrinkWrap: true,
              itemBuilder: (_, index) {
                final bankDetail = walletProvider.filteredBanks[index];
                return BankListItem(bankDetail: bankDetail, walletProvider: walletProvider,);
              }
          ),
        ),
        const SizedBox(height: TSizes.defaultSpace,),
        if (walletProvider.selectedBank?.name != null)
        Container(
          width: double.infinity,
          alignment: Alignment.centerLeft,
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
          decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(Radius.circular(10)),
              boxShadow: [
                BoxShadow(
                    color: TColors.black.withOpacity(0.1),
                    offset: const Offset(1.32,1.87),
                    blurRadius: 1.94,
                    spreadRadius: 1.94
                ),
                BoxShadow(
                    color: const Color(0xFFFDF6FF).withOpacity(0.5),
                    offset: const Offset(0.0,0.0),
                    blurRadius: 0,
                    spreadRadius: 0
                ),
                BoxShadow(
                    color: Colors.white.withOpacity(0.8),
                    offset: const Offset(0,0.0),
                    blurRadius: 1.8,
                    spreadRadius: 0
                ),
              ]
          ),
          child:
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              RichText(
                  text: TextSpan(
                      style: TextStyle(
                          color: darkMode ? Colors.white : Colors.black,
                          fontWeight: FontWeight.w600,
                          fontSize: 9,
                          fontFamily: 'Roboto'
                      ),
                      children: const <TextSpan> [
                        TextSpan(
                          text: 'Bank Name',
                        ),
                      ]
                  )
              ),
              RichText(
                  text: TextSpan(
                      style: TextStyle(
                          color: darkMode ? Colors.white : Colors.black,
                          fontWeight: FontWeight.w400,
                          fontSize: 14,
                          fontFamily: 'Roboto'
                      ),
                      children: <TextSpan> [
                        TextSpan(
                          text: walletProvider.selectedBank!.name.toString(),
                        ),
                      ]
                  )
              ),
            ],
          ),
        ),
      ],
    );
  }
}

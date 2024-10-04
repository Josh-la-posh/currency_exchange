import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pouch/features/payment_method/widgets/bank_list_item.dart';
import 'package:pouch/features/wallet/controller/add_bank_controller.dart';
import 'package:pouch/utils/helpers/helper_functions.dart';
import '../../../utils/constants/colors.dart';
import '../../../utils/constants/sizes.dart';

class BankList extends StatelessWidget {
  BankList({super.key});

  @override
  Widget build(BuildContext context) {
    AddBankController addBankController = Get.find();
    final darkMode = THelperFunctions.isDarkMode(context);
    return Obx(() => Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Search bar
        if (addBankController.walletController.bankAccountDetails.value.account_name == null)
          Container(
              width: double.infinity,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                  color: darkMode ? TColors.timeLineBorder : Colors.transparent,
                  borderRadius: const BorderRadius.all(Radius.circular(10)),
                  boxShadow: [
                    BoxShadow(
                        color: darkMode ? TColors.black : TColors.black.withOpacity(0.1),
                        offset: const Offset(1.32,1.87),
                        blurRadius: 1.94,
                        spreadRadius: 1.94
                    ),
                    BoxShadow(
                        color: darkMode ? TColors.black : Color(0xFFFDF6FF).withOpacity(0.5),
                        offset: const Offset(0.0,0.0),
                        blurRadius: 0,
                        spreadRadius: 0
                    ),
                    BoxShadow(
                        color: darkMode ? TColors.black : Colors.white.withOpacity(0.8),
                        offset: const Offset(0,0.0),
                        blurRadius: 1.8,
                        spreadRadius: 0
                    ),
                  ]
              ),
              child: TextField(
                decoration:  InputDecoration(
                    prefixIcon: Icon(
                      Icons.search,
                      color: darkMode ? TColors.white.withOpacity(0.7) : TColors.textPrimaryO80,
                    ),
                    hintText: 'Search bank ...'
                ),
                style: Theme.of(context).textTheme.labelMedium,
                onChanged: (text) => addBankController.walletController.filterBanks(text),
              )
          ),


        if (addBankController.walletController.bankAccountDetails.value.account_number == null)
          const SizedBox(height: TSizes.sm,),

        // Error text
        Visibility(
          visible: addBankController.showErrorText.value,
          child: RichText(
              textAlign: TextAlign.center,
              text: TextSpan(
                  style: Theme.of(context).textTheme.labelSmall,
                  children:  const <TextSpan> [
                    TextSpan(
                        text: 'Please enter your bank provider here',
                        style: TextStyle(fontSize: 10, color: TColors.danger)
                    )
                  ]
              )
          ),
        ),

        // Bank list display

        if (addBankController.walletController.filteredBanks.length > 0)
          SizedBox(
            child: ListView.builder(
                itemCount: addBankController.walletController.filteredBanks.length,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (_, index) {
                  final bankDetail = addBankController.walletController.filteredBanks[index];
                  return BankListItem(bankDetail: bankDetail);
                }
            ),
          ),
        const SizedBox(height: TSizes.defaultSpace,),

        // Bank name display

        if (addBankController.walletController.selectedBank.value.name != null)
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              RichText(
                  text: TextSpan(
                      style: TextStyle(
                          color: darkMode ? Colors.white : Colors.black,
                          fontWeight: FontWeight.w600,
                          fontSize: 12,
                          fontFamily: 'Roboto'
                      ),
                      children: const <TextSpan> [
                        TextSpan(
                          text: 'Bank Name',
                        ),
                      ]
                  )
              ),
              const SizedBox(height: 10,),
              Container(
                height: 48,
                width: double.infinity,
                alignment: Alignment.centerLeft,
                padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                decoration: BoxDecoration(
                    color: darkMode ? TColors.timeLineBorder : Color(0xFFFDF6FF).withOpacity(0.5),
                    borderRadius: const BorderRadius.all(Radius.circular(8)),
                    border: Border.all(
                        color: darkMode ? TColors.secondaryBorder30 : Colors.transparent
                    ),
                    boxShadow: [
                      BoxShadow(
                          color: darkMode ? Colors.black : TColors.black.withOpacity(0.1),
                          offset: const Offset(1.32,1.87),
                          blurRadius: 1.94,
                          spreadRadius: 1.94
                      ),
                      BoxShadow(
                          color: darkMode ? Colors.black :  Color(0xFFFDF6FF).withOpacity(0.5),
                          offset: const Offset(0.0,0.0),
                          blurRadius: 0,
                          spreadRadius: 0
                      ),
                      BoxShadow(
                          color: darkMode ? Colors.black : Colors.white.withOpacity(0.8),
                          offset: const Offset(0,0.0),
                          blurRadius: 1.8,
                          spreadRadius: 0
                      ),
                    ]
                ),
                child:
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
                            text: addBankController.walletController.selectedBank.value.name,
                          ),
                        ]
                    )
                ),
              ),
            ],
          ),
      ],
    ));
  }
}

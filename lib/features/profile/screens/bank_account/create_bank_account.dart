import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:pouch/common/widgets/buttons/elevated_button.dart';
import 'package:pouch/data/provider/wallet_provider.dart';
import 'package:pouch/utils/layouts/bottom_sheet_widget.dart';
import '../../../../utils/constants/colors.dart';
import '../../../../utils/constants/enums.dart';

class CreateWalletScreen extends StatelessWidget {
  const CreateWalletScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();

    return Consumer<WalletProvider>(
      builder: (context, provider, _) {
        return HalfBottomSheetWidget(
            title: 'Create wallet',
            child: Form(
              key: formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Select the wallet you want to create below',
                      style: Theme.of(context).textTheme.labelMedium,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              // width: 120,
                              child: DropdownButton(
                                padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 8),
                                dropdownColor: Colors.white,
                                focusColor: Colors.white,
                                autofocus: false,
                                isExpanded: false,
                                value: provider.selectedCurrency,
                                underline: const SizedBox(),
                                icon: RotatedBox(
                                  quarterTurns: 3,
                                  child: Padding(
                                    padding: const EdgeInsets.only(top: 50),
                                    child: Icon(
                                      Icons.arrow_back_ios_rounded,
                                      size: 12,
                                      color: TColors.textPrimaryO80,
                                    ),
                                  ),
                                ),
                                onChanged: (Currency? newValue) {
                                   provider.setSelectedCurrency(newValue!);
                                },
                                items: [
                                  for (final currency in provider.currencies)
                                    DropdownMenuItem<Currency>(
                                      value: currency,
                                      child: SizedBox(
                                        child: Padding(
                                          padding: const EdgeInsets.only(left: 0),
                                          child: Row(
                                            children: [
                                              // SizedBox(
                                              //     width: 30,
                                              //     height: 30,
                                              //     child: Image(image: AssetImage(
                                              //         currency == 'NGN'
                                              //             ? TImages.ngnIcon
                                              //             : TImages.gbpIcon
                                              //     ))
                                              // ),
                                              Text(
                                                getCurrencyName(currency),
                                                style: Theme.of(context).textTheme.labelMedium,
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 20,
                              child: Visibility(
                                visible: provider.showErrorText,
                                  child: Container(
                                    child: Text(
                                        'Select a currency',
                                      style: Theme.of(context).textTheme.labelSmall,
                                    ),)
                              ),
                            )
                          ],
                        ),

                        SizedBox(
                          child: TElevatedButton(
                              onTap: (){
                                if (formKey.currentState!.validate()) {
                                  formKey.currentState!.save();
                                  if (provider.selectedCurrency == Currency.NGN) {
                                    provider.showErrorMessage();
                                  } else {
                                    Get.back();
                                  }
                                }
                              },
                              buttonText: 'Create'
                          ),
                        )
                      ],
                    )
                  ],
                )
            )
        );
      }
    );
  }
}

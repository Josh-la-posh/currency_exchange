import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pouch/features/wallet/models/get_bank_account.dart';
import '../../../utils/constants/colors.dart';
import '../../../utils/constants/image_strings.dart';
import '../../../utils/constants/sizes.dart';
import '../../../features/wallet/controller/wallet_controller.dart';

class AccountWidget extends StatelessWidget {
  final bool darkMode;
  final GetBankAccountModel item;

  AccountWidget({
    Key? key,
    required this.darkMode,
    required this.item,
  }) : super(key: key);

  final WalletController walletController = Get.find<WalletController>();

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    return Column(
      children: [
        Container(
          width: double.infinity,
          padding: EdgeInsets.only(
            top: 12,
            bottom: 12,
            right: width > 400 ? 20 : 0,
            left: width > 400 ? TSizes.defaultSpace * 1.5 : 10,
          ),
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(10)),
            boxShadow: [
              BoxShadow(
                color: TColors.black.withOpacity(0.3),
                offset: const Offset(2.3, 3.87),
              ),
              BoxShadow(
                color: Colors.white.withOpacity(0.85),
                offset: const Offset(0.0, 0.0),
                blurRadius: 0,
                spreadRadius: 0,
              ),
              BoxShadow(
                color: const Color(0xFFD0CDE1).withOpacity(0.31),
                offset: const Offset(0.0, 0.0),
                blurRadius: 0,
                spreadRadius: 0,
              ),
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Image(image: AssetImage(TImages.withdrawIcon)),
                  const SizedBox(width: 10),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      RichText(
                        text: TextSpan(
                          style: TextStyle(
                            color: Colors.black.withOpacity(0.43),
                            fontWeight: FontWeight.w600,
                            fontSize: width > 400 ? 18 : 14,
                            fontFamily: 'Roboto',
                          ),
                          children: <TextSpan>[
                            TextSpan(
                              text: item.bankName,
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: TSizes.md),
                      SizedBox(
                        width: width * 0.2,
                        child: FittedBox(
                          fit: BoxFit.fill,
                          child: RichText(
                            text: TextSpan(
                              style: TextStyle(
                                color: Colors.black.withOpacity(0.43),
                                fontWeight: FontWeight.w600,
                                fontSize: 16,
                                fontFamily: 'Roboto',
                              ),
                              children: <TextSpan>[
                                TextSpan(
                                  text: item.accountNumber,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              Obx(() => Checkbox(
                value: walletController.selectedWithdrawalAccount.value.id == item.id,
                onChanged: (val) {
                  if (val != null && val) {
                    walletController.saveWithdrawalBank(item);
                  }
                },
              )),
            ],
          ),
        ),
        const SizedBox(height: 20),
      ],
    );
  }
}

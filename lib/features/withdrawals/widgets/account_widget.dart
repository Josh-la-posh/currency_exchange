import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pouch/data/provider/wallet_provider.dart';
import 'package:pouch/features/wallet/models/get_bank_account.dart';

import '../../../data/modules/app_navigator.dart';
import '../../../utils/constants/colors.dart';
import '../../../utils/constants/image_strings.dart';
import '../../../utils/constants/sizes.dart';

class AccountWidget extends StatefulWidget {
  final bool darkMode;
  final GetBankAccountModel item;
  const AccountWidget({
    super.key,
    required this.darkMode, required this.item
  });

  @override
  State<AccountWidget> createState() => _AccountWidgetState();
}

class _AccountWidgetState extends State<AccountWidget> {
  var provider = Provider.of<WalletProvider>(
      AppNavigator.instance.navigatorKey.currentContext as BuildContext,
      listen: false);
  bool isSelected = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: double.infinity,
          padding: const EdgeInsets.only(top: 12, bottom: 12, right: 20, left: TSizes.defaultSpace * 1.5),
          decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(Radius.circular(10)),
              boxShadow: [
                BoxShadow(
                  color: TColors.black.withOpacity(0.3),
                  offset: const Offset(2.3,3.87),
                ),
                BoxShadow(
                    color: Colors.white.withOpacity(0.85),
                    offset: const Offset(0.0,0.0),
                    blurRadius: 0,
                    spreadRadius: 0
                ),
                BoxShadow(
                    color: const Color(0xFFD0CDE1).withOpacity(0.31),
                    offset: const Offset(0.0,0.0),
                    blurRadius: 0,
                    spreadRadius: 0
                ),
              ]
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Image(image: AssetImage(TImages.withdrawIcon)),
                  const SizedBox(width: 10,),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      RichText(
                          text: TextSpan(
                              style: TextStyle(
                                  color: widget.darkMode ? Colors.white : Colors.black.withOpacity(0.43),
                                  fontWeight: FontWeight.w600,
                                  fontSize: 16,
                                  fontFamily: 'Roboto'
                              ),
                              children: <TextSpan> [
                                TextSpan(
                                  text: widget.item.bankName,
                                ),
                              ]
                          )
                      ),
                      const SizedBox(height: TSizes.md,),
                      RichText(
                          text: TextSpan(
                              style: TextStyle(
                                  color: widget.darkMode ? Colors.white : Colors.black.withOpacity(0.43),
                                  fontWeight: FontWeight.w600,
                                  fontSize: 16,
                                  fontFamily: 'Roboto'
                              ),
                              children: <TextSpan> [
                                TextSpan(
                                  text: widget.item.accountNumber,
                                ),
                              ]
                          )
                      ),
                    ],
                  ),
                ],
              ),
              Checkbox(
                  value: provider.selectedWithdrawalAccount?.id == widget.item.id,
                  onChanged: (val){
                    provider.saveWithdrawalBank(widget.item);
                    if (provider.selectedWithdrawalAccount?.id == widget.item.id) {
                      setState(() {
                        isSelected = true;
                      });
                    } else {
                      setState(() {
                        isSelected = false;
                      });
                    }
                  })
            ],
          ),
        ),
        SizedBox(height: 20,)
      ],
    );
  }
}

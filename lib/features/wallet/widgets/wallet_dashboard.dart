import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pouch/features/wallet/controller/wallet_controller.dart';
import 'package:pouch/utils/helpers/helper_functions.dart';
import '../../../utils/constants/colors.dart';

class WalletDashboard extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    final WalletController walletController = Get.find();
    if (walletController.defaultWallet.value.balance == null) {
      walletController.fetchingDefaultWallet();
    }
    final double width = MediaQuery.of(context).size.width;

    return Container(
      padding: const EdgeInsets.only(top: 5, right: 20, bottom: 20),
      decoration: BoxDecoration(
        color: TColors.primary,
        borderRadius: const BorderRadius.all(Radius.circular(16)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          _buildBalanceHeader(width)
        ],
      ),
    );
  }

  Widget _buildBalanceHeader(double width) {
    final WalletController walletController = Get.find();
    return Padding(
      padding: const EdgeInsets.only(left: 20, top: 20),
      child: Row(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Wallet Balance',
                style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                    fontFamily: 'Work Sans',
                    color: Colors.white
                ),
              ),
              SizedBox(height: 5),
              Obx(() {
                if (walletController.defaultWallet.value.balance == null) {
                  return Text(
                    '-----',
                    style: TextStyle(
                        fontSize: width > 400 ? 35 : 22,
                        fontWeight: FontWeight.w800,
                        fontFamily: 'Work Sans',
                        color: Colors.white
                    ),
                  );
                } else {
                  return Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        '${walletController.showWalletBalance.value ? THelperFunctions.moneyFormatter(walletController.defaultWallet.value.balance.toString()) : '*****'}',
                        style: TextStyle(
                            fontSize: width > 400 ? 35 : 22,
                            fontWeight: FontWeight.w800,
                            fontFamily: 'Work Sans',
                            color: Colors.white
                        ),
                      ),
                      Text(
                        ' ${walletController.showWalletBalance.value ? walletController.defaultWallet.value.currency : ''}',
                        style: TextStyle(
                            fontSize: width > 400 ? 16 : 14,
                            fontWeight: FontWeight.w500,
                            fontFamily: 'Roboto',
                            color: Colors.white
                        ),
                      ),
                    ],
                  );
                }
              }),

            ],
          ),
          Spacer(),
          IconButton(
            onPressed: () => walletController.showWalletBalance.value = !walletController.showWalletBalance.value,
            icon: Obx(() => Icon(
              walletController.showWalletBalance.value ? Icons.visibility_outlined : Icons.visibility_off_outlined,
              color: Colors.white,
              size: 17,
            )),
          ),
        ],
      ),
    );
  }
}

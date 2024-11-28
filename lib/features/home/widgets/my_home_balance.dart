import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../utils/constants/sizes.dart';
import '../../../utils/helpers/controller/helper_function_controller.dart';
import '../../../utils/helpers/helper_functions.dart';
import '../../wallet/controller/wallet_controller.dart';

class HomeBalanceWidget extends StatelessWidget {
  final WalletController walletController = Get.find();
  final HelperFunctionsController helperFunctionsController = Get.put(HelperFunctionsController());
  @override
  Widget build(BuildContext context) {
    final darkMode = THelperFunctions.isDarkMode(context);
    final width = MediaQuery.of(context).size.width;
    if (walletController.defaultWallet.value.balance == null) {
      walletController.fetchingDefaultWallet();
    }
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: TSizes.defaultSpace),
      child: Container(
        decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(10)),
            color: Color(0xFF4B0082),
        ),
        child: Padding(
          padding: const EdgeInsets.only(left: TSizes.defaultSpace, right: TSizes.xl, top: TSizes.md, bottom: TSizes.xl),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  RichText(
                      text: TextSpan(
                          style: Theme.of(context).textTheme.labelMedium,
                          children: <TextSpan> [
                            TextSpan(
                                text:'My Balance',
                                style: TextStyle(
                                    fontWeight: TSizes.fontWeightMd,
                                    color: Colors.white
                                )
                            ),
                          ]
                      )
                  ),
                  const SizedBox(width: TSizes.md),
                  Obx(() => IconButton(
                      onPressed: () => walletController.showWalletBalance.value = !walletController.showWalletBalance.value,
                      icon: walletController.showWalletBalance.value == false
                          ? Icon(Icons.visibility_off_outlined, color: Colors.white, size: 17,)
                          : Icon(Icons.visibility_outlined, color: Colors.white, size: 17,)
                  )),
                ],
              ),
              Obx(() => Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  RichText(
                      text: TextSpan(
                          style: Theme.of(context).textTheme.labelMedium,
                          children: <TextSpan> [
                            TextSpan(
                              text: walletController.isDefaultWalletLoading.value
                                  ? '---'
                                  : walletController.defaultWallet.value.balance == null
                                  ? '---'
                                  : '${walletController.showWalletBalance.value == false ? '*****' : helperFunctionsController.moneyFormatter(walletController.defaultWallet.value.balance.toString())} ',
                              style: TextStyle(
                                  fontSize: width > 400 ? 28 : 20,
                                  fontWeight: TSizes.fontWeightXl,
                                  color: Colors.white
                              ),
                            ),
                          ]
                      )
                  ),
                  RichText(
                      text: TextSpan(
                          style: Theme.of(context).textTheme.labelMedium,
                          children: <TextSpan> [
                            TextSpan(
                              text:
                              walletController.isDefaultWalletLoading.value
                                  ? ''
                                  : walletController.defaultWallet.value.balance == null
                                  ? ''
                                  : '${walletController.showWalletBalance.value == false ? '' : walletController.defaultWallet.value.currency}',
                              style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: TSizes.fontWeightLg,
                                  color: Colors.white
                              ),
                            ),
                          ]
                      )
                  ),
                  Spacer(),
                  SizedBox(
                    height: 25,
                    width: 25,
                    child: walletController.isDefaultWalletLoading.isTrue
                        ? CircularProgressIndicator()
                        : IconButton(
                      onPressed: (){
                        walletController.fetchingDefaultWallet();
                      },
                      icon: Icon(Icons.refresh, size: 20, color: darkMode ? Colors.white : Colors.white,),
                    ),
                  )
                ],
              ))
            ],
          ),
        ),
      ),
    );
  }
}

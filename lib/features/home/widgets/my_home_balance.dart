import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pouch/features/home/controller/home_controller.dart';
import '../../../utils/constants/sizes.dart';
import '../../../utils/helpers/helper_functions.dart';

class HomeBalanceWidget extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    HomeController controller = Get.find();
    final darkMode = THelperFunctions.isDarkMode(context);
    final width = MediaQuery.of(context).size.width;
    if (controller.walletController.defaultWallet.value.balance == null) {
      controller.walletController.fetchingDefaultWallet();
    }
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: TSizes.defaultSpace),
      child: Container(
        decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(10)),
            color: Color(0xFF4B0082),
        ),
        child: Padding(
          padding: const EdgeInsets.only(left: TSizes.defaultSpace, right: TSizes.lg, top: TSizes.md, bottom: TSizes.xl),
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
                  SizedBox(
                    // width: 15,
                    child: IconButton(
                        onPressed: () => controller.walletController.showWalletBalance.value = !controller.walletController.showWalletBalance.value,
                        icon: controller.walletController.showWalletBalance.value == false
                            ? Icon(Icons.visibility_off_outlined, color: Colors.white, size: 17,)
                            : Icon(Icons.visibility_outlined, color: Colors.white, size: 17,)
                    ),
                  ),
                ],
              ),
              Obx(() => Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  RichText(
                      text: TextSpan(
                          style: Theme.of(context).textTheme.labelMedium,
                          children: <TextSpan> [
                            TextSpan(
                              text: controller.walletController.isDefaultWalletLoading.value
                                  ? '---'
                                  : controller.walletController.defaultWallet.value.balance == null
                                  ? '---'
                                  : '${controller.walletController.showWalletBalance.value == false ? '*****' : controller.helperFunctionsController.moneyFormatter(controller.walletController.defaultWallet.value.balance.toString())} ',
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
                              controller.walletController.isDefaultWalletLoading.value
                                  ? ''
                                  : controller.walletController.defaultWallet.value.balance == null
                                  ? ''
                                  : '${controller.walletController.showWalletBalance.value == false ? '' : controller.walletController.defaultWallet.value.currency}',
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
                  IconButton(
                    onPressed: (){
                      controller.walletController.fetchingDefaultWallet();
                    },
                    icon: Icon(Icons.refresh, size: 20, color: darkMode ? Colors.white : Colors.white,),
                  ),
                ],
              ))
            ],
          ),
        ),
      ),
    );
  }
}

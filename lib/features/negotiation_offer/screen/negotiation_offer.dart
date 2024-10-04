import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pouch/utils/shared/refresh_indicator/refresh_indicator.dart';
import '../../../utils/constants/sizes.dart';
import '../../../utils/helpers/helper_functions.dart';
import '../controller/negotiation_offer_controller.dart';
import '../widget/negotiation_list.dart';

class NegotiationOfferScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    NegotiationOfferController controller = Get.find();
    controller.fetchAllNegotiatedOffers();
    final darkMode = THelperFunctions.isDarkMode(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        shadowColor: Colors.transparent,
        centerTitle: true,
        title: RichText(
            text: TextSpan(
                style: Theme.of(context).textTheme.labelSmall,
                children: const <TextSpan> [
                  TextSpan(
                      text: 'Offers Review',
                      style: TextStyle(fontSize: TSizes.fontSize16, fontWeight: TSizes.fontWeightMd)
                  )
                ]
            )
        ),
      ),
      body: Obx(() {
        if (controller.isNegotiatedOfferLoading.value) {
          return SizedBox(
              height: 100,
              child: Center(
                  child: CircularProgressIndicator()
              )
          );
        } else {
          return Container(
            height: THelperFunctions.screenHeight() - TSizes.appBarHeight,
            child: CustomRefreshIndicator(
                onRefresh: () => controller.fetchAllNegotiatedOffers(),
                child: Container(
                  height: THelperFunctions.screenHeight(),
                  child: SingleChildScrollView(
                      physics: AlwaysScrollableScrollPhysics(),
                      child: NegotiationList(darkMode: darkMode)),
                )
            ),
          );
        }
      }),
    );
  }
}


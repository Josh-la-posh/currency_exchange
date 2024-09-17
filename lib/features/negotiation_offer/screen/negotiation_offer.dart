import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:pouch/common/widgets/currencyWidget.dart';
import 'package:pouch/data/modules/background_task.dart';
import 'package:pouch/features/all_offer/controllers/offer_controller.dart';
import 'package:pouch/utils/shared/refresh_indicator/refresh_indicator.dart';
import 'package:provider/provider.dart';
import '../../../common/widgets/custom_shapes/currency_widget_with_back.dart';
import '../../../data/modules/app_navigator.dart';
import '../../../data/provider/offer_provider.dart';
import '../../../utils/constants/colors.dart';
import '../../../utils/constants/sizes.dart';
import '../../../utils/helpers/helper_functions.dart';
import '../../all_offer/apis/api.dart';
import '../widget/negotiation_list.dart';

class NegotiationOfferScreen extends StatelessWidget {
  final offerController = Get.find<OfferController>();

  @override
  Widget build(BuildContext context) {
    offerController.fetchAllNegotiatedOffers();
    final darkMode = THelperFunctions.isDarkMode(context);
    return Scaffold(
      // backgroundColor: darkMode ? TColors.black.withOpacity(0.8) : TColors.white,
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
        if (offerController.isNegotiationOfferLoading.value) {
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
                onRefresh: () => offerController.fetchAllNegotiatedOffers(),
                child: SingleChildScrollView(
                    physics: AlwaysScrollableScrollPhysics(),
                    child: NegotiationList(darkMode: darkMode))
            ),
          );
        }
      }),
    );
  }
}


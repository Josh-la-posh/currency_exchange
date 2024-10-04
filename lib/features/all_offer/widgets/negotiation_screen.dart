import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pouch/features/all_offer/controllers/create_offer_controller.dart';
import 'package:pouch/features/all_offer/controllers/offer_controller.dart';
import 'package:pouch/common/widgets/buttons/elevated_button.dart';
import 'package:pouch/utils/constants/sizes.dart';
import 'package:pouch/utils/helpers/helper_functions.dart';
import 'package:pouch/utils/layouts/bottom_sheet_widget.dart';
import 'package:pouch/utils/validators/validation.dart';
import '../../../utils/layouts/navigation_menu.dart';

class NegotiationScreen extends StatelessWidget {
  OfferController offerController = Get.find();
  NavigationController controller = Get.find();
  CreateOfferController createOfferController = Get.put(CreateOfferController());
  final String id;
  final String debitedCurrency;
  final String creditedCurrency;
  NegotiationScreen({
    super.key,
    required this.id,
    required this.debitedCurrency,
    required this.creditedCurrency,
  });

  @override
  Widget build(BuildContext context) {
    return  HalfBottomSheetWidget(
        title: "I'm interested, but...",
        child: SizedBox(
          height: THelperFunctions.screenHeight() * 0.48,
          child: Form(
            key: createOfferController.formKey,
            child:
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('I need', style: Theme.of(context).textTheme.labelMedium,),
                    Row(
                      children: [
                        Expanded(
                          child: TextFormField(
                              controller: createOfferController.amountController,
                              keyboardType: TextInputType.number,
                              validator: TValidator.numValidator,
                              style: Theme.of(context).textTheme.labelMedium
                          ),
                        ),
                        SizedBox(width: 5,),
                        Text(debitedCurrency, style: Theme.of(context).textTheme.bodyMedium,)
                      ],
                    ),
                    const SizedBox(height: TSizes.spaceBtwInputFields,),
                    Text('At', style: Theme.of(context).textTheme.labelMedium,),
                    SizedBox(
                      child: Row(
                        children: [
                          Expanded(
                            child: TextFormField(
                                controller: createOfferController.rateController,
                                validator: TValidator.numValidator,
                                keyboardType: TextInputType.number,
                                style: Theme.of(context).textTheme.labelMedium
                            ),
                          ),
                          SizedBox(width: 5,),
                          Text('$creditedCurrency // $debitedCurrency ', style: Theme.of(context).textTheme.bodyMedium,),
                        ],
                      ),
                    ),
                  ],
                ),
                Obx(() => TElevatedButton(
                    onTap: offerController.isNegotiatingOfferLoading.value ? null : (){
                      if (createOfferController.formKey.currentState!.validate()) {
                        offerController.negotiatingOffer(
                            id: id,
                            currency: debitedCurrency,
                            negotiatorRate: createOfferController.rateController.text,
                            negotiatorAmount: createOfferController.amountController.text,
                            onSuccess: () {
                              createOfferController.rateController.clear();
                              createOfferController.amountController.clear();
                              Get.offAll(() => NavigationMenu());
                            }
                        );
                      }
                    },
                    buttonText: offerController.isNegotiatingOfferLoading.value ? 'Loading ...' : 'Done'
                ))
              ],
            ),
          ),
        ));
  }
}

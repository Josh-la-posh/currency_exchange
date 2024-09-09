import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:pouch/features/home/routes/names.dart';
import 'package:provider/provider.dart';
import 'package:pouch/common/widgets/buttons/elevated_button.dart';
import 'package:pouch/utils/constants/sizes.dart';
import 'package:pouch/utils/helpers/helper_functions.dart';
import 'package:pouch/utils/layouts/bottom_sheet_widget.dart';
import 'package:pouch/utils/validators/validation.dart';

import '../../../data/modules/app_navigator.dart';
import '../../../data/provider/offer_provider.dart';
import '../../../utils/layouts/navigation_menu.dart';
import '../apis/api.dart';

class NegotiationScreen extends StatefulWidget {
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
  State<NegotiationScreen> createState() => _NegotiationScreenState();
}

class _NegotiationScreenState extends State<NegotiationScreen> {
  final formKey = GlobalKey<FormState>();

  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(NavigationController());
    final offerProvider = Provider.of<OfferProvider>(context);
    final provider = Provider.of<OfferProvider>(context);
    return  HalfBottomSheetWidget(
        title: "I'm interested, but...",
        child: SizedBox(
          height: THelperFunctions.screenHeight() * 0.48,
          child: Form(
            key: formKey,
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
                            onChanged: (val) {
                              provider.setNegotiatorAmount(val);
                              formKey.currentState?.validate();
                            },
                            onSaved: (val) {
                              provider.setNegotiatorAmount(val!);
                            },
                              keyboardType: TextInputType.number,
                              validator: TValidator.numValidator,
                            style: Theme.of(context).textTheme.labelMedium
                          ),
                        ),
                        SizedBox(width: 5,),
                        Text(widget.debitedCurrency, style: Theme.of(context).textTheme.bodyMedium,)
                      ],
                    ),
                    const SizedBox(height: TSizes.spaceBtwInputFields,),
                    Text('At', style: Theme.of(context).textTheme.labelMedium,),
                    SizedBox(
                      child: Row(
                        children: [
                          Expanded(
                            child: TextFormField(
                                onChanged: (val) {
                                  provider.setNegotiatorRate(val);
                                  formKey.currentState?.validate();
                                },
                                onSaved: (val) {
                                  provider.setNegotiatorRate(val!);
                                },
                                validator: TValidator.numValidator,
                                keyboardType: TextInputType.number,
                                style: Theme.of(context).textTheme.labelMedium
                            ),
                          ),
                          SizedBox(width: 5,),
                          Text('${widget.creditedCurrency} // ${widget.debitedCurrency} ', style: Theme.of(context).textTheme.bodyMedium,),
                        ],
                      ),
                    ),
                  ],
                ),
                TElevatedButton(
                    onTap: isLoading ? null : (){
                      setState(() {
                        isLoading = true;
                      });
                      if (formKey.currentState!.validate()) {
                        OfferService.instance
                            .negotiateOffer(
                            id: widget.id,
                            negotiatorRate: provider.negotiatorRate,
                            negotiatorAmount: provider.negotiatorAmount,
                            offerProvider: offerProvider,
                            onSuccess: () {
                              controller.selectedIndex.value = 1;
                              AppNavigator.instance
                                .removeAllNavigateToNavHandler(DASHBOARD_SCREEN_ROUTE);
                            },
                            onFailure: (){
                              setState(() {
                                isLoading = false;
                              });
                            }
                        );
                      }
                    },
                    buttonText: isLoading ? 'Loading ...' : 'Done'
                )
              ],
            ),
          ),
        ));
  }
}

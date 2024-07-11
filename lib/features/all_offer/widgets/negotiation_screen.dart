import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pouch/data/modules/background_task.dart';
import 'package:pouch/features/all_offer/routes/names.dart';
import 'package:provider/provider.dart';
import 'package:pouch/common/widgets/buttons/elevated_button.dart';
import 'package:pouch/utils/constants/colors.dart';
import 'package:pouch/utils/constants/sizes.dart';
import 'package:pouch/utils/helpers/helper_functions.dart';
import 'package:pouch/utils/layouts/bottom_sheet_widget.dart';
import 'package:pouch/utils/validators/validation.dart';

import '../../../data/modules/app_navigator.dart';
import '../../../data/provider/offer_provider.dart';
import '../apis/api.dart';

class NegotiationScreen extends StatefulWidget {
  final String id;
  NegotiationScreen({
    super.key,
    required this.id,
  });

  @override
  State<NegotiationScreen> createState() => _NegotiationScreenState();
}

class _NegotiationScreenState extends State<NegotiationScreen> {
  final formKey = GlobalKey<FormState>();

  bool isBidCompleted = false;

  @override
  Widget build(BuildContext context) {
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
                    Text('I have', style: Theme.of(context).textTheme.labelMedium,),
                    TextFormField(
                      onChanged: (val) => provider.setNegotiatorAmount(val),
                      onSaved: (val) {
                        provider.setNegotiatorAmount(val!);
                      },
                        keyboardType: TextInputType.number,
                        validator: TValidator.numValidator,
                      style: Theme.of(context).textTheme.labelMedium
                    ),
                    const SizedBox(height: TSizes.spaceBtwInputFields,),
                    Text('At', style: Theme.of(context).textTheme.labelMedium,),
                    SizedBox(
                      child: TextFormField(
                          onChanged: (val) => provider.setNegotiatorRate(val),
                          onSaved: (val) {
                            provider.setNegotiatorRate(val!);
                          },
                          validator: TValidator.numValidator,
                          keyboardType: TextInputType.number,
                          style: Theme.of(context).textTheme.labelMedium
                      ),
                    ),
                  ],
                ),
                TElevatedButton(
                    onTap: (){
                      if (formKey.currentState!.validate()) {
                        OfferService.instance
                            .negotiateOffer(
                            id: widget.id,
                            negotiatorRate: provider.negotiatorRate,
                            negotiatorAmount: provider.negotiatorAmount,
                            offerProvider: offerProvider,
                            onSuccess: () {
                              AppNavigator.instance
                                .removeAllNavigateToNavHandler(ALL_OFFER_SCREEN_ROUTE);
                            }
                        );
                      }
                    },
                    buttonText: 'Done'
                )
              ],
            ),
          ),
        ));
  }
}

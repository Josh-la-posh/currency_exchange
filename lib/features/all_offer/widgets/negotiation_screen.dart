import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:swappr/common/widgets/buttons/elevated_button.dart';
import 'package:swappr/utils/constants/colors.dart';
import 'package:swappr/utils/constants/sizes.dart';
import 'package:swappr/utils/helpers/helper_functions.dart';
import 'package:swappr/utils/layouts/bottom_sheet_widget.dart';
import 'package:swappr/utils/validators/validation.dart';

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

  @override
  Widget build(BuildContext context) {
    final offerProvider = Provider.of<OfferProvider>(context);
    final provider = Provider.of<OfferProvider>(context);
    return HalfBottomSheetWidget(
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
                    Text('I have', style: Theme.of(context).textTheme.labelSmall,),
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
                    Text('At', style: Theme.of(context).textTheme.labelSmall,),
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
                            offerProvider: offerProvider
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

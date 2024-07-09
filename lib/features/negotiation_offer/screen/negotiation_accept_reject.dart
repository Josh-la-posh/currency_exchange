import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:provider/provider.dart';
import 'package:swappr/features/all_offer/apis/api.dart';
import 'package:swappr/utils/helpers/helper_functions.dart';
import '../../../common/widgets/buttons/elevated_button.dart';
import '../../../common/widgets/custom_shapes/currency_widget_with_back.dart';
import '../../../common/widgets/custom_time_line.dart';
import '../../../common/widgets/divider.dart';
import '../../../data/provider/offer_provider.dart';
import '../../../utils/constants/colors.dart';
import '../../../utils/constants/sizes.dart';
import '../../../utils/layouts/list_layout.dart';
import '../../all_offer/icons/svg.dart';
import '../../all_offer/models/negotiate_offer_model.dart';
import '../../all_offer/widgets/success_page.dart';

class NegotiationAcceptRejectScreen extends StatefulWidget {
  final NegotiateOfferModel item;
  const NegotiationAcceptRejectScreen({
    super.key,
    required this.item
  });

  @override
  State<NegotiationAcceptRejectScreen> createState() => _NegotiationAcceptRejectScreenState();
}

class _NegotiationAcceptRejectScreenState extends State<NegotiationAcceptRejectScreen> {

  bool showAcceptOfferMsg = false;
  bool showRejectOfferMsg = false;

  void handleSuccess() {
    setState(() {
      showAcceptOfferMsg = true;
    });
  }



  @override
  Widget build(BuildContext context) {
    final offerProvider = Provider.of<OfferProvider>(context);
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: TSizes.defaultSpace),
        child: showAcceptOfferMsg == false && showRejectOfferMsg == false
            ? Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CurrencyWidgetWithBack(),
            const SizedBox(height: TSizes.spaceBtwSections / 2,),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: TSizes.spaceBtwElements * 2,),
                    Container(
                      alignment: Alignment.centerLeft,
                      width: double.infinity,
                      height: 48,
                      color: TColors.primaryBackground,
                      padding: const EdgeInsets.symmetric(horizontal: TSizes.defaultSpace),
                      child: RichText(
                          text: TextSpan(
                              style: Theme.of(context).textTheme.labelSmall,
                              children: const <TextSpan> [
                                TextSpan(
                                    text: 'Offer Details',
                                    style: TextStyle(fontSize: TSizes.fontSize13, fontWeight: TSizes.fontWeightMd)
                                )
                              ]
                          )
                      ),
                    ),
                    const SizedBox(height: TSizes.spaceBtwElements ),
                    Column(
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: TSizes.defaultSpace),
                          height: TSizes.textReviewHeight,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              RichText(
                                  text: TextSpan(
                                      style: Theme.of(context).textTheme.labelSmall,
                                      children: const <TextSpan> [
                                        TextSpan(
                                            text: 'has',
                                            style: TextStyle(fontSize: TSizes.fontSize13)
                                        )
                                      ]
                                  )
                              ),
                              RichText(
                                  text: TextSpan(
                                      style: Theme.of(context).textTheme.labelSmall,
                                      children: <TextSpan> [
                                        TextSpan(
                                            text: '${widget.item.amount} ${widget.item.debitedCurrency}',
                                            style: TextStyle(fontSize: TSizes.fontSize13, fontWeight: TSizes.fontWeightMd)
                                        )
                                      ]
                                  )
                              ),
                            ],
                          ),
                        ),
                        const DividerWidget(),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: TSizes.defaultSpace),
                          height: TSizes.textReviewHeight,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              RichText(
                                  text: TextSpan(
                                      style: Theme.of(context).textTheme.labelSmall,
                                      children: const <TextSpan> [
                                        TextSpan(
                                            text: 'needs',
                                            style: TextStyle(fontSize: TSizes.fontSize13)
                                        )
                                      ]
                                  )
                              ),
                              RichText(
                                  text: TextSpan(
                                      style: Theme.of(context).textTheme.labelSmall,
                                      children: <TextSpan> [
                                        TextSpan(
                                            text: widget.item.creditedCurrency,
                                            style: TextStyle(fontSize: TSizes.fontSize13, fontWeight: TSizes.fontWeightMd)
                                        )
                                      ]
                                  )
                              ),
                            ],
                          ),
                        ),
                        const DividerWidget(),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: TSizes.defaultSpace),
                          height: TSizes.textReviewHeight,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              RichText(
                                  text: TextSpan(
                                      style: Theme.of(context).textTheme.labelSmall,
                                      children: const <TextSpan> [
                                        TextSpan(
                                            text: 'Rate',
                                            style: TextStyle(fontSize: TSizes.fontSize13)
                                        )
                                      ]
                                  )
                              ),
                              RichText(
                                  text: TextSpan(
                                      style: Theme.of(context).textTheme.labelSmall,
                                      children: <TextSpan> [
                                        TextSpan(
                                            text: '${widget.item.rate} ${widget.item.debitedCurrency} // ${widget.item.creditedCurrency}',
                                            style: TextStyle(color: TColors.primary)
                                        )
                                      ]
                                  )
                              ),
                            ],
                          ),
                        ),
                        const DividerWidget(),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: TSizes.defaultSpace),
                          height: TSizes.textReviewHeight,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  RichText(
                                      text: TextSpan(
                                          style: Theme.of(context).textTheme.labelSmall,
                                          children: const <TextSpan> [
                                            TextSpan(
                                                text: 'Fee',
                                                style: TextStyle(fontSize: TSizes.fontSize13)
                                            )
                                          ]
                                      )
                                  ),
                                  const SizedBox(width: TSizes.md),
                                  NotiIcon(),
                                ],
                              ),
                              RichText(
                                  text: TextSpan(
                                      style: Theme.of(context).textTheme.labelSmall,
                                      children: const <TextSpan> [
                                        TextSpan(
                                            text: '5 GBP',
                                            style: TextStyle(fontSize: TSizes.fontSize13, fontWeight: TSizes.fontWeightMd)
                                        )
                                      ]
                                  )
                              ),
                            ],
                          ),
                        ),
                        const DividerWidget(),
                        const SizedBox(height: TSizes.spaceBtwElements * 3),
                        RichText(
                            text: TextSpan(
                                text: 'You are about to swap ',
                                style: Theme.of(context).textTheme.labelMedium,
                                children: <TextSpan> [
                                  TextSpan(
                                      text: ' ${THelperFunctions.getStringMultiplication(widget.item.amount, widget.item.rate)} ${widget.item.debitedCurrency}',
                                      style: TextStyle(
                                          fontWeight: TSizes.fontWeightLg,
                                          color: Color(0xFFEA8484)
                                      )
                                  ),
                                  TextSpan(
                                      text: ' for '
                                  ),
                                  TextSpan(
                                      text: ' ${widget.item.amount} ${widget.item.creditedCurrency}',
                                      style: TextStyle(fontWeight: TSizes.fontWeightLg)
                                  ),
                                ]
                            )
                        ),
                        const SizedBox(height: TSizes.spaceBtwSections),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: TSizes.defaultSpace),
                          child: TElevatedButton(onTap: (){
                            OfferService.instance.acceptRejectOffer(
                                id: widget.item.id,
                                negotiationAccepted: true,
                                offerProvider: offerProvider,
                                onSuccess: (){
                                  setState(() {
                                    showAcceptOfferMsg = true;
                                  });
                                }
                            );
                          },
                              buttonText: 'Accept'),
                        ),
                        const SizedBox(height: TSizes.spaceBtwSections ),
                        Container(
                          width: double.infinity,
                          height: 48,
                          padding: const EdgeInsets.symmetric(horizontal: TSizes.defaultSpace),
                          child: ElevatedButton(
                            onPressed: () {
                              OfferService.instance.acceptRejectOffer(
                                  id: widget.item.id,
                                  negotiationAccepted: false,
                                  offerProvider: offerProvider,
                                  onSuccess: (){
                                    setState(() {
                                      showRejectOfferMsg = true;
                                    });
                                  }
                              );
                            },
                            child: const Text(
                              'Reject',
                              style: TextStyle(color: Color(0xFFEA8484)),
                            ),
                          )
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        )
            :  showAcceptOfferMsg == true
            ? SuccessScreenWidget(
          onTap: () {Get.back();},
          text: 'You have successfully swapped ${THelperFunctions.getStringMultiplication(widget.item.amount, widget.item.rate)} ${widget.item.debitedCurrency} for ${widget.item.amount} ${widget.item.creditedCurrency}.',
          child: TListLayout(
              itemCount: 3,
              itemBuilder: (_, index) => MyTimeLine(
                isFirst: index == 0 ? true : false,
                isLast: index == 2 ? true : false,
                isDone: index == 2 ? false : true,
                startChild: Container(
                  padding: const EdgeInsets.only(bottom: 17),
                  child: RichText(
                      text: TextSpan(
                          style: Theme.of(context).textTheme.labelSmall,
                          children: <TextSpan> [
                            TextSpan(
                                text: THelperFunctions.getFormattedTime(DateTime.now().toString()),
                                style: TextStyle(
                                    color: TColors.textPrimary.withOpacity(0.6),
                                    height: 1.5
                                )
                            ),
                          ]
                      )
                  ),
                ),
                endChild: Container(
                    padding: const EdgeInsets.only(bottom: 17),
                    child: Text(
                      index == 0
                          ? 'You accepted this offer'
                          : index == 1
                          ? 'We received your funds'
                          : 'Your ${widget.item.creditedCurrency} ${widget.item.amount} is on its way to you',
                      style: Theme.of(context).textTheme.labelMedium,)
                ),
              )
          ),
        )
            : SuccessScreenWidget(
          onTap: () {Get.back();},
          text: 'You have successfully rejected this offer.',
          child: SizedBox(height: 0,),
        )
      )
    );
  }
}

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:swappr/utils/constants/enums.dart';
import 'package:swappr/utils/helpers/helper_functions.dart';
import '../../../data/provider/offer_provider.dart';
import '../../../utils/constants/colors.dart';
import '../../../utils/constants/sizes.dart';
import '../../../utils/layouts/list_layout.dart';
import '../icons/svg.dart';
import 'filter_screen.dart';
import 'no_offer.dart';
import 'offer_item.dart';

class OfferList extends StatelessWidget {
  const OfferList({
    super.key,
  });

  @override
  Widget build(BuildContext context) {

    final offerProvider = Provider.of<OfferProvider>(context);
    final selectedCurrency = offerProvider.selectedCurrency;
    final darkMode = THelperFunctions.isDarkMode(context);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: TSizes.defaultSpace / 1.5),
      child: SizedBox(
        child: Column(
          children: [
            const SizedBox(height: TSizes.spaceBtwSections),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'All Offers',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                Row(
                  children: [
                    if (selectedCurrency != Currency.Select && offerProvider.filterAll == false)
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 4),
                        decoration: BoxDecoration(
                            color: TColors.primary,
                            borderRadius: BorderRadius.circular(50)
                        ),
                        child: RichText(
                            text: TextSpan(
                                style: Theme.of(context).textTheme.labelMedium,
                                children: <TextSpan> [
                                  TextSpan(
                                      text: 'Currency: ${getCurrencyName(selectedCurrency) ?? ''}',
                                      style: const TextStyle(color: TColors.white)
                                  )
                                ]
                            )
                        ),
                      ),
                    const SizedBox(width: TSizes.spaceBtwItems,),
                    GestureDetector(
                      onTap: (){
                        showModalBottomSheet(
                            // isDismissible: false,
                            isScrollControlled: true,
                            // enableDrag: false,
                            context: context,
                            builder: (cdx) =>  const FilterScreen()
                        );
                      },
                      child: Container(
                        width: 82,
                        height: 31,
                        decoration: BoxDecoration(
                            color: darkMode ? TColors.primary : TColors.secondaryBorder30,
                            borderRadius: BorderRadius.circular(12)
                        ),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text('Filter', style: Theme.of(context).textTheme.labelMedium,),
                            const SizedBox(width: TSizes.sm,),
                            FilterIcon(),
                          ],
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
              const SizedBox(height: TSizes.md,),
            offerProvider.offers.isEmpty
                ? LayoutBuilder(builder: (context, constraints) {
              return const NoOfferScreen();
            })
                : Column(
                children: [
                  TListLayout(
                      itemCount: offerProvider.offers.length,
                      itemBuilder: (_, index) {
                        final item = offerProvider.offers[index];
                        return OfferItem(item: item);
                      }
                  )
                ],
              )
          ],
        ),
      ),
    );
  }
}

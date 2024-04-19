import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:swappr/features/home/widgets/offer_item.dart';
import '../../../data/provider/currency_provider.dart';
import '../../../data/provider/offer_provider.dart';
import '../../../utils/constants/colors.dart';
import '../../../utils/constants/sizes.dart';
import '../../../utils/layouts/list_layout.dart';
import '../icons/svg.dart';
import '../models/offer.dart';
import 'filter_screen.dart';
import 'no_offer.dart';

class OfferList extends StatelessWidget {
  const OfferList({
    super.key,
  });

  @override
  Widget build(BuildContext context) {

    final currencyProvider = Provider.of<CurrencyProvider>(context);
    final offerProvider = Provider.of<OfferProvider>(context);
    final selectedCurrency = currencyProvider.selectedCurrencyProvider.selectedCurrency;
    List<OfferEntity> offers = offerProvider.offers;

    const int offer = 1;

    return SizedBox(
      child: offer == 0
          ? LayoutBuilder(builder: (context, constraints) {
            return const NoOfferScreen();
          })
          : Column(
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
                  if (selectedCurrency?.name != null)
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
                                    text: 'Currency: ${selectedCurrency?.name ?? ''}',
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
                          backgroundColor: TColors.white,
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
                          color: TColors.secondaryBorder,
                          borderRadius: BorderRadius.circular(30)
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('Filter', style: Theme.of(context).textTheme.labelMedium,),
                          const SizedBox(width: TSizes.sm,),
                          FilterIcon()
                        ],
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
            const SizedBox(height: TSizes.md,),
            Column(
              children: [
                TListLayout(
                    itemCount: 14,
                    itemBuilder: (_, index) => const OfferItem()
                )
              ],
            )
        ],
      ),
    );
  }
}

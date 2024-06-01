import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:swappr/common/widgets/buttons/elevated_button.dart';
import 'package:swappr/data/provider/offer_provider.dart';
import 'package:swappr/features/home/apis/api.dart';
import 'package:swappr/data/provider/currency_provider.dart';
import 'package:swappr/utils/constants/colors.dart';
import 'package:swappr/utils/constants/enums.dart';
import 'package:swappr/utils/constants/sizes.dart';
import 'package:swappr/utils/layouts/bottom_sheet_widget.dart';

import '../apis/api.dart';
import 'currency_screen.dart';
import 'date_screen.dart';

class FilterScreen extends StatelessWidget {
  // final Function(String) callback;
  // const FilterScreen(this.callback);


  const FilterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<OfferProvider>(context);
    final selectedCurrency = provider.selectedCurrency;
    final selectedDate = provider.selectedDate;
    return ChangeNotifierProvider(
      create: (context) => CurrencyProvider(),
      child: HalfBottomSheetWidget(
          title: 'Filter',
          child: Column(
            children: [
              GestureDetector(
                onTap: () => provider.setFilterAll(!provider.filterAll),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text('All', style: Theme.of(context).textTheme.labelMedium,),
                    if (provider.filterAll == true)
                    Icon(Icons.check),
                    if (provider.filterAll == false)
                      Icon(Icons.circle, color: TColors.secondaryBorder30, )
                  ],
                ),
              ),
              const SizedBox(height: TSizes.spaceBtwItems,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text('Date', style: Theme.of(context).textTheme.labelMedium,),
                  InkWell(
                    onTap: (){
                      showModalBottomSheet(
                          backgroundColor: TColors.white,
                          // isDismissible: false,
                          isScrollControlled: true,
                          // enableDrag: false,
                          context: context,
                          builder: (cdx) => DateList()
                      );
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text('${getDateValue(provider.selectedDate)} days', style: Theme.of(context).textTheme.labelSmall,),
                        Icon(Icons.chevron_right, color: TColors.textPrimary.withOpacity(0.5),)
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: TSizes.spaceBtwItems,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text('Currency', style: Theme.of(context).textTheme.labelMedium,),
                  InkWell(
                    onTap: (){
                      showModalBottomSheet(
                          backgroundColor: TColors.white,
                          // isDismissible: false,
                          isScrollControlled: true,
                          // enableDrag: false,
                          context: context,
                          builder: (cdx) => const CurrencyList()
                      );
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(getCurrencyName(selectedCurrency) ?? '', style: Theme.of(context).textTheme.labelSmall,),
                        Icon(Icons.chevron_right, color: TColors.textPrimary.withOpacity(0.5),)
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: TSizes.spaceBtwSections,),
              TElevatedButton(onTap: (){
                if (provider.filterAll == true) {
                  OfferService.instance.getAllOffers(
                      offerProvider: provider,
                      currency: '',
                      date: ''
                  );
                  Get.back();
                } else {
                  OfferService.instance.getAllOffers(
                      offerProvider: provider,
                      currency: selectedCurrency == Currency.Select ? '' : getCurrencyName(selectedCurrency),
                      date: selectedDate == Date.Select ? '' : getDateValue(selectedDate)
                  );
                  Get.back();
                }
                }, buttonText: 'Apply')
            ],
          )
      ),
    );
  }
}

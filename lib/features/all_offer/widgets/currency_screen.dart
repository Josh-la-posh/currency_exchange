import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:swappr/data/provider/offer_provider.dart';
import 'package:swappr/utils/constants/enums.dart';
import 'package:swappr/utils/helpers/helper_functions.dart';
import 'package:swappr/utils/layouts/bottom_sheet_widget.dart';
import 'package:swappr/utils/layouts/list_layout.dart';

import '../../../data/provider/currency_provider.dart';
import '../../../utils/constants/colors.dart';

class CurrencyList extends StatelessWidget {
  const CurrencyList({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<OfferProvider>(context);
    final dark = THelperFunctions.isDarkMode(context);

    return HalfBottomSheetWidget(
        title: "Currency",
        child: TListLayout(
              itemCount: provider.currencies?.length ?? 0,
              itemBuilder: (_, index) {
                final currency = provider.currencies?[index];
                return ListTile(
                  onTap: () {
                    provider.setSelectedCurrency(currency);
                    provider.setFilterAll(false);
                    Get.back();
                  },
                  title: Text(
                    getCurrencyName(currency!),
                    style: Theme.of(context).textTheme.labelMedium,
                  ),
                  trailing: currency == provider.selectedCurrency
                      ? Icon(
                          Icons.check,
                          color: currency == provider.selectedCurrency
                              ? dark
                                  ? TColors.white
                                  : TColors.black
                              : null,
                        )
                      : null,
                );
              })
    );
  }
}


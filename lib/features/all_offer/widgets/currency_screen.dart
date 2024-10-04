import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:pouch/data/provider/offer_provider.dart';
import 'package:pouch/utils/constants/enums.dart';
import 'package:pouch/utils/helpers/helper_functions.dart';
import 'package:pouch/utils/layouts/bottom_sheet_widget.dart';
import 'package:pouch/utils/layouts/list_layout.dart';

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


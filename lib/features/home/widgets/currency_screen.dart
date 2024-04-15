import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:swappr/data/provider/currency_provider.dart';
import 'package:swappr/utils/constants/colors.dart';
import 'package:swappr/utils/helpers/helper_functions.dart';
import 'package:swappr/utils/layouts/bottom_sheet_widget.dart';
import 'package:swappr/utils/layouts/list_layout.dart';

class CurrencyList extends StatelessWidget {
  // final Function(String) callback;
  // const CurrencyList(this.callback);

  const CurrencyList({super.key});

  @override
  Widget build(BuildContext context) {
    final currencyProvider = Provider.of<CurrencyProvider>(context);
    final dark = THelperFunctions.isDarkMode(context);
    return HalfBottomSheetWidget(
        title: "Currency",
        child: TListLayout(
              itemCount: currencyProvider.currencies?.length ?? 0,
              itemBuilder: (_, index) {
                final currency = currencyProvider.currencies?[index];
                return ListTile(
                  onTap: () {
                    // updateCurrency(currencies[index]);
                    // widget.callback(currencies[index]);
                    currencyProvider.updateCurrency(currency);
                    Get.back();
                  },
                  title: Text(
                    currency!.name,
                    style: Theme.of(context).textTheme.labelMedium,
                  ),
                  trailing: currency.isSelected
                      ? Icon(
                          Icons.check,
                          color: currency.isSelected
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


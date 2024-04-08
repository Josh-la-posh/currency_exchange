import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:swappr/utils/constants/colors.dart';
import 'package:swappr/utils/helpers/helper_functions.dart';
import 'package:swappr/utils/layouts/bottom_sheet_widget.dart';
import 'package:swappr/utils/layouts/list_layout.dart';

class CurrencyList extends StatefulWidget {
  final Function(String) callback;
  const CurrencyList(this.callback);

  @override
  State<CurrencyList> createState() => _CurrencyListState();
}

class _CurrencyListState extends State<CurrencyList> {
  List<String> currencies = ['NGN', 'GBP', 'EUR'];
  String selectedCurrency = 'NGN';
  void updateCurrency(String newCurrency) {
    setState(() {
      selectedCurrency = newCurrency;
    });
  }

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);
    return HalfBottomSheetWidget(
        title: "Currency",
        child: TListLayout(
              itemCount: currencies.length,
              itemBuilder: (_, int index) => Column(
                children: [
                  ListTile(
                    onTap: () {
                      updateCurrency(currencies[index]);
                      widget.callback(currencies[index]);
                      Get.back();
                    },
                    title: Text(currencies[index], style: Theme.of(context).textTheme.labelMedium,),
                    trailing: selectedCurrency == currencies[index]
                        ? Icon(Icons.check,
                            color: selectedCurrency == currencies[index]
                              ? dark
                                ? TColors.white
                                : TColors.black
                              : null,
                          )
                        : null,
                  ),
                ],
              )
        )
    );
  }
}


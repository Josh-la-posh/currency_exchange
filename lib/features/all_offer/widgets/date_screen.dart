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

class DateList extends StatelessWidget {
  const DateList({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<OfferProvider>(context);
    final dark = THelperFunctions.isDarkMode(context);

    return HalfBottomSheetWidget(
        title: "Date",
        child: TListLayout(
            itemCount: provider.dates.length,
            itemBuilder: (_, index) {
              final date = provider.dates[index];
              return ListTile(
                onTap: () {
                  provider.setSelectedDate(date);
                  provider.setFilterAll(false);
                  Get.back();
                },
                title: Text(
                  '${getDateValue(date)} days',
                  style: Theme.of(context).textTheme.labelMedium,
                ),
                trailing: date == provider.selectedDate
                    ? Icon(
                  Icons.check,
                  color: date == provider.selectedDate
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


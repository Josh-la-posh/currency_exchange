import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:swappr/common/widgets/buttons/elevated_button.dart';
import 'package:swappr/features/dashboard/screens/home/widgets/currency_screen.dart';
import 'package:swappr/utils/constants/colors.dart';
import 'package:swappr/utils/constants/sizes.dart';
import 'package:swappr/utils/layouts/bottom_sheet_widget.dart';

class FilterScreen extends StatefulWidget {
  final Function(String) callback;
  const FilterScreen(this.callback);

  @override
  State<FilterScreen> createState() => _FilterScreenState();
}

class _FilterScreenState extends State<FilterScreen> {
  String updatedCurrency = '';

  void updateData(String newData) {
    setState(() {
      updatedCurrency = newData;
    });
  }

  @override
  Widget build(BuildContext context) {
    return HalfBottomSheetWidget(
        title: 'Filter',
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text('All', style: Theme.of(context).textTheme.labelMedium,),
                Icon(Icons.check)
              ],
            ),
            const SizedBox(height: TSizes.spaceBtwItems,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text('Date', style: Theme.of(context).textTheme.labelMedium,),
                InkWell(
                  onTap: (){
                    // showModalBottomSheet(
                    //     backgroundColor: TColors.white,
                    //     isDismissible: false,
                    //     isScrollControlled: true,
                    //     enableDrag: false,
                    //     context: context,
                    //     builder: (cdx) => CurrencyList(updateData)
                    // );
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text('Date', style: Theme.of(context).textTheme.labelSmall,),
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
                        isDismissible: false,
                        isScrollControlled: true,
                        enableDrag: false,
                        context: context,
                        builder: (cdx) => CurrencyList(updateData)
                    );
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(updatedCurrency, style: Theme.of(context).textTheme.labelSmall,),
                      Icon(Icons.chevron_right, color: TColors.textPrimary.withOpacity(0.5),)
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: TSizes.spaceBtwSections,),
            TElevatedButton(onTap: (){
              updateData(updatedCurrency);
              widget.callback(updatedCurrency);
              Get.back();
              }, buttonText: 'Apply')
          ],
        )
    );
  }
}

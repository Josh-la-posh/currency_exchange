// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:provider/provider.dart';
// import 'package:pouch/common/widgets/buttons/elevated_button.dart';
// import 'package:pouch/utils/constants/colors.dart';
// import 'package:pouch/utils/constants/enums.dart';
// import 'package:pouch/utils/constants/sizes.dart';
// import 'package:pouch/utils/layouts/bottom_sheet_widget.dart';
// import 'currency_screen.dart';
// import 'date_screen.dart';
//
// class FilterScreen extends StatelessWidget {
//
//   const FilterScreen({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     final provider = Provider.of<OfferProvider>(context);
//     final selectedCurrency = provider.selectedCurrency;
//     final selectedDate = provider.selectedDate;
//     return ChangeNotifierProvider(
//       create: (context) => CurrencyProvider(),
//       child: HalfBottomSheetWidget(
//           title: 'Filter',
//           child: Column(
//             children: [
//               ListTile(
//                 onTap: () => provider.setFilterAll(!provider.filterAll),
//                 contentPadding: EdgeInsets.symmetric(horizontal: 10),
//                 // hoverColor: Colors.transparent,
//                 title: Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   crossAxisAlignment: CrossAxisAlignment.center,
//                   children: [
//                     Text('All', style: Theme.of(context).textTheme.labelMedium,),
//                     if (provider.filterAll == true)
//                     Icon(Icons.check),
//                     if (provider.filterAll == false)
//                       Icon(
//                         Icons.circle,
//                         color: TColors.secondaryBorder30,
//                       )
//                   ],
//                 ),
//               ),
//               ListTile(
//                 onTap: (){
//                   showModalBottomSheet(
//                       // isDismissible: false,
//                       isScrollControlled: true,
//                       // enableDrag: false,
//                       context: context,
//                       builder: (cdx) => DateList()
//                   );
//                 },
//                 contentPadding: EdgeInsets.symmetric(horizontal: 10),
//                 title: Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   crossAxisAlignment: CrossAxisAlignment.center,
//                   children: [
//                     Text('Date', style: Theme.of(context).textTheme.labelMedium,),
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       crossAxisAlignment: CrossAxisAlignment.center,
//                       children: [
//                         Text(
//                           '${getDateValue(provider.selectedDate)} days',
//                           style: Theme.of(context).textTheme.labelSmall,
//                         ),
//                         Icon(Icons.chevron_right, color: TColors.textPrimary.withOpacity(0.5),)
//                       ],
//                     ),
//                   ],
//                 ),
//               ),
//               ListTile(
//                 onTap: (){
//                   showModalBottomSheet(
//                       // isDismissible: false,
//                       isScrollControlled: true,
//                       // enableDrag: false,
//                       context: context,
//                       builder: (cdx) => const CurrencyList()
//                   );
//                 },
//                 contentPadding: EdgeInsets.symmetric(horizontal: 10),
//                 title: Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   crossAxisAlignment: CrossAxisAlignment.center,
//                   children: [
//                     Text('Currency', style: Theme.of(context).textTheme.labelMedium,),
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       crossAxisAlignment: CrossAxisAlignment.center,
//                       children: [
//                         Text(getCurrencyName(selectedCurrency) ?? '', style: Theme.of(context).textTheme.labelSmall,),
//                         Icon(Icons.chevron_right, color: TColors.textPrimary.withOpacity(0.5),)
//                       ],
//                     ),
//                   ],
//                 ),
//               ),
//               const SizedBox(height: TSizes.spaceBtwSections / 2),
//               TElevatedButton(onTap: (){
//                 if (provider.filterAll == true) {
//                   // OfferService.instance.getAllOffers(
//                   //     offerProvider: provider,
//                   //     currency: '',
//                   //     date: ''
//                   // );
//                   Get.back();
//                 } else {
//                   // OfferService.instance.getAllOffers(
//                   //     offerProvider: provider,
//                   //     currency: getCurrencyName(selectedCurrency),
//                   //     date: getDateValue(selectedDate)
//                   // );
//                   Get.back();
//                 }
//                 }, buttonText: 'Apply')
//             ],
//           )
//       ),
//     );
//   }
// }

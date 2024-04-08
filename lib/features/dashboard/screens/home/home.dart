import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:swappr/common/styles/spacing_styles.dart';
import 'package:swappr/features/dashboard/screens/home/icons/svg.dart';
import 'package:swappr/features/dashboard/screens/home/widgets/all_offers_list.dart';
import 'package:swappr/features/dashboard/screens/home/create_offer.dart';
import 'package:swappr/features/dashboard/screens/home/widgets/filter_screen.dart';
import 'package:swappr/features/dashboard/screens/home/widgets/no_offer.dart';
import 'package:swappr/utils/constants/colors.dart';
import 'package:swappr/utils/constants/sizes.dart';
import 'package:swappr/utils/layouts/list_layout.dart';
import '../../../../common/widgets/buttons/floating_button.dart';
import '../../../../common/widgets/currencyWidget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String updatedCurrency = '';

  void updateData(String newData) {
    setState(() {
      updatedCurrency = newData;
    });
  }

  @override
  Widget build(BuildContext context) {
    const int offer = 1;
    return Scaffold(
      body: Padding(
        padding: TSpacingStyle.dashboardPadding,
        child: Column(
          children: [
            const CurrencyWidget(),
            Expanded(
              child: SingleChildScrollView(
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
                              if (updatedCurrency != '')
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
                                              text: 'Currency: ${updatedCurrency}',
                                              style: TextStyle(color: TColors.white)
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
                                      isDismissible: false,
                                      isScrollControlled: true,
                                      enableDrag: false,
                                      context: context,
                                      builder: (cdx) =>  FilterScreen(updateData)
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
                      if (offer == 0)
                        const NoOfferScreen(),
                      if (offer > 0)
                        const SizedBox(height: TSizes.md,),
                      if (offer > 0)
                        Column(
                          children: [
                            TListLayout(
                                itemCount: 14,
                                itemBuilder: (_, index) => const AllOffersListScreen()
                            )
                          ],
                        )
                    ],
                  ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: TFloatingButton(
        onPressed: (){Get.to(() => const CreateOfferScreen());},
      ),
    );
  }
}

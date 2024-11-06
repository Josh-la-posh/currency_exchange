import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pouch/utils/constants/colors.dart';
import 'package:pouch/utils/helpers/helper_functions.dart';
import '../controller/currency_rate_controller.dart';
import 'package:carousel_slider/carousel_slider.dart';

class CurrencyWidget extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    final CurrencyController _controller = Get.put(CurrencyController());
    final darkMode = THelperFunctions.isDarkMode(context);
    return Container(
      color: darkMode ? Colors.black : TColors.primary.withOpacity(0.3),
      child: Padding(
        padding: const EdgeInsets.only(left: 16.0, right: 16.0, bottom: 10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Obx(
                      () => DropdownButton<String>(
                    value: _controller.selectedCurrency.value,
                    onChanged: (newCurrency) =>
                        _controller.updateCurrency(newCurrency!),
                    items: _controller.currencies.map((currency) {
                      return DropdownMenuItem(
                        value: currency,
                        child: Text(
                          currency,
                          style: Theme.of(context).textTheme.labelMedium?.copyWith(
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ),
                Text('Daily Exchange Rate',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w500,
                    fontSize: 14
                  ),
                ),
                SizedBox(),
              ],
            ),
            Obx(
                  () => _controller.currencyRates.isEmpty
                  ? const CircularProgressIndicator()
                  : CarouselSlider(
                    options: CarouselOptions(
                        height: 40.0,
                        autoPlay: true,
                        enlargeCenterPage: true,
                        viewportFraction: 0.6,
                        // autoPlayInterval: Duration(seconds: 2),
                        // autoPlayAnimationDuration: Duration(milliseconds: 200)

                ),
                items: _controller.currencyRates.map((rate) {
                  return Builder(
                    builder: (BuildContext context) {
                      return Center(
                        child: Container(
                          height: 20.0,
                          decoration: BoxDecoration(
                            border: Border(
                              right: BorderSide(
                                color: darkMode ? Colors.white : Colors.black,
                                width: 1,
                              )
                            )
                          ),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                '1 ${_controller.selectedCurrency.value}',
                                style: Theme.of(context).textTheme.labelMedium?.copyWith(
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              const SizedBox(width: 7),
                              Icon(Icons.sync_alt_outlined, size: 12, color: darkMode ? Colors.white : Colors.black),
                              const SizedBox(width: 7),
                              Text(
                                '${rate['rate'].toStringAsFixed(4)} ${rate['currency']}',
                                style: const TextStyle(
                                  fontSize: 16.0,
                                  fontWeight: FontWeight.w500,
                                  color: TColors.primary
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  );
                }).toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
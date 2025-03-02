import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pouch/utils/constants/colors.dart';

class AutoSwapItem extends StatelessWidget {
  const AutoSwapItem({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: Get.isDarkMode ? Colors.black : Colors.white
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text('Seller Has:',
                    style: TextStyle(
                      color: TColors.primary,
                      fontSize: 14,
                      fontWeight: FontWeight.w400
                    ),
                  ),
                  SizedBox(width: 6,),
                  Text('100.00 USD',
                    style: TextStyle(
                        color: TColors.primary,
                        fontSize: 14,
                        fontWeight: FontWeight.w500
                    ),
                  )
                ],
              ),
              SizedBox(height: 10,),
              Row(
                children: [
                  Text('Seller Need:',
                    style: TextStyle(
                        color: TColors.primary,
                        fontSize: 14,
                        fontWeight: FontWeight.w400
                    ),
                  ),
                  SizedBox(width: 6,),
                  Text('NGN',
                    style: TextStyle(
                        color: TColors.primary,
                        fontSize: 14,
                        fontWeight: FontWeight.w800
                    ),
                  )
                ],
              )
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Switch(
                      value: true,
                      onChanged: (val) {},
                  ),
                  SizedBox(width: 6,),
                  Text('Prefer Rate',
                    style: TextStyle(
                        color: TColors.primary,
                        fontSize: 9,
                        fontWeight: FontWeight.w500
                    ),
                  )
                ],
              ),
              SizedBox(height: 4,),
              Text('1500 USD // NGN',
                style: TextStyle(
                    color: TColors.primary,
                    fontSize: 13,
                    fontWeight: FontWeight.w600
                ),
              ),
              SizedBox(height: 4,),
              Text('July 22',
                style: TextStyle(
                    color: TColors.primary,
                    fontSize: 12,
                    fontWeight: FontWeight.w400
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}

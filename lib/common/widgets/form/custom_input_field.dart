import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomInputField extends StatelessWidget {
  final String label;
  const CustomInputField({super.key, required this.label});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        RichText(
            text: TextSpan(
                style: TextStyle(
                    color: Get.isDarkMode ? Colors.white : Colors.black,
                    fontWeight: FontWeight.w600,
                    fontSize: 12,
                    fontFamily: 'Roboto'
                ),
                children: <TextSpan> [
                  TextSpan(
                    text: label,
                  ),
                ]
            )
        ),
        const SizedBox(height: 10,),
        TextFormField(
          // initialValue: addBankController.bankAccountDetails.value.account_name == null
          //     ? ''
          //     : addBankController.bankAccountDetails.value.account_name,
          style: Theme.of(context).textTheme.bodyMedium,
        ),
      ],
    );
  }
}

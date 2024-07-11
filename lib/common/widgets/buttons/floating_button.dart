import 'package:flutter/material.dart';
import 'package:pouch/utils/constants/sizes.dart';

class TFloatingButton extends StatelessWidget {
  TFloatingButton({
    super.key,
    required this.onPressed,
  });

  VoidCallback onPressed;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: TSizes.md,bottom: TSizes.spaceBtwItems),
      child: SizedBox(
        width: 45,
        height: 45,
        child: FloatingActionButton(
          onPressed: onPressed,
          child: Icon(Icons.add),
        ),
      ),
    );
  }
}

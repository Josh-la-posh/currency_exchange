import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomSwitch extends StatelessWidget {
  final RxBool value;
  final VoidCallback onChanged;

  const CustomSwitch({
    Key? key,
    required this.value,
    required this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Transform.scale(
      scale: 0.8,
      child: Obx(() => Switch(
        value: value.value,
        onChanged: (val) => onChanged(),
      )),
    );
  }
}

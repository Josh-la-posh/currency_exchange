import 'package:flutter/material.dart';
import 'package:swappr/utils/constants/colors.dart';
import 'package:swappr/utils/constants/sizes.dart';
import 'package:swappr/utils/constants/texts.dart';

class TElevatedButton extends StatelessWidget {
  TElevatedButton({
    super.key,
    required this.onTap,
    required this.buttonText,
  });
  VoidCallback onTap;
  String buttonText;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 48.0,
      child: ElevatedButton(
        onPressed: onTap,
        child: Center(child: Text(buttonText),),
      ),
    );
  }
}

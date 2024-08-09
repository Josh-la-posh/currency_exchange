import 'package:flutter/material.dart';
import '../../../utils/constants/colors.dart';
import '../../../utils/constants/sizes.dart';

class SectionWidgetContainer extends StatelessWidget {
  final VoidCallback onTap;
  final bool darkMode;
  final String title;
  final String image;
  final Icon icon;
  const SectionWidgetContainer({super.key, required this.onTap, required this.darkMode, required this.title, required this.image, required this.icon});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(40)
            ),
            // child: Image(image: AssetImage(image)),
            child: icon,
          ),
          RichText(
              textAlign: TextAlign.center,
              text: TextSpan(
                  style: Theme.of(context).textTheme.labelSmall,
                  children: <TextSpan> [
                    TextSpan(
                        text: title,
                        style: TextStyle(
                            color: darkMode ? Colors.white : TColors.textPrimary,
                            height: 1.2
                        )
                    ),
                  ]
              )
          ),
        ],
      ),
    );
  }
}

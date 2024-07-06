import 'package:flutter/material.dart';
import '../../../utils/constants/colors.dart';
import '../../../utils/constants/sizes.dart';

class SectionWidgetContainer extends StatelessWidget {
  final VoidCallback onTap;
  final bool darkMode;
  final String title;
  final String image;
  const SectionWidgetContainer({super.key, required this.onTap, required this.darkMode, required this.title, required this.image});

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
            child: Image(image: AssetImage(image)),
          ),
          const SizedBox(height: 7,),
          RichText(
              textAlign: TextAlign.center,
              text: TextSpan(
                  style: Theme.of(context).textTheme.labelSmall,
                  children: <TextSpan> [
                    TextSpan(
                        text: title,
                        style: TextStyle(
                            fontWeight: TSizes.fontWeightMd,
                            color: darkMode ? Colors.white.withOpacity(0.7) : TColors.textPrimary
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

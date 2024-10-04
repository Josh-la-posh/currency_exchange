import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pouch/utils/constants/colors.dart';
import 'package:pouch/utils/helpers/helper_functions.dart';
import '../../../../utils/constants/sizes.dart';
import '../../icons/svg.dart';

class ProfileLinkWidget extends StatelessWidget {
  ProfileLinkWidget({
    super.key,
    required this.title,
    required this.onPressed,
    this.icon,
    this.rightText
  });

  String title;
  VoidCallback onPressed;
  Widget? icon;
  String? rightText;

  @override
  Widget build(BuildContext context) {
    final darkMode = THelperFunctions.isDarkMode(context);
    return ListTile(
      tileColor: darkMode ? TColors.textPrimaryO40 : Colors.white,
      hoverColor: Colors.transparent,
      splashColor: Colors.transparent,
      onTap: onPressed,
      contentPadding: EdgeInsets.only(left: TSizes.defaultSpace * 0.7, right: TSizes.defaultSpace * 0.7),
      title: SizedBox(
        height: 48,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                if (icon != null)
                SizedBox(
                  height: 29,
                  width: 29,
                  child: Padding(
                    padding: const EdgeInsets.all(5.5),
                    child: icon,
                  ),
                ),
                const SizedBox(width: 10,),
                RichText(
                    text: TextSpan(
                        style: Theme.of(context).textTheme.labelMedium,
                        children: <TextSpan> [
                          TextSpan(
                              text: title,
                              style: TextStyle(
                                  fontSize: 15,
                                  // fontWeight: FontWeight.w600
                              )
                          )
                        ]
                    )
                ),
              ],
            ),
            Spacer(),
            Text(rightText == null ? '' : rightText.toString(), style: TextStyle(
              color: CupertinoColors.inactiveGray,
              fontSize: 12,
            ),),
            const SizedBox(width: 6),
            Icon(Icons.arrow_forward, color: CupertinoColors.inactiveGray, size: 13,)
            // SizedBox(
            //     height: 15,
            //     width: 15,
            //     child: IconRight()
            // )
          ],
        ),
      ),
    );
  }
}
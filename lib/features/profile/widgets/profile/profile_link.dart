import 'package:flutter/material.dart';
import '../../../../utils/constants/sizes.dart';
import '../../icons/svg.dart';

class ProfileLinkWidget extends StatelessWidget {
  ProfileLinkWidget({
    super.key,
    required this.title,
    required this.onPressed,
    required this.icon
  });

  String title;
  VoidCallback onPressed;
  Widget icon;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 64,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: 28,
                width: 28,
                child: Padding(
                  padding: const EdgeInsets.all(5.5),
                  child: icon,
                ),
              ),
              const SizedBox(width: 10,),
              FittedBox(
                fit: BoxFit.fill,
                child: RichText(
                    text: TextSpan(
                        style: Theme.of(context).textTheme.labelMedium,
                        children: <TextSpan> [
                          TextSpan(
                              text: title,
                              style: TextStyle(
                                  fontSize: TSizes.fontSize16,
                                  // fontWeight: FontWeight.w600
                              )
                          )
                        ]
                    )
                ),
              ),
            ],
          ),
          SizedBox(
              height: 34,
              width: 34,
              child: IconButton(onPressed: onPressed, icon: IconRight())
          )
        ],
      ),
    );
  }
}
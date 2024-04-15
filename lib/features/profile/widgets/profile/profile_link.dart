import 'package:flutter/material.dart';
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
                height: 25,
                width: 25,
                child: Padding(
                  padding: const EdgeInsets.all(5.5),
                  child: icon,
                ),
              ),
              const SizedBox(width: 10,),
              Text(title, style: Theme.of(context).textTheme.labelMedium,)
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
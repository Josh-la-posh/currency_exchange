import 'package:flutter/material.dart';

import '../../../utils/constants/colors.dart';

class DeleteButtonWidget extends StatelessWidget {
  const DeleteButtonWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(Icons.delete, color: TColors.white,),
        RichText(
            text: TextSpan(
                style: Theme.of(context).textTheme.labelSmall,
                children: const <TextSpan> [
                  TextSpan(
                      text: 'Delete',
                      style: TextStyle(color: TColors.white)
                  )
                ]
            )
        ),
      ],
    );
  }
}
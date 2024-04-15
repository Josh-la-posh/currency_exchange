import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import '../../../common/widgets/success_screen.dart';
import '../../../utils/constants/sizes.dart';
import '../icons/svg.dart';

class CreateOfferSuccessPage extends StatelessWidget {
  const CreateOfferSuccessPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SuccessScreenWidget(
      child: Column(
        children: [
          Column(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  SizedBox(
                      width: 45,
                      child: Text('11:23', style: Theme.of(context).textTheme.labelSmall)
                  ),
                  const SizedBox(width: TSizes.sm,),
                  SizedBox(
                      width: 30,
                      child: Column(
                        children: [

                          RectIcon(),
                          EllipseIcon(),
                        ],
                      )
                  ),
                  const SizedBox(width: TSizes.lg,),
                  Text('You created this offer', style: Theme.of(context).textTheme.labelMedium)
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}


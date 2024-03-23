import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:iconsax/iconsax.dart';
import 'package:swappr/common/widgets/buttons/elevated_button.dart';
import 'package:swappr/utils/constants/colors.dart';
import 'package:swappr/utils/constants/texts.dart';
import 'package:swappr/utils/helpers/helper_functions.dart';

import '../../../../../utils/constants/sizes.dart';

class SignUpForm extends StatelessWidget {
  const SignUpForm({
    super.key,
  });
  @override
  Widget build(BuildContext context) {
    return Form(
        child: Padding(
          padding: const EdgeInsets.only(top: TSizes.spaceBtwSections - 4),
          child: Column(
            children: [
              /// Fulll Name
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Full Name', style: Theme.of(context).textTheme.labelMedium,),
                  const SizedBox(height: TSizes.sm),
                  SizedBox(
                    height: 48,
                    child: TextFormField(
                      decoration: const InputDecoration(
                      ),
                    ),
                  )
                ],
              ),
              const SizedBox(height: TSizes.spaceBtwInputFields),

              /// Email
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Email', style: Theme.of(context).textTheme.labelMedium,),
                  const SizedBox(height: TSizes.sm),
                  SizedBox(
                    height: 48,
                    child: TextFormField(),
                  )
                ],
              ),
              const SizedBox(height: TSizes.spaceBtwInputFields),

              /// Phone No
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Phone Number', style: Theme.of(context).textTheme.labelMedium,),
                  const SizedBox(height: TSizes.sm),
                  SizedBox(
                    height: 48,
                    child: Row(
                      children: [
                        Container(
                          width: 69,
                          height: 48,
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: TColors.secondaryBorder,
                              width: 1
                            )
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text('da'),
                              SizedBox(width: TSizes.xs,),
                              Text('+1', style: Theme.of(context).textTheme.labelMedium,)
                            ],
                          ),
                        ),
                        Expanded(child: TextFormField()),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: TSizes.spaceBtwInputFields),

              /// Country
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Country', style: Theme.of(context).textTheme.labelMedium,),
                  const SizedBox(height: TSizes.sm),
                  SizedBox(
                    height: 48,
                    child: TextFormField(),
                  )
                ],
              ),
              const SizedBox(height: TSizes.spaceBtwInputFields),

              /// Password
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Password', style: Theme.of(context).textTheme.labelMedium,),
                  const SizedBox(height: TSizes.sm),
                  SizedBox(
                    height: 48,
                    child: TextFormField(
                      // obscureText: ,
                      decoration: const InputDecoration(
                        suffixIcon: Icon(Iconsax.eye_slash),
                      ),
                    ),
                  )
                ],
              ),
              const SizedBox(height: TSizes.spaceBtwInputFields),

              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Checkbox(value: false, onChanged: (value){}),
                  Text(
                    'I understand Swappr Terms of Use',
                    style: Theme.of(context).textTheme.labelMedium,
                  )
                ],
              ),

              const SizedBox(height: TSizes.spaceBtwInputFields * 1.5),

              TElevatedButton(onTap: (){}, buttonText: 'Sign Up')
            ],
          ),
        )
    );
  }
}
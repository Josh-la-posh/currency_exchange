// import 'package:fl_country_code_picker/fl_country_code_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:iconsax/iconsax.dart';
import 'package:swappr/common/widgets/buttons/elevated_button.dart';
import 'package:intl_phone_field/intl_phone_field.dart';

import '../../../../../utils/constants/colors.dart';
import '../../../../../utils/constants/sizes.dart';
import '../../login/login.dart';

class SignUpForm extends StatefulWidget {
  SignUpForm({
    super.key,
  });

  @override
  State<SignUpForm> createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  // final countryPicker = const FlCountryCodePicker();
  //
  // CountryCode? countryCode;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Form(
            child: Column(
              children: [
                /// Name
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('First Name', style: Theme.of(context).textTheme.labelMedium,),
                    SizedBox(
                      height: TSizes.textInputFieldHeight,
                      child: TextFormField(
                        decoration: const InputDecoration(),
                      ),
                    )
                  ],
                ),
                const SizedBox(height: TSizes.spaceBtwInputFields),


                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Last Name', style: Theme.of(context).textTheme.labelMedium,),
                    SizedBox(
                      height: TSizes.textInputFieldHeight,
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
                    SizedBox(
                      height: TSizes.textInputFieldHeight,
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
                    IntlPhoneField(
                      style: Theme.of(context).textTheme.labelMedium,
                    ),
                  ],
                ),
                const SizedBox(height: TSizes.spaceBtwInputFields),

                /// Country
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Country', style: Theme.of(context).textTheme.labelMedium,),
                    SizedBox(
                      height: TSizes.textInputFieldHeight,
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
                    SizedBox(
                      height: TSizes.textInputFieldHeight,
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

                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Confirm Password', style: Theme.of(context).textTheme.labelMedium,),
                    SizedBox(
                      height: TSizes.textInputFieldHeight,
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

                SizedBox(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Checkbox(value: true, onChanged: (value){}),
                      Text(
                        'I understand Swappr Terms of Use',
                        style: Theme.of(context).textTheme.labelMedium,
                      )
                    ],
                  ),
                ),

                const SizedBox(height: TSizes.spaceBtwElements),

                TElevatedButton(onTap: (){}, buttonText: 'Sign Up')
              ],
            )
        ),
        const SizedBox(height: TSizes.spaceBtwInputFields),
        Center(
          child: TextButton(
              onPressed: (){Get.to(() => const LoginScreen());},
              child: Text('Already signed up? Log In', style: Theme.of(context).textTheme.labelMedium,)
          ),
        )
      ],
    );
  }
}
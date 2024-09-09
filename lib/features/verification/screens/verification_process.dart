import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pouch/features/verification/screens/country_select.dart';
import 'package:pouch/utils/helpers/helper_functions.dart';
import '../../../utils/constants/colors.dart';
import '../../../utils/constants/sizes.dart';

class VerificationProcess extends StatefulWidget {
  const VerificationProcess({super.key});

  @override
  State<VerificationProcess> createState() => _VerificationProcessState();
}

class _VerificationProcessState extends State<VerificationProcess> {
  Country? _selectedCountry;
  @override
  Widget build(BuildContext context) {
    final darkMode = THelperFunctions.isDarkMode(context);
    return Scaffold(
      backgroundColor: darkMode ? TColors.black.withOpacity(0.8) : TColors.secondaryBorder,
      appBar: AppBar(
        title: RichText(
            text: TextSpan(
                style: Theme.of(context).textTheme.headlineLarge,
                children: <TextSpan> [
                  TextSpan(
                      text: 'Verification Process',
                      style: TextStyle(
                        fontSize: 20,
                        // color: TColors.textPrimaryO80
                      )
                  ),
                ]
            )
        ),
        centerTitle: true,
        leading: InkWell(
            onTap: () {Get.back();},
            child: const Icon(Icons.arrow_back_ios_outlined)
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(TSizes.defaultSpace * 2),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(
                height: 100,
                width: 100,
                child: Image(image: AssetImage('assets/icons/verifyIcons/verify_process.png'))
            ),
            const SizedBox(height: TSizes.defaultSpace * 2,),
            RichText(
                text: TextSpan(
                    style: Theme.of(context).textTheme.headlineLarge,
                    children: <TextSpan> [
                      TextSpan(
                          text: 'Choose Your County',
                          style: TextStyle(
                              fontSize: 18,
                              // color: TColors.textPrimaryO80
                          )
                      ),
                    ]
                )
            ),
            const SizedBox(height: TSizes.defaultSpace * 1.5,),
            RichText(
              textAlign: TextAlign.center,
                text: TextSpan(
                    style: Theme.of(context).textTheme.headlineLarge,
                    children: <TextSpan> [
                      TextSpan(
                          text: 'Please Select Your Country for Verification. \n Thank You',
                          style: TextStyle(
                              fontSize: 11,
                              height: 1.4,
                              // color: TColors.textPrimaryO80
                          )
                      ),
                    ]
                )
            ),
            const SizedBox(height: TSizes.defaultSpace * 1.5,),
            _selectedCountry == null
                ? ElevatedButton(
              style: const ButtonStyle(
                backgroundColor: MaterialStatePropertyAll(TColors.darkPrimaryButton),
                iconSize: MaterialStatePropertyAll(50)
              ),
                onPressed: (){
                  showCountryPicker(
                      context: context,
                      favorite: <String>['NG'],
                      countryListTheme: CountryListThemeData(
                          flagSize: 18,
                          backgroundColor: darkMode ? Colors.black : Colors.white,
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(20),
                              topRight: Radius.circular(20)
                          ),
                          inputDecoration: InputDecoration(
                            labelText: 'Search Country...',
                            hintText: 'Start typing to search',
                            prefixIcon: const Icon(Icons.search),
                          )
                      ),
                      onSelect: (Country country) {
                        setState(() {
                          _selectedCountry = country;
                        });
                      }
                  );
                },
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Select Country',
                      style: TextStyle(
                        color: TColors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w500
                      ),
                    ),
                    Icon(Icons.arrow_right_alt_sharp)
                  ],
                )
            )
                : SizedBox(
              height: 48,
              width: double.infinity,
                  child: ElevatedButton(
                  style: const ButtonStyle(
                      backgroundColor: MaterialStatePropertyAll(TColors.darkPrimaryButton),
                      iconSize: MaterialStatePropertyAll(50)
                  ),
                  onPressed: (){
                    Get.to(() => CountrySelectionPage(country: _selectedCountry));
                  },
                  child: Text(
                    'Next',
                    style: TextStyle(
                        color: TColors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w500
                    ),
                  )
                                    ),
                ),
            SizedBox(height: 20,),
            if (_selectedCountry != null)
            SizedBox(
              height: 48,
              width: double.infinity,
              child: ElevatedButton(
                  style: const ButtonStyle(
                      backgroundColor: MaterialStatePropertyAll(TColors.darkPrimaryButton),
                      iconSize: MaterialStatePropertyAll(50)
                  ),
                  onPressed: (){
                    showCountryPicker(
                        context: context,
                        favorite: <String>['NG'],
                        countryListTheme: CountryListThemeData(
                            flagSize: 18,
                            backgroundColor: darkMode ? Colors.black : Colors.white,
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(20),
                                topRight: Radius.circular(20)
                            ),
                            inputDecoration: InputDecoration(
                              labelText: 'Search Country...',
                              hintText: 'Start typing to search',
                              prefixIcon: const Icon(Icons.search),
                            )
                        ),
                        onSelect: (Country country) {
                          setState(() {
                            _selectedCountry = country;
                          });
                        }
                    );
                  },
                  child: Text(
                    'Change Country',
                    style: TextStyle(
                        color: TColors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w500
                    ),
                  )
              ),
            )

          ],
        ),
      ),
    );
  }
}
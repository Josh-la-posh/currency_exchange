import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pouch/features/authentication/controllers/auth_controller.dart';
import 'package:pouch/features/verification/controller/verification_controller.dart';
import 'package:pouch/features/verification/screens/verification_in_progress.dart';
import 'package:smile_id/smile_id_biometric_kyc.dart';
import 'package:smile_id/smile_id_enhanced_document_verification.dart';
import '../../../common/widgets/buttons/elevated_button.dart';
import '../../../utils/constants/colors.dart';
import '../../../utils/constants/sizes.dart';
import '../../../utils/helpers/helper_functions.dart';

class IdentityVerificationTypeScreen extends StatelessWidget {
  final verificationController = Get.find<VerificationController>();
  final authController = Get.find<AuthController>();

  @override
  Widget build(BuildContext context) {
    verificationController.fetchSmileData();
    final darkMode = THelperFunctions.isDarkMode(context);
    return Scaffold(
      backgroundColor: darkMode ? TColors.black.withOpacity(0.8) : TColors.secondaryBorder,
      appBar: AppBar(
        title: RichText(
            text: TextSpan(
                style: Theme.of(context).textTheme.headlineLarge,
                children: <TextSpan> [
                  TextSpan(
                      text: 'Identity Verification',
                      style: TextStyle(
                        fontSize: 16
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
        padding: const EdgeInsets.symmetric(horizontal: TSizes.defaultSpace),
        child: Column(
          children: [
            const SizedBox(height: TSizes.defaultSpace),
            RichText(
              textAlign: TextAlign.center,
                text: TextSpan(
                    style: Theme.of(context).textTheme.bodySmall,
                    children: <TextSpan> [
                      TextSpan(
                          text: 'A 60-second timer has begun. Your photo from the chosen document will be used for comparison.',
                          style: TextStyle(
                              height: 1.5,
                              fontSize: 11
                          )
                      ),
                    ]
                )
            ),
            const SizedBox(height: TSizes.defaultSpace),
            Obx(() {
              if (verificationController.isLoading.value) {
                return CircularProgressIndicator();
              } else {
                return Column(
                  children: [
                    ...verificationController.idTypes.map((id) {
                  return GestureDetector(
                    onTap: () {
                      if (verificationController.selectedCountry.value!.countryCode == 'NG') {
                        _showBvnDialog(context, () {
                          verificationController.validateBvnNumber();
                          if (verificationController.showErrorText.value == false) {
                            Navigator.of(context).push(
                              MaterialPageRoute<void>(
                                builder: (BuildContext context) => Scaffold(
                                    body: SmileIDBiometricKYC(
                                      country: 'NG',
                                      idType: id['code'],
                                      idNumber: verificationController.bvnNumber.value,
                                      userId: authController.user.value?.id,
                                      jobId: 'user_${DateTime.now().millisecondsSinceEpoch}_${UniqueKey().toString()}',
                                      onSuccess: (String? result) {
                                        Map<String, dynamic> jsonResult = json.decode(result ?? '{}');
                                        String formattedResult = jsonEncode(jsonResult);
                                        final snackBar = SnackBar(content: Text("Success: $formattedResult"));
                                        print("Success: $formattedResult");
                                        Navigator.pop(context);
                                        Get.to(() => const VerificationInProgressScreen());

                                      },
                                      onError: (String errorMessage) {
                                        final snackBar = SnackBar(content: Text("Error: $errorMessage"));
                                        ScaffoldMessenger.of(context).showSnackBar(snackBar);
                                        Navigator.of(context).pop();
                                      },
                                    )),
                              ),
                            );
                          }
                        });
                      } else {
                        if (id['has_back']) {
                          Navigator.of(context).push(
                            MaterialPageRoute<void>(
                              builder: (BuildContext context) => Scaffold(
                                  body: SmileIDEnhancedDocumentVerification(
                                    countryCode: verificationController.selectedCountry.value!.countryCode,
                                    documentType: id['code'],
                                    userId: authController.user.value?.id,
                                    captureBothSides: true,
                                    jobId: 'user_${DateTime.now().millisecondsSinceEpoch}_${UniqueKey().toString()}',
                                    onSuccess: (String? result) {
                                      // Your success handling logic
                                      Map<String, dynamic> jsonResult = json.decode(result ?? '{}');
                                      String formattedResult = jsonEncode(jsonResult);
                                      final snackBar = SnackBar(content: Text("Success: $formattedResult"));
                                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
                                      Navigator.of(context).pop();
                                    },
                                    onError: (String errorMessage) {
                                      // Your error handling logic
                                      final snackBar = SnackBar(content: Text("Error: $errorMessage"));
                                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
                                      Navigator.of(context).pop();
                                    },
                                  )),
                            ),
                          );
                        } else {
                          Navigator.of(context).push(
                            MaterialPageRoute<void>(
                              builder: (BuildContext context) => Scaffold(
                                  body: SmileIDEnhancedDocumentVerification(
                                    countryCode: verificationController.selectedCountry.value!.countryCode,
                                    documentType: id['code'],
                                    userId: authController.user.value?.id,
                                    captureBothSides: false,
                                    jobId: 'user_${DateTime.now().millisecondsSinceEpoch}_${UniqueKey().toString()}',
                                    onSuccess: (String? result) {
                                      Map<String, dynamic> jsonResult = json.decode(result ?? '{}');
                                      String formattedResult = jsonEncode(jsonResult);
                                      final snackBar = SnackBar(content: Text("Success: $formattedResult"));
                                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
                                      Navigator.of(context).pop();
                                    },
                                    onError: (String errorMessage) {
                                      final snackBar = SnackBar(content: Text("Error: $errorMessage"));
                                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
                                      Navigator.of(context).pop();
                                    },
                                  )),
                            ),
                          );
                        }
                      }
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 7),
                      margin: EdgeInsets.only(bottom: 30),
                      height: 52,
                      decoration: BoxDecoration(
                          color: darkMode ? TColors.white.withOpacity(0.5) : TColors.white,
                          borderRadius: BorderRadius.circular(10)
                      ),
                      child: Row(
                        children: [
                          const SizedBox(
                              width: 40,
                              height: 40,
                              child: Image(image: AssetImage('assets/icons/verifyIcons/passport.png'))
                          ),
                          const SizedBox(width: TSizes.sm),
                          Expanded(
                            child: SizedBox(
                              child: RichText(
                                  text: TextSpan(
                                      style: Theme.of(context).textTheme.titleMedium,
                                      children: <TextSpan> [
                                        TextSpan(
                                            text: id['name'],
                                            style: TextStyle(
                                                color: darkMode ? TColors.white : TColors.textPrimaryO80
                                            )
                                        ),
                                      ]
                                  )
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                }).toList()
                  ],
                );
              }
            }),
          ],
        ),
      ),
    );
  }

  void _showBvnDialog(BuildContext context, VoidCallback onContinue) {
    showDialog(
      context: context,
      builder: (_) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          content: SizedBox(
            height: 240,
            width: 200,
            child: Column(
              children: [
                RichText(
                  text: TextSpan(
                    style: Theme.of(context).textTheme.labelSmall,
                    children: [
                      TextSpan(
                        text: 'ID number',
                        style: TextStyle(fontSize: 16, fontWeight: TSizes.fontWeightLg),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: TSizes.defaultSpace * 1.4),
                _buildBvnInputField(context),
                const SizedBox(height: TSizes.sm),
                Obx(() => Visibility(
                  visible: verificationController.showErrorText.value,
                  child: RichText(
                    text: TextSpan(
                      style: Theme.of(context).textTheme.labelSmall,
                      children: [
                        TextSpan(
                          text: 'Enter a valid ID number',
                          style: TextStyle(fontSize: 10, color: Colors.red),
                        ),
                      ],
                    ),
                  ),
                )),
                const SizedBox(height: TSizes.defaultSpace * 1.4),
                SizedBox(
                  height: 40,
                  width: 140,
                  child: TElevatedButton(
                    onTap: onContinue,
                    buttonText: 'Continue',
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildBvnInputField(BuildContext context) {
    return TextFormField(
      focusNode: verificationController.bvnFocusNode,
      textAlign: TextAlign.center,
      style: Theme.of(context).textTheme.titleLarge,
      onChanged: (val) {
        verificationController.bvnNumber.value = val;
      },
      decoration: const InputDecoration(
        contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
        border: OutlineInputBorder(),
        hintText: 'Enter your ID number',
      ),
    );
  }
}

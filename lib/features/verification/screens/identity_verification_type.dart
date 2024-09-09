import 'dart:convert';

import 'package:country_picker/country_picker.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:pouch/data/provider/auth_provider.dart';
import 'package:pouch/features/verification/screens/verification_in_progress.dart';
import 'package:provider/provider.dart';
import 'package:smile_id/smile_id_biometric_kyc.dart';
import 'package:smile_id/smile_id_enhanced_document_verification.dart';
import '../../../common/widgets/buttons/elevated_button.dart';
import '../../../data/modules/app_navigator.dart';
import '../../../utils/constants/colors.dart';
import '../../../utils/constants/sizes.dart';
import '../../../utils/helpers/helper_functions.dart';
import '../../../utils/validators/validation.dart';

class IdentityVerificationTypeScreen extends StatefulWidget {
  Country? country;
  IdentityVerificationTypeScreen({super.key, this.country});

  @override
  State<IdentityVerificationTypeScreen> createState() => _IdentityVerificationTypeScreenState();
}

class _IdentityVerificationTypeScreenState extends State<IdentityVerificationTypeScreen> {
  late AuthProvider auth;
  String bvnNumber = '';
  bool showErrorText = false;
  bool isLoading = false;
  FocusNode bvnFocusNode = FocusNode();
  List idTypes = [];

  @override
  void initState() {
    super.initState();
    auth = Provider.of<AuthProvider>(
        AppNavigator.instance.navigatorKey.currentContext as BuildContext,
        listen: false
    );
    bvnFocusNode.addListener(() {
      if (!bvnFocusNode.hasFocus) {
        validateBvnNumber();
      }
    });
    fetchSmileData();
  }

  Future<void> fetchSmileData() async {
    setState(() {
      isLoading = true;
    });
    final Dio _dio = Dio();
    const String url = 'https://api.smileidentity.com/v1/valid_documents';
    try {
      final response = await _dio.get('$url?country_code=${widget.country?.countryCode}');
      final data = response.data['valid_documents'][0]['id_types'];
      setState(() {
        idTypes = data;
      });

    } on DioError catch (e) {
      // Handle Dio errors
      if (e.response != null) {
        print('Dio error: ${e.response?.data}');
        print('Status code: ${e.response?.statusCode}');
      } else {
        // Something went wrong before the response (e.g., network issue)
        print('Error: ${e.message}');
      }
    } catch (e) {
      // Handle other types of errors
      print('Unexpected error: $e');
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  void dispose() {
    bvnFocusNode
        .dispose();
    super.dispose();
  }

  void validateBvnNumber() {
    if (bvnNumber.isEmpty || bvnNumber.length < 10) {
      setState(() {
        showErrorText = true;
      });
    } else {
      setState(() {
        showErrorText = false;
      });
    }
  }

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
                      text: 'Identity Verification',
                      style: TextStyle(
                        fontSize: 20
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
        padding: const EdgeInsets.symmetric(horizontal: TSizes.defaultSpace * 2),
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
            if (isLoading)
              Text('Fetching data ....'),
            ...idTypes.map((id) {
              return GestureDetector(
                onTap: () {
                  if (widget.country?.countryCode == 'NG') {
                    _showBvnDialog(context, () {
                      if (bvnNumber.isEmpty || bvnNumber.length < 10) {
                        validateBvnNumber();
                      } else {
                        Navigator.of(context).push(
                          MaterialPageRoute<void>(
                            builder: (BuildContext context) => Scaffold(
                                body: SmileIDBiometricKYC(
                                  country: 'NG',
                                  idType: id['code'],
                                  idNumber: bvnNumber,
                                  userId: auth.user?.id,
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
                                countryCode: widget.country!.countryCode.toString(),
                                documentType: id['code'],
                                userId: auth.user?.id,
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
                                countryCode: widget.country!.countryCode.toString(),
                                documentType: id['code'],
                                userId: auth.user?.id,
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
                  padding: const EdgeInsets.only(left: TSizes.defaultSpace / 1.5),
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
                      const SizedBox(width: TSizes.lg),
                      RichText(
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
                    ],
                  ),
                ),
              );
            }).toList(),
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
                Visibility(
                  visible: showErrorText,
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
                ),
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
      focusNode: bvnFocusNode,
      textAlign: TextAlign.center,
      validator: TValidator.numValidator,
      inputFormatters: [
      ],
      style: Theme.of(context).textTheme.titleLarge,
      onChanged: (val) {
        setState(() {
          bvnNumber = val;
        });
      },
      onSaved: (val) {
        setState(() {
          bvnNumber = val!;
        });
      },
      decoration: const InputDecoration(
        contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
        border: OutlineInputBorder(),
        hintText: 'Enter your ID number',
      ),
    );
  }
}

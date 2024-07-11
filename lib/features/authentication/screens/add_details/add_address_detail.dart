import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:provider/provider.dart';
import 'package:pouch/data/provider/auth_provider.dart';
import 'package:pouch/data/provider/offer_provider.dart';
import 'package:pouch/data/provider/subscription_provider.dart';
import 'package:pouch/data/provider/transaction_provider.dart';
import 'package:pouch/data/provider/wallet_provider.dart';
import 'package:pouch/utils/constants/sizes.dart';
import 'package:pouch/utils/helpers/helper_functions.dart';
import '../../../../common/widgets/buttons/elevated_button.dart';
import '../../../../data/modules/app_navigator.dart';
import '../../../../utils/validators/validation.dart';
import '../../apis/api.dart';

class AddAddressDetail extends StatefulWidget {
  final String email;
  final String password;
  final bool rememberMe;

  const AddAddressDetail({super.key, required this.email, required this.password, required this.rememberMe});

  @override
  State<AddAddressDetail> createState() => _AddAddressDetailState();
}

class _AddAddressDetailState extends State<AddAddressDetail> {

  var authProvider = Provider.of<AuthProvider>(
      AppNavigator.instance.navigatorKey.currentContext as BuildContext,
      listen: false);

  var walletProvider = Provider.of<WalletProvider>(
      AppNavigator.instance.navigatorKey.currentContext as BuildContext,
      listen: false);

  var transactionProvider = Provider.of<TransactionProvider>(
      AppNavigator.instance.navigatorKey.currentContext as BuildContext,
      listen: false);

  var offerProvider = Provider.of<OfferProvider>(
      AppNavigator.instance.navigatorKey.currentContext as BuildContext,
      listen: false);

  var subscriptionProvider = Provider.of<SubscriptionProvider>(
      AppNavigator.instance.navigatorKey.currentContext as BuildContext,
      listen: false);

  final formKey = GlobalKey<FormState>();
  String postCode = '';
  String address = '';

  // String _data = '';
  // Future<void> getResponse(String POSTCODE) async {
  //   final dio = Dio();
  //   final url = 'https://maps.googleapis.com/maps/api/geocode/json?address={234001}&key=AIzaSyBECoO_1MmoGnwVN5zXmjIbaFCIME11fRQ';
  //   try {
  //     final response = await dio.get(url);
  //     if (response.statusCode == 200) {
  //       final data = response.data;
  //       // setState(() {
  //       //   _data = data;
  //       // });
  //       print(data);
  //     } else {
  //       print(response.statusCode);
  //     }
  //   } catch (error) {
  //     print((error.toString()));
  //     throw error;
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: THelperFunctions.screenHeight(),
        padding: EdgeInsets.symmetric(horizontal: TSizes.defaultSpace, vertical: 20),
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            RichText(
                text: TextSpan(
                    style: Theme.of(context).textTheme.bodyLarge,
                    children: <TextSpan> [
                      TextSpan(
                          text: 'Address Details',
                          style: TextStyle(
                              fontWeight: TSizes.fontWeightLg
                          )
                      )
                    ]
                )
            ),
            SizedBox(height: 30,),
            RichText(
                text: TextSpan(
                    style: Theme.of(context).textTheme.labelMedium,
                    children: const <TextSpan> [
                      TextSpan(
                          text: 'Enter your address details',
                      )
                    ]
                )
            ),
            SizedBox(height: 20,),
            Form(
              key: formKey,
              child: Column(
                children: [

                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Post Code', style: Theme.of(context).textTheme.labelMedium,),
                      SizedBox(
                        child: TextFormField(
                          style: Theme.of(context).textTheme.labelMedium,
                          onChanged: (val) => postCode = val,
                          keyboardType: TextInputType.number,
                          validator: TValidator.emptyFieldValidator,
                          onSaved: (val) {
                            setState(() {
                              postCode = val as String;
                            });
                          },
                          decoration: const InputDecoration(
                          ),
                        ),
                      )
                    ],
                  ),
                  SizedBox(height: 20,),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Address', style: Theme.of(context).textTheme.labelMedium,),
                      SizedBox(
                        child: TextFormField(
                          style: Theme.of(context).textTheme.labelMedium,
                          onChanged: (val) => address = val,
                          validator: TValidator.emptyFieldValidator,
                          onSaved: (val) {
                            setState(() {
                              address = val as String;
                            });
                          },
                          decoration: const InputDecoration(
                          ),
                        ),
                      )
                    ],
                  ),
                  SizedBox(height: TSizes.defaultSpace * 3),
                  TElevatedButton(
                      onTap: (){
                        if (formKey.currentState!.validate()) {
                          formKey.currentState!.save();
                          AuthService.instance.updateAddress(
                              postCode: postCode,
                              address: address,
                              email: widget.email,
                              password: widget.password,
                              authProvider: authProvider,
                              walletProvider: walletProvider,
                              transactionProvider: transactionProvider,
                              offerProvider: offerProvider,
                              subscriptionProvider: subscriptionProvider,
                              rememberMe: widget.rememberMe,
                              handleEmailNotVerified: (){}
                          );
                        }
                        // getResponse('230011');


                      },
                      buttonText: 'Submit'
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

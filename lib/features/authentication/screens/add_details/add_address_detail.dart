import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:pouch/data/provider/notificaton_provider.dart';
import 'package:provider/provider.dart';
import 'package:pouch/common/widgets/buttons/elevated_button.dart';
import 'package:pouch/data/modules/app_navigator.dart';
import 'package:pouch/data/provider/auth_provider.dart';
import 'package:pouch/data/provider/offer_provider.dart';
import 'package:pouch/data/provider/subscription_provider.dart';
import 'package:pouch/data/provider/transaction_provider.dart';
import 'package:pouch/data/provider/wallet_provider.dart';
import 'package:pouch/features/authentication/apis/api.dart';
import 'package:pouch/utils/constants/sizes.dart';
import 'package:pouch/utils/helpers/helper_functions.dart';
import 'package:pouch/utils/validators/validation.dart';

class AddAddressDetail extends StatefulWidget {
  final String email;
  final String password;
  final bool rememberMe;

  const AddAddressDetail({
    Key? key,
    required this.email,
    required this.password,
    required this.rememberMe,
  }) : super(key: key);

  @override
  _AddAddressDetailState createState() => _AddAddressDetailState();
}

class _AddAddressDetailState extends State<AddAddressDetail> {
  late final AuthProvider authProvider;
  late final WalletProvider walletProvider;
  late final TransactionProvider transactionProvider;
  late final OfferProvider offerProvider;
  late final SubscriptionProvider subscriptionProvider;
  late final NotificationProvider notificationProvider;

  final formKey = GlobalKey<FormState>();
  String postCode = '';
  String address = '';
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    final context = AppNavigator.instance.navigatorKey.currentContext!;
    authProvider = Provider.of<AuthProvider>(context, listen: false);
    walletProvider = Provider.of<WalletProvider>(context, listen: false);
    transactionProvider = Provider.of<TransactionProvider>(context, listen: false);
    offerProvider = Provider.of<OfferProvider>(context, listen: false);
    subscriptionProvider = Provider.of<SubscriptionProvider>(context, listen: false);
    notificationProvider = Provider.of<NotificationProvider>(context, listen: false);
  }

  Future<void> fetchAddressFromPostCode(String postCode) async {
    setState(() => isLoading = true);
    try {
      final apiKey = 'AIzaSyBECoO_1MmoGnwVN5zXmjIbaFCIME11fRQ'; // Replace with your Google Maps API key
      final url = 'https://maps.googleapis.com/maps/api/geocode/json?address=$postCode&key=$apiKey';
      final response = await Dio().get(url);

      if (response.statusCode == 200) {
        print('cjeclomh ${response.data}');
        final results = response.data['results'];
        if (results.isNotEmpty) {
          final formattedAddress = results[0]['formatted_address'];
          setState(() => address = formattedAddress);
        } else {
          setState(() => address = 'No address found');
        }
      } else {
        setState(() => address = 'Error: ${response.statusCode}');
      }
    } catch (error) {
      setState(() => address = 'Failed to fetch address');
    } finally {
      setState(() => isLoading = false);
    }
  }

  void _submitForm() {
    // if (formKey.currentState!.validate()) {
    //   formKey.currentState!.save();
      AuthService.instance.updateAddress(
        postCode: postCode,
        address: 'University Rd',
        email: widget.email,
        password: widget.password,
        authProvider: authProvider,
        walletProvider: walletProvider,
        transactionProvider: transactionProvider,
        notificationProvider: notificationProvider,
        offerProvider: offerProvider,
        subscriptionProvider: subscriptionProvider,
        rememberMe: widget.rememberMe,
        handleEmailNotVerified: () {},
      );
    // }
  }

  Widget _buildTextField({
    required String label,
    required String initialValue,
    required FormFieldSetter<String> onSaved,
    required FormFieldValidator<String> validator,
    Widget? suffix,
    TextInputType keyboardType = TextInputType.text,
    bool obscureText = false,
    bool isReadOnly = false,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: Theme.of(context).textTheme.labelMedium),
        SizedBox(
          child: TextFormField(
            initialValue: initialValue,
            style: Theme.of(context).textTheme.labelMedium,
            keyboardType: keyboardType,
            obscureText: obscureText,
            readOnly: isReadOnly,
            onChanged: onSaved,
            validator: validator,
            decoration: InputDecoration(
              suffixIcon: suffix
            ),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          padding: EdgeInsets.only(left: TSizes.defaultSpace, right: TSizes.defaultSpace, top: 30, bottom: MediaQuery.of(context).viewInsets.bottom),
          child: Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                RichText(
                  text: TextSpan(
                    text: 'Address Details',
                    style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                      fontWeight: TSizes.fontWeightLg,
                    ),
                  ),
                ),
                const SizedBox(height: 30),
                RichText(
                  text: TextSpan(
                    text: 'Enter your address details',
                    style: Theme.of(context).textTheme.labelMedium,
                  ),
                ),
                const SizedBox(height: 20),
                _buildTextField(
                  label: 'Post Code',
                  initialValue: postCode,
                  suffix: IconButton(
                    icon: Icon(Icons.search),
                    onPressed: () {
                      if (postCode.isNotEmpty) {
                        fetchAddressFromPostCode(postCode);
                      }
                    },
                  ),
                  onSaved: (val) {
                    postCode = val!;
                  },
                  validator: TValidator.emptyFieldValidator,
                  keyboardType: TextInputType.number,
                ),
                const SizedBox(height: 20),
                _buildTextField(
                  label: 'Address',
                  initialValue: address,
                  onSaved: (val) => address = val!,
                  validator: TValidator.emptyFieldValidator,
                  isReadOnly: true,
                ),
                const SizedBox(height: TSizes.defaultSpace * 3),
                if (isLoading) CircularProgressIndicator(),
                if (!isLoading)
                  TElevatedButton(
                    onTap: _submitForm,
                    buttonText: 'Submit',
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

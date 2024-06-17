import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:provider/provider.dart';
import 'package:swappr/common/widgets/buttons/elevated_button.dart';
import 'package:swappr/common/widgets/otp/otp_form.dart';
import 'package:swappr/data/modules/app_navigator.dart';
import 'package:swappr/data/provider/offer_provider.dart';
import 'package:swappr/data/provider/subscription_provider.dart';
import 'package:swappr/data/provider/transaction_provider.dart';
import 'package:swappr/features/authentication/apis/api.dart';
import 'package:swappr/features/authentication/routes/names.dart';
import 'package:swappr/features/authentication/screens/email_verify/email_verify.dart';
import 'package:swappr/utils/constants/colors.dart';
import 'package:swappr/utils/validators/validation.dart';
import '../../../../../data/provider/auth_provider.dart';
import '../../../../../data/provider/wallet_provider.dart';
import '../../../../../utils/constants/sizes.dart';
import '../../sign_up/sign_up.dart';

class LoginForm extends StatefulWidget {
  final String? email;
  final String? password;
  final bool rememberMe;

  const LoginForm({
    super.key,
    required this.email,
    required this.password,
    required this.rememberMe,
  });

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final formKey = GlobalKey<FormState>();
  late String? _email = widget.email;
  late String? _password = widget.password;

  late bool _rememberMe = widget.rememberMe;
  bool _obscurePasswordText = true;

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

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
        child: Column(
          children: [
            /// Email
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Email', style: Theme.of(context).textTheme.labelMedium,),
                SizedBox(
                  child: TextFormField(
                    style: Theme.of(context).textTheme.labelMedium,
                    onChanged: (val) => _email = val,
                    validator: TValidator.validateEmail,
                    onSaved: (email) {
                      setState(() {
                        _email = email as String;
                      });
                    },
                    decoration: const InputDecoration(
                    ),
                  ),
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
                  child: TextFormField(
                    style: Theme.of(context).textTheme.labelMedium,
                    validator: TValidator.validateLoginPassword,
                    onChanged: (pass) => _password = pass,
                    onSaved: (pass) {
                      setState(() {
                        _password = pass as String;
                      });
                    },
                    obscureText: _obscurePasswordText,
                    decoration: InputDecoration(
                      suffixIcon: IconButton(
                          onPressed: () {
                            setState(() {
                              _obscurePasswordText = !_obscurePasswordText;
                            });
                          },
                          icon: Icon(_obscurePasswordText ? Iconsax.eye : Iconsax.eye_slash)
                      ),
                    ),
                  ),
                )
              ],
            ),
            const SizedBox(height: TSizes.xs),

            // Forgot password
            Align(
              alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: (){
                    AppNavigator.instance.navigateToHandler(
                      AUTH_FORGOT_PASSWORD_SCREEN_ROUTE
                    );
                    // Get.to(() => const ForgotPasswordScreen());
                    },
                  child: RichText(
                      text: TextSpan(
                          style: Theme.of(context).textTheme.labelMedium,
                          children: const <TextSpan> [
                            TextSpan(
                                text: 'Forgot password?',
                            )
                          ]
                      )
                  ),
                )
            ),
            const SizedBox(height: TSizes.spaceBtwItems),

            // TElevatedButton(onTap: () => Get.to(() => const NavigationMenu()), buttonText: 'Sign In')
            TElevatedButton(
                onTap: () {
                  if (formKey.currentState!.validate()) {
                    formKey.currentState!.save();
                    AuthService.instance.login(
                        email: _email as String,
                        password: _password as String,
                        authProvider: authProvider,
                        walletProvider: walletProvider,
                        transactionProvider: transactionProvider,
                        offerProvider: offerProvider,
                        subscriptionProvider: subscriptionProvider,
                        rememberMe: _rememberMe,
                        handleEmailNotVerified: () {
                          Get.to(EmailVerificationScreen(
                            email: _email as String,
                            sendEmailOtpOnBuild: true,
                            onSuccess: () {
                              AuthService.instance.login(
                                  email: _email as String,
                                  password: _password as String,
                                  authProvider: authProvider,
                                  walletProvider: walletProvider,
                                  transactionProvider: transactionProvider,
                                  offerProvider: offerProvider,
                                  subscriptionProvider: subscriptionProvider,
                                  rememberMe: _rememberMe,
                                  handleEmailNotVerified: (){}
                              );
                            },
                          )
                          );
                        }
                    );
                  }
                  // Get.to(() => const HomeScreen());
                  },
                buttonText: 'Sign In'),
            const SizedBox(height: TSizes.md),
            Center(
              child: TextButton(
                  onPressed: (){Get.to(() => const CreateAccountScreen());},
                  child: Text('No account yet? Sign Up', style: Theme.of(context).textTheme.labelMedium,)
              ),
            ),
          ],
        ),
    );
  }
}
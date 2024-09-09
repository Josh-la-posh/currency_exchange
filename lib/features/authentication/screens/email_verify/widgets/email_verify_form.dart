import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:pouch/features/authentication/apis/api.dart';
import 'package:pouch/utils/constants/image_strings.dart';
import 'package:pouch/utils/helpers/helper_functions.dart';
import 'package:pouch/utils/validators/validation.dart';
import 'package:pouch/common/widgets/buttons/elevated_button.dart';
import 'package:pouch/data/modules/app_navigator.dart';
import 'package:pouch/data/provider/auth_provider.dart';
import 'package:pouch/data/provider/offer_provider.dart';
import 'package:pouch/data/provider/subscription_provider.dart';
import 'package:pouch/data/provider/transaction_provider.dart';
import 'package:pouch/data/provider/wallet_provider.dart';
import 'package:pouch/utils/constants/sizes.dart';
import 'package:pouch/utils/otp/otp.dart';

class EmailVerificationForm extends StatefulWidget {
  final bool sendEmailOtpOnBuild;
  final String email;
  final String password;
  final VoidCallback? onSuccess;

  const EmailVerificationForm({
    Key? key,
    this.sendEmailOtpOnBuild = false,
    required this.email,
    required this.password,
    this.onSuccess,
  }) : super(key: key);

  @override
  _EmailVerificationFormState createState() => _EmailVerificationFormState();
}

class _EmailVerificationFormState extends State<EmailVerificationForm> {
  final formKey = GlobalKey<FormState>();
  final List<TextEditingController> _otpControllers = List.generate(6, (index) => TextEditingController());
  final List<FocusNode> _focusNodes = List.generate(6, (index) => FocusNode());
  String _otpCode = '';
  bool showEmailVerifiedSuccess = false;
  late OtpTimer _otpTimer;
  String _formattedTime = '0';
  bool canResendOtp = false;

  @override
  void initState() {
    super.initState();
    _otpTimer = OtpTimer(
      durationInSeconds: 120,
      onTimerFinish: () {
        setState(() {
          _formattedTime = '0';
          canResendOtp = true;
        });
      },
      getTime: (time) {
        setState(() {
          _formattedTime = time;
        });
      },
    );
    if (widget.sendEmailOtpOnBuild) {
      handleSendEmailVerificationOTP();
    } else {
      _otpTimer.startTimer();
    }

    _setupFocusListeners();
  }

  void _setupFocusListeners() {
    for (int i = 0; i < _focusNodes.length - 1; i++) {
      _otpControllers[i].addListener(() {
        if (_otpControllers[i].text.length == 1) {
          _focusNodes[i + 1].requestFocus();
        }
      });
    }
  }

  @override
  void dispose() {
    _otpTimer.stopTimer();
    _otpControllers.forEach((controller) => controller.dispose());
    _focusNodes.forEach((node) => node.dispose());
    super.dispose();
  }

  void handleSendEmailVerificationOTP() {
    AuthService.instance.emailVerificationOtp(
      email: widget.email,
      onSuccess: () {
        _otpTimer.startTimer();
        setState(() {
          canResendOtp = false;
        });
      },
      onFailure: () {
        setState(() {
          canResendOtp = true;
        });
      },
    );
  }

  void handleEmailVerificationSuccess() {
    setState(() {
      showEmailVerifiedSuccess = true;
    });
    widget.onSuccess?.call();
    Future.delayed(const Duration(seconds: 2), handleLogin);
  }

  void handleLogin() {
    if (showEmailVerifiedSuccess) {
      AuthService.instance.loginAfterEmailVerified(
        email: widget.email,
        password: widget.password,
        authProvider: Provider.of<AuthProvider>(context, listen: false),
        walletProvider: Provider.of<WalletProvider>(context, listen: false),
        transactionProvider: Provider.of<TransactionProvider>(context, listen: false),
        offerProvider: Provider.of<OfferProvider>(context, listen: false),
        subscriptionProvider: Provider.of<SubscriptionProvider>(context, listen: false),
        rememberMe: true,
        handleEmailNotVerified: () {},
      );
    }
  }

  void _onOtpChanged() {
    _otpCode = _otpControllers.map((controller) => controller.text).join();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: showEmailVerifiedSuccess
          ? _buildSuccessView(context)
          : _buildOtpForm(context),
    );
  }

  Widget _buildOtpForm(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        RichText(
          text: TextSpan(
            text: 'Enter the six digit pin sent to ',
            style: Theme.of(context).textTheme.labelMedium?.copyWith(
              fontSize: 20
            ),
            children: [
              TextSpan(
                text: widget.email,
                style: TextStyle(fontWeight: TSizes.fontWeightLg),
              ),
            ],
          ),
        ),
        const SizedBox(height: TSizes.defaultSpace * 1.6),
        _buildOtpInputField(),
        // const SizedBox(height: TSizes.lg),
        _buildConfirmButton(context),
        _buildResendOtpButton(),
      ],
    );
  }

  Widget _buildOtpInputField() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: List.generate(6, (index) {
        return _buildOtpBox(index);
      }),
    );
  }

  Widget _buildOtpBox(int index) {
    return SizedBox(
      width: 40,
      child: TextFormField(
        controller: _otpControllers[index],
        focusNode: _focusNodes[index],
        textAlign: TextAlign.center,
        style: const TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
        keyboardType: TextInputType.number,
        maxLength: 1,
        decoration: const InputDecoration(
          contentPadding: EdgeInsets.zero,
          counterText: '',
          border: OutlineInputBorder(),
        ),
        onChanged: (value) {
          _onOtpChanged();
          if (value.isEmpty && index > 0) {
            _focusNodes[index - 1].requestFocus();
          }
          formKey.currentState?.validate();
        },
        validator: (value) => value!.isEmpty ? 'Please enter a digit' : null,
      ),
    );
  }

  Widget _buildConfirmButton(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: TSizes.spaceBtwSections - 4),
      child: TElevatedButton(
        onTap: () {
          if (formKey.currentState!.validate()) {
            AuthService.instance.verifyEmailOtp(
              otpCode: _otpCode,
              onSuccess: handleEmailVerificationSuccess,
            );
          }
        },
        buttonText: 'Confirm',
      ),
    );
  }

  Widget _buildResendOtpButton() {
    return Center(
      child: TextButton(
        onPressed: canResendOtp ? handleSendEmailVerificationOTP : null,
        style: const ButtonStyle(
          padding: MaterialStatePropertyAll(
            EdgeInsets.fromLTRB(4, 0, 0, 0),
          ),
        ),
        child: Text(
          canResendOtp ? 'Resend OTP' : 'Resend OTP in ${_formattedTime}s',
          style: const TextStyle(fontSize: 13),
        ),
      ),
    );
  }

  Widget _buildSuccessView(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(height: THelperFunctions.screenHeight() * 0.1),
        Image.asset(TImages.success),
        const SizedBox(height: TSizes.spaceBtwElements),
        Text(
          'Your email has been verified successfully. You\'ll be redirected to the address page in 5 seconds.',
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.labelMedium,
        ),
        SizedBox(height: THelperFunctions.screenHeight() * 0.4),
        TElevatedButton(
          onTap: handleLogin,
          buttonText: 'Please, Log in',
        ),
      ],
    );
  }
}

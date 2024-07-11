import 'package:flutter/material.dart';
import 'package:pouch/features/authentication/screens/sign_up/widgets/sign_up_form.dart';
import 'package:pouch/utils/layouts/auth_layout.dart';

class CreateAccountScreen extends StatelessWidget {
  const CreateAccountScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AuthLayout(title: '', heading: 'Sign Up', child: SignUpForm());
  }
}

import 'package:flutter/material.dart';
import 'package:swappr/features/authentication/screens/login/widgets/login_form.dart';
import 'package:swappr/utils/layouts/auth_layout.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AuthLayout(heading: 'Log In' ,title: 'Welcome Back!', child: const LoginForm());
  }
}


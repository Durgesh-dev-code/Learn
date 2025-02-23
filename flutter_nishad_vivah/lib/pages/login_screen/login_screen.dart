import 'package:flutter/material.dart';
import 'package:flutter_nishad_vivah/pages/widgets/login_form.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      child: const Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // HeaderImage(),
          // StatusBar(),
          SizedBox(height: 55),
          LoginForm(),
        ],
      ),
    );
  }
}

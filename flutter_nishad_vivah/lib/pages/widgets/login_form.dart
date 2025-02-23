import 'package:flutter/material.dart';
import 'package:flutter_nishad_vivah/pages/utility.dart';

void fnAbc() {}

class LoginForm extends StatelessWidget {
  const LoginForm({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Form(
        child: Column(
          children: [
            kTextFormField("mobile no", TextInputType.phone, false),
            const SizedBox(height: 18),
            kTextFormField("password", TextInputType.text, true),
            const SizedBox(height: 18),
            kElevatedButtonWide("Login", fnAbc),
            const SizedBox(height: 18),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                kText('Forgot password'),
                kText('Sign Up'),
              ],
            ),
            const SizedBox(height: 18),
            Row(
              children: [
                kText('Privacy'),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

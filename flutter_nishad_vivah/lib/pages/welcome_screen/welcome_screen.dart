import 'package:flutter/material.dart';
import 'package:flutter_nishad_vivah/pages/login_screen/login_screen.dart';
import 'package:flutter_nishad_vivah/pages/welcome_screen/welcome_content.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          // color: Color.fromARGB(255, 120, 5, 236),
          gradient: LinearGradient(colors: [
            Color.fromARGB(255, 120, 5, 236),
            Color.fromARGB(255, 181, 121, 241)
          ], begin: Alignment.topRight, end: Alignment.bottomRight),
        ),
        constraints: const BoxConstraints(maxWidth: 480),
        child: const Stack(
          children: [
            // Image.network(
            //   'https://cdn.builder.io/api/v1/image/assets/TEMP/baa16b00241afeb8a136c8e9c208b1c6751dc89c383fdc5316919734843bebca?placeholderIfAbsent=true&apiKey=17258b79655b4befa7803e880fd29904',
            //   fit: BoxFit.cover,
            //   width: double.infinity,
            //   height: double.infinity,
            // ),
            Column(
              children: [
                Expanded(child: WelcomeContent()),
                // Expanded(child: LoginScreen())
              ],
            ),
          ],
        ),
      ),
    );
  }
}

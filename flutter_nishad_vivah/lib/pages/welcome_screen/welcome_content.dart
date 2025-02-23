import 'package:flutter/material.dart';
import 'package:flutter_nishad_vivah/pages/utility.dart';

class WelcomeContent extends StatelessWidget {
  const WelcomeContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          kText("Jai Nishad Raj",
              size: 24), // normal text with Size 16. use Text for customization
          const SizedBox(height: 25),
          kText(
              "'Nishad Yuvak-Yukti parichay sammelan. Ek choti si madad apne samaj ko bhaitar karne ke liye'"),
          // const Text(
          //   'Nishad Yuvak-Yukti parichay sammelan. Ek choti si madad apne samaj ko bhaitar karne ke liye',
          //   textAlign: TextAlign.center,
          //   style: TextStyle(
          //     fontSize: 18,
          //   ),
          // ),
          const SizedBox(height: 25),
          kElevatedButtonWide("Get Started", () {}),
          const SizedBox(height: 51),
        ],
      ),
    );
  }
}

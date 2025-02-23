import 'package:flutter/material.dart';

class StatusBar extends StatelessWidget {
  const StatusBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text(
            '20:35',
            style: TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.w700,
              fontFamily: 'Inter',
            ),
          ),
          Row(
            children: [
              Image.network(
                'https://cdn.builder.io/api/v1/image/assets/TEMP/cb2cd8d14604e25d91a8c303bc3eac9f7c5a287043fade169fc00e40d599d57b?placeholderIfAbsent=true&apiKey=17258b79655b4befa7803e880fd29904',
                width: 23,
                height: 20,
                fit: BoxFit.contain,
              ),
              const SizedBox(width: 7),
              Image.network(
                'https://cdn.builder.io/api/v1/image/assets/TEMP/f5466cca72ec58631b4ba207fb8cfee5104151a4803aef88c231aa56fe43f6fb?placeholderIfAbsent=true&apiKey=17258b79655b4befa7803e880fd29904',
                width: 25,
                height: 17,
                fit: BoxFit.contain,
              ),
              const SizedBox(width: 7),
              Image.network(
                'https://cdn.builder.io/api/v1/image/assets/TEMP/54c353e8e030b91a8be3f5963e9e0a87dd403f20bd8a2a8c08cacc9b2299fe21?placeholderIfAbsent=true&apiKey=17258b79655b4befa7803e880fd29904',
                width: 26,
                height: 15,
                fit: BoxFit.contain,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

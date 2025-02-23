import 'package:flutter/material.dart';

class HeaderImage extends StatelessWidget {
  const HeaderImage({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(10),
          bottomRight: Radius.circular(147),
          topLeft: Radius.circular(90),
          topRight: Radius.circular(90),
        ),
      ),
      child: AspectRatio(
        aspectRatio: 1.318,
        child: Image.network(
          'https://cdn.builder.io/api/v1/image/assets/TEMP/7b76614a57826f578d487e2380eab32c51d3ee673dd2b7c171bef0a37d5c9ad0?placeholderIfAbsent=true&apiKey=17258b79655b4befa7803e880fd29904',
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}

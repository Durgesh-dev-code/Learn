import 'package:flutter/material.dart';
import 'package:flutter_app/Gradient_Container.dart';

void main() {
  const Color startGradient = Color.fromARGB(255, 122, 45, 255);
  const Color endGradient = Color.fromARGB(255, 165, 130, 227);
  final List<Color> colors = [startGradient, endGradient];
  runApp(
    MaterialApp(
      home: Scaffold(
        body: GradientContainer(
          colors: colors,
          //startGradient, endGradient
        ),
      ),
    ),
  );
}

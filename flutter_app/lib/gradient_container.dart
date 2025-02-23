import 'package:flutter/material.dart';
import 'package:flutter_app/dice_roller.dart';
// import 'package:flutter_app/style_text.dart';

const startAlignment = Alignment.topLeft;
const endAlignment = Alignment.bottomRight;

class GradientContainer extends StatelessWidget {
  // const GradientContainer(this.startGradient, this.endGradient, {super.key});
  const GradientContainer({super.key, required this.colors});

  // final Color startGradient;
  // final Color endGradient;
  final List<Color> colors;
  @override
  Widget build(context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
            colors: colors,
            // [
            //   startGradient, // Color.fromARGB(255, 122, 45, 255),
            //   endGradient, // Color.fromARGB(255, 165, 130, 227),
            // ],
            begin: startAlignment,
            end: endAlignment),
      ),
      child: const Center(
        //child: StyleText('Hello Durgesh Kewat'),
        child: DiceRoller(),
      ),
    );
  }
}

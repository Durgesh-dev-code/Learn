import 'dart:math';

import 'package:flutter/material.dart';

class DiceRoller extends StatefulWidget {
  const DiceRoller({super.key});
  @override
  State<DiceRoller> createState() {
    return _DiceRollerState();
  }
}

class _DiceRollerState extends State<DiceRoller> {
  var activeDiceImage = 'assets/images/dice-2.png';
  var currentDiceRoll = 2;
  final _random = Random();
  void rollDice() {
    setState(() {
      currentDiceRoll = _random.nextInt(6) + 1;
      // activeDiceImage = 'assets/images/dice-Random().nextInt(6) + 1;
      // activeDiceImage = 'assets/images/dice-4.png';
      //print('Changing the value....');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(mainAxisSize: MainAxisSize.min, children: [
      Image.asset(
        'assets/images/dice-$currentDiceRoll.png',
        width: 200,
      ),
      const SizedBox(height: 20), // Used for padding
      TextButton(
          style: TextButton.styleFrom(
              // padding: const EdgeInsets.only(top: 20), //Padding
              foregroundColor: Colors.white,
              textStyle: const TextStyle(
                fontSize: 28,
              )),
          onPressed: rollDice,
          child: const Text('Role Dice')
          //const StyleText('Role Dice'),
          )
    ]);
  }
}

// utility.dart

import 'package:flutter/material.dart';

// Custom Text Style
// TextStyle kTextStyle = const TextStyle(
//   fontSize: 16,
//   // fontWeight: FontWeight.bold,
//   color: Colors.white,
// );

// Function to create TextStyle with dynamic fontSize
TextStyle kTextStyle({
  double fontSize = 16, // Default fontSize
  Color color = Colors.white, // Default color
  FontWeight fontWeight = FontWeight.normal, // Default fontWeight
}) {
  return TextStyle(
    fontSize: fontSize,
    color: color,
    fontWeight: fontWeight,
  );
}

// Custom Elevated Button Style
ElevatedButton kElevatedButtonStyle = ElevatedButton.styleFrom(
  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
  shape: RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(8),
  ),
) as ElevatedButton;

// Custom Text Widget
Widget kText(String text, {double size = 16}) {
  return Text(
    text,
    style: kTextStyle(fontSize: size),
  );
}

// Custom Elevated Button Widget
Widget kElevatedButton(String text, VoidCallback onPressed) {
  return ElevatedButton(
    onPressed: onPressed,
    child: kText(text),
  );
}

// Custom Elevated Button Widget
Widget kElevatedButtonWide(String text, VoidCallback onPressed) {
  return ElevatedButton(
    onPressed: onPressed,
    style: ElevatedButton.styleFrom(
      // backgroundColor: const Color(0xFF4E6BF9),
      minimumSize: const Size.fromHeight(50),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
    ),
    child: kText(text),
  );
}

// Custom TextField Widget
Widget kTextField(
  String labelText,
  String hintText,
  TextInputType keyboardType,
  bool obscureText,
  TextEditingController controller,
) {
  return TextField(
    controller: controller,
    decoration: InputDecoration(
      labelText: labelText,
      hintText: hintText,
      border: const OutlineInputBorder(),
    ),
    keyboardType: keyboardType,
    obscureText: obscureText,
  );
}

// Custom TextFormField Widget
Widget kTextFormField(String text, TextInputType keyboardType, bool hidden) {
  return TextFormField(
    decoration: InputDecoration(
      filled: true,
      fillColor: Colors.black.withOpacity(0.2),
      hintText: text,
      hintStyle: kTextStyle(),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: BorderSide.none,
      ),
    ),
    keyboardType: keyboardType,
    obscureText: hidden,
  );
}

// Custom DropdownButton Widget
Widget kDropdownButton(
  String labelText,
  List<String> items,
  String? value,
  Function(String?) onChanged,
) {
  return DropdownButtonFormField(
    decoration: InputDecoration(
      labelText: labelText,
      border: const OutlineInputBorder(),
    ),
    items: items.map((item) {
      return DropdownMenuItem(
        value: item,
        child: kText(item),
      );
    }).toList(),
    value: value,
    onChanged: onChanged,
  );
}

// Custom Checkbox Widget
Widget kCheckbox(
  String labelText,
  bool value,
  Function(bool?) onChanged,
) {
  return CheckboxListTile(
    title: kText(labelText),
    value: value,
    onChanged: onChanged,
  );
}

// Custom Switch Widget
Widget kSwitch(
  String labelText,
  bool value,
  Function(bool) onChanged,
) {
  return SwitchListTile(
    title: kText(labelText),
    value: value,
    onChanged: onChanged,
  );
}

// Custom Slider Widget
Widget kSlider(
  String labelText,
  double value,
  double min,
  double max,
  Function(double) onChanged,
) {
  return Slider(
    label: labelText,
    value: value,
    min: min,
    max: max,
    onChanged: onChanged,
  );
}

// Custom Date Picker Widget
Widget kDatePicker(
  String labelText,
  DateTime initialDate,
  BuildContext context,
  Function(DateTime) onChanged,
) {
  return ElevatedButton(
    onPressed: () async {
      final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: initialDate,
        firstDate: DateTime(2020),
        lastDate: DateTime(2025),
      );
      if (picked != null) {
        onChanged(picked);
      }
    },
    child: Text(labelText),
  );
}

// Custom Time Picker Widget
Widget kTimePicker(
  String labelText,
  TimeOfDay initialTime,
  BuildContext context,
  Function(TimeOfDay) onChanged,
) {
  return ElevatedButton(
    onPressed: () async {
      final TimeOfDay? picked = await showTimePicker(
        context: context,
        initialTime: initialTime,
      );
      if (picked != null) {
        onChanged(picked);
      }
    },
    child: kText(labelText),
  );
}

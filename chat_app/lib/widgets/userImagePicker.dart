import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class Userimagepicker extends StatefulWidget {
  const Userimagepicker({super.key, required this.onPickImage});
  final void Function(File pickedImage) onPickImage;
  @override
  State<Userimagepicker> createState() {
    // TODO: implement createState
    return _Userimagepicker();
  }
}

class _Userimagepicker extends State<Userimagepicker> {
  File? pickedImage;
  void _onPickedImage() async {
    final imagePicker = ImagePicker();
    final pickedFile = await imagePicker.pickImage(
      source: ImageSource.gallery,
      maxWidth: 50,
    );

    if (pickedFile == null) {
      return;
    }
    setState(() {
      pickedImage = File(pickedFile.path);
    });
    widget.onPickImage(pickedImage!);
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Column(
      children: [
        CircleAvatar(
          radius: 50,
          backgroundColor: Colors.grey,
          foregroundImage: pickedImage != null ? FileImage(pickedImage!) : null,
        ),
        TextButton.icon(
          onPressed: _onPickedImage,
          icon: const Icon(Icons.photo),
          label: Text(
            'Add Image',
            style: TextStyle(color: Theme.of(context).colorScheme.primary),
          ),
        )
      ],
    );
  }
}

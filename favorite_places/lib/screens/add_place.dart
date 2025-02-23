import 'dart:io';

// import 'package:favorite_places/main.dart';
import 'package:favorite_places/model/place.dart';
import 'package:favorite_places/provider/places_provider.dart';
import 'package:favorite_places/widget/image_input.dart';
import 'package:favorite_places/widget/location_input.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:path_provider/path_provider.dart' as syspaths;
import 'package:path/path.dart' as path;

class AddPlace extends ConsumerStatefulWidget {
  const AddPlace({super.key});

  @override
  ConsumerState<AddPlace> createState() {
    return _AddPlaceState();
  }
}

class _AddPlaceState extends ConsumerState<AddPlace> {
  final _formState = GlobalKey<FormState>();
  bool _isSaving = false;
  File? selectedImage;
  late String placeTitle;
  PlaceLocation? selectedLocation;

  void _onSelectedImage(File file) {
    selectedImage = file;
  }

  void onSelectedLocation(PlaceLocation placeLocation) {
    selectedLocation = placeLocation;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add New Place'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formState,
          child: Column(
            children: [
              TextFormField(
                cursorColor: Colors.white,
                // textInputAction: TextInputAction[colorScheme.brightness.],
                decoration: const InputDecoration(
                  label: Text(
                    'Place Name',
                    // style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    //     color: Theme.of(context).colorScheme.onBackground),
                  ),
                ),
                validator: (value) {
                  if (value == null ||
                      value.isEmpty ||
                      // value.trim().length < 1 ||
                      value.trim().length > 50) {
                    return 'Enter Valid Name between 2 and 50 characters';
                  }
                  return null;
                },
                onSaved: (newValue) {
                  _isSaving = true;
                  placeTitle = newValue!;
                },
              ),
              const SizedBox(
                height: 15,
              ),
              ImageInput(
                onPickImage: _onSelectedImage,
              ),
              const SizedBox(
                height: 15,
              ),
              LocationInput(
                onPickedLocation: onSelectedLocation,
              ),
              const SizedBox(
                height: 15,
              ),
              ElevatedButton.icon(
                icon: const Icon(Icons.add),
                label: _isSaving
                    ? const Text('...Adding')
                    : const Text('Add Place'),
                onPressed: _isSaving
                    ? null
                    : () {
                        AddPlace();
                      },
                // child: _isSaving
                //     ? const Text('...Adding')
                //     : const Text('Add Place'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void AddPlace() async {
    if (selectedImage == null ||
        selectedLocation == null ||
        selectedImage == null) return;

    if (!_formState.currentState!.validate()) return;
    _formState.currentState!.save();

    final sysDirPath = await syspaths.getApplicationDocumentsDirectory();
    final filename = path.basename(selectedImage!.path);
    final copiedImage =
        await selectedImage!.copy('${sysDirPath.path}/$filename');

    ref.read(places_Provider.notifier).AddPlace(
          Place(
              title: placeTitle,
              image: copiedImage,
              location: selectedLocation!),
        );
    Navigator.of(context).pop();
  }
}

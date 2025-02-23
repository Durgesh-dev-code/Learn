import 'dart:convert';

import 'package:favorite_places/model/place.dart';
import 'package:favorite_places/screens/maps.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:http/http.dart' as http;

class LocationInput extends StatefulWidget {
  const LocationInput({super.key, required this.onPickedLocation});
  final void Function(PlaceLocation placeLocation) onPickedLocation;

  @override
  State<LocationInput> createState() {
    return _LocationInputState();
  }
}

class _LocationInputState extends State<LocationInput> {
  Location location = Location();
  bool isGettingLocation = false;
  PlaceLocation? pickedLocation;

  String get locationImage {
    if (pickedLocation == null) {
      return '';
    }
    final lat = pickedLocation!.latitude;
    final lng = pickedLocation!.longitude;
    return 'https://maps.googleapis.com/maps/api/staticmap?center$lat,$lng=&zoom=16&size=600x300&maptype=roadmap&markers=color:red%7Clabel:A%7C$lat,$lng&key=AIzaSyB2uNu0B5io-oFNnHzhdxA649Ijpzw6cOA';
  }

  void getCurrentLocation() async {
    bool serviceEnabled;
    PermissionStatus permissionGranted;
    LocationData locationData;

    serviceEnabled = await location.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await location.requestService();
      if (!serviceEnabled) {
        return;
      }
    }
    permissionGranted = await location.hasPermission();
    if (permissionGranted == PermissionStatus.denied) {
      permissionGranted = await location.requestPermission();
      if (permissionGranted != PermissionStatus.granted) {
        return;
      }
    }
    setState(() {
      isGettingLocation = true;
    });
    locationData = await location.getLocation();

    if (locationData == null) {
      return;
    }

    final lat = locationData.latitude;
    final lng = locationData.longitude;

    savePlace(lat!, lng!);
  }

  void savePlace(double latitude, double longitude) async {
    final lat = latitude;
    final lng = longitude;

    final url = Uri.parse(
        'https://maps.googleapis.com/maps/api/geocode/json?latlng=$lat,$lng&key=AIzaSyB2uNu0B5io-oFNnHzhdxA649Ijpzw6cOA');
    final response = await http.get(url);
    final responseData = json.decode(response.body);
    print(responseData);
    final address = responseData['results'][0]['formatted_address'];

    setState(() {
      pickedLocation = PlaceLocation(
        latitude: lat,
        longitude: lng,
        address: address,
      );

      isGettingLocation = false;
      widget.onPickedLocation(pickedLocation!);
    });
  }

  @override
  Widget build(BuildContext context) {
    Widget previewContent = Text(
      'No location chosen',
      style: Theme.of(context)
          .textTheme
          .bodyMedium!
          .copyWith(color: Theme.of(context).colorScheme.onPrimaryContainer),
    );

    if (locationImage.isNotEmpty) {
      previewContent = Image.network(
        locationImage,
        fit: BoxFit.cover,
        width: double.infinity,
        height: double.infinity,
      );
    }

    if (isGettingLocation) {
      previewContent = const CircularProgressIndicator();
    }
    return Column(
      children: [
        Container(
          height: 170,
          width: double.infinity,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            border: Border.all(width: 1),
            color: Theme.of(context).colorScheme.primary.withOpacity(0.2),
          ),
          child: previewContent,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            TextButton.icon(
              icon: const Icon(Icons.location_on),
              onPressed: getCurrentLocation,
              label: const Text('Get Location'),
            ),
            // const SizedBox(
            //   width: 20,
            // ),
            TextButton.icon(
              icon: const Icon(Icons.map),
              onPressed: onSelectMap,
              label: const Text('Select Location from Map'),
            ),
          ],
        ),
      ],
    );
  }

  void onSelectMap() async {
    final pickedLocation = await Navigator.of(context).push<LatLng>(
      MaterialPageRoute(
        builder: (ctx) => MapScreen(),
      ),
    );

    if (pickedLocation == null) {
      return;
    }

    savePlace(
      pickedLocation.latitude,
      pickedLocation.longitude,
    );
  }
}

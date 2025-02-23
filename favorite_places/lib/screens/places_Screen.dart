// import 'package:favorite_places/data/dummy_data.dart';
// import 'package:favorite_places/model/place.dart';
import 'package:favorite_places/model/place.dart';
import 'package:favorite_places/provider/places_provider.dart';
import 'package:favorite_places/widget/places_List.dart';
// import 'package:favorite_places/provider/places_provider.dart';
import 'package:favorite_places/screens/add_place.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PlacesScreen extends ConsumerStatefulWidget {
  const PlacesScreen({super.key});

  @override
  ConsumerState<PlacesScreen> createState() => _PlacesScreenState();
}

class _PlacesScreenState extends ConsumerState<PlacesScreen> {
  late Future<void> placesFuture;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    placesFuture = ref.read(places_Provider.notifier).loadPlaces();
  }

  @override
  Widget build(BuildContext context) {
    final List<Place> availablePlaces = ref.watch(places_list_provider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Places'),
        actions: [
          IconButton(
              onPressed: () {
                routeAddPlace(context);
              },
              icon: const Icon(Icons.add))
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(8.0),
        child: FutureBuilder(
          future: placesFuture,
          builder: (context, snapshot) =>
              snapshot.connectionState == ConnectionState.waiting
                  ? const Center(
                      child: CircularProgressIndicator(),
                    )
                  : placesList(
                      userPlaces: availablePlaces,
                    ),
        ),
      ),
    );
  }

  void routeAddPlace(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (builder) => const AddPlace(),
      ),
    );
  }
}

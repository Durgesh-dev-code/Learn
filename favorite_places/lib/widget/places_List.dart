import 'package:favorite_places/model/place.dart';
import 'package:favorite_places/provider/places_provider.dart';
import 'package:favorite_places/screens/place_detail.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class placesList extends ConsumerStatefulWidget {
  const placesList({
    super.key,
    required this.userPlaces,
  });
  final List<Place> userPlaces;
  @override
  ConsumerState<placesList> createState() => _placesListState();
}

class _placesListState extends ConsumerState<placesList> {
  @override
  Widget build(BuildContext context) {
    final availablePlaces = widget.userPlaces;
    // final List<dynamic> availablePlaces = ref.watch(places_list_provider);
    // final List<Place> availablePlaces = ref.watch(places_list_provider);

    if (availablePlaces.isEmpty) {
      return Center(
        child: Text(
          'No Places available',
          style: Theme.of(context)
              .textTheme
              .titleMedium!
              .copyWith(color: Theme.of(context).colorScheme.onBackground),
        ),
      );
    }
    return ListView.builder(
        itemCount: availablePlaces.length,
        itemBuilder: (context, index) {
          return ListTile(
            leading: CircleAvatar(
              radius: 26,
              backgroundImage: FileImage(availablePlaces[index].image),
            ),
            title: Text(
              availablePlaces[index].title,
              style: Theme.of(context)
                  .textTheme
                  .titleMedium!
                  .copyWith(color: Theme.of(context).colorScheme.onBackground),
            ),
            subtitle: Text(availablePlaces[index].location.address),
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                    builder: (ctx) =>
                        PlaceDetailScreen(place: availablePlaces[index])),
              );
            },
            //trailing: Text(availablePlaces[index].name),
          );
        });
  }
}

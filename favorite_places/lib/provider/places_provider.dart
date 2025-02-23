import 'dart:io';

import 'package:favorite_places/model/place.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
// import '../data/dummy_data.dart';
import 'package:sqflite/sqflite.dart' as sql;
import 'package:sqflite/sqlite_api.dart';
import 'package:path/path.dart' as path;

Future<Database> getDatabase() async {
  final dbPath = await sql.getDatabasesPath();
  final db = await sql.openDatabase(
    path.join(dbPath, 'places.db'),
    onCreate: (db, version) async {
      return await db.execute(
        'CREATE TABLE user_places(id TEXT PRIMARY KEY,title TEXT,image TEXT,lat REAL,lng REAL,address TEXT)',
      );
    },
    version: 1,
  );
  return db;
}

class places_Notifier extends StateNotifier<List<Place>> {
  places_Notifier() : super([]);

  Future<void> loadPlaces() async {
    Database db = await getDatabase();
    final data = await db.rawQuery('Select * from user_places');
    final places = data
        .map(
          (row) => Place(
            id: row['id'] as String,
            title: row['title'] as String,
            image: File(row['image'] as String),
            location: PlaceLocation(
                latitude: row['lat'] as double,
                longitude: row['lng'] as double,
                address: row['address'] as String),
          ),
        )
        .toList();

    state = places;
    print('places');
    print(places);
  }

  void AddPlace(Place place) async {
    Database db = await getDatabase();

    db.insert('user_places', {
      'id': place.id,
      'title': place.title,
      'image': place.image.path,
      'lat': place.location.latitude,
      'lng': place.location.longitude,
      'address': place.location.address,
    });

    state = [place, ...state]; // add the new place to the beginning of the list
    print(state);
  }
}

final places_Provider = StateNotifierProvider<places_Notifier, List<Place>>(
  (ref) => places_Notifier(),
);

final places_list_provider = Provider((ref) {
  final data = ref.watch(places_Provider);
  return data.toList();
});

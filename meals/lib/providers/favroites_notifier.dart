import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:meals/models/meal.dart';

class FavroitesMealsNotifier extends StateNotifier<List<Meal>> {
  FavroitesMealsNotifier() : super([]);

  bool toggelFavroitesMealStatus(Meal meal) {
    final isFavroiteMeal = state.contains(meal);

    if (isFavroiteMeal) {
      state = state.where((element) => element.id != meal.id).toList();
      return false;
    } else {
      // state.add(meal);
      state = [...state, meal];
      return true;
    }
  }
}

final favroitesMealsProvider =
    StateNotifierProvider<FavroitesMealsNotifier, List<Meal>>((ref) {
  return FavroitesMealsNotifier();
});

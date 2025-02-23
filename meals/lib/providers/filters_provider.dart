import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meals/providers/meals_provider.dart';

enum filter { glutenFree, lactoseFree, vegeterian, vegan }

const kIntitialFilters = {
  filter.glutenFree: false,
  filter.lactoseFree: false,
  filter.vegeterian: false,
  filter.vegan: false,
};

class FiltersNotifier extends StateNotifier<Map<filter, bool>> {
  FiltersNotifier() : super(kIntitialFilters);

  void setFilter(filter filter, bool value) {
    {
      state = {...state, filter: value};
    }
  }

  void setFilters(Map<filter, bool> filters) {
    {
      state = filters;
    }
  }
}

final filtersProvider =
    StateNotifierProvider<FiltersNotifier, Map<filter, bool>>((ref) {
  return FiltersNotifier();
});

final filtersMealsProvider = Provider((ref) {
  final meals = ref.watch(mealsProvider);
  final activeFilters = ref.watch(filtersProvider);

  return meals.where((meal) {
    if (activeFilters[filter.glutenFree]! && !meal.isGlutenFree) {
      return false;
    }
    if (activeFilters[filter.lactoseFree]! && !meal.isLactoseFree) {
      return false;
    }
    if (activeFilters[filter.vegeterian]! && !meal.isVegetarian) {
      return false;
    }
    if (activeFilters[filter.vegan]! && !meal.isVegan) {
      return false;
    }
    return true;
  }).toList();
});

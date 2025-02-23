import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:meals/models/meal.dart';
import 'package:meals/providers/favroites_notifier.dart';
import 'package:meals/providers/filters_provider.dart';
import 'package:meals/providers/meals_provider.dart';
import 'package:meals/screens/categories.dart';
import 'package:meals/screens/filters.dart';
import 'package:meals/screens/meals.dart';
import 'package:meals/widgets/main_drawer.dart';

const kIntitialFilters = {
  filter.glutenFree: false,
  filter.lactoseFree: false,
  filter.vegeterian: false,
  filter.vegan: false,
};

class TabsScreen extends ConsumerStatefulWidget {
  const TabsScreen({super.key});
  @override
  ConsumerState<TabsScreen> createState() {
    return _TabsScreenState();
  }
}

class _TabsScreenState extends ConsumerState<TabsScreen> {
  int _selectedIndexPage = 0;
  late Widget activeScreen = const CategoriesScreen(
    // onToggleFavroite: _toggleMealFavroitesStatus,
    availableMeals: [],
  );
  String activePageTitile = 'Category';
  // final List<Meal> favoritesMeals = [];

  // Map<filter, bool> _selectedFilters = kIntitialFilters;

  void showMessageInfo(String message) {
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
      ),
    );
  }

  // void _toggleMealFavroitesStatus(Meal meal) {
  //   final isExisting = favoritesMeals.contains(meal);
  //   if (isExisting) {
  //     setState(() {
  //       favoritesMeals.remove(meal);
  //     });
  //     showMessageInfo('Meal is no longer favroite');
  //   } else {
  //     setState(() {
  //       favoritesMeals.add(meal);
  //     });
  //     showMessageInfo('Meal is marked as favroite');
  //   }
  // }

  void _onSelectPage(int index) {
    setState(() {
      _selectedIndexPage = index;
    });
  }

  void _setScreen(String identifier) async {
    Navigator.of(context).pop();
    if (identifier == 'filters') {
      // var result =
      await Navigator.of(context).push<Map<filter, bool>>(
        MaterialPageRoute(
          builder: (ctx) => FiltersScreen(
              // availableFilters: _selectedFilters,
              ),
        ),
      );
      // setState(() {
      //   _selectedFilters = result ?? kIntitialFilters;
      // });
      // print(_selectedFilters);
    }
  }

  @override
  Widget build(BuildContext context) {
    final availableMeals = ref.watch(filtersMealsProvider);
    final activeFilters = ref.watch(filtersProvider);
    final favoritesMealsProvider = ref.watch(favroitesMealsProvider);

    // setState(() {});
    // final List<Meal> availableMeals =

    switch (_selectedIndexPage) {
      case 0:
        activeScreen = CategoriesScreen(
            // onToggleFavroite: _toggleMealFavroitesStatus,
            availableMeals: availableMeals);
        activePageTitile = 'Category';
      case 1:
        activeScreen = MealsScreen(
          // meals: favoritesMeals,
          meals: favoritesMealsProvider,
          // onToggleFavroite: _toggleMealFavroitesStatus,
        );
        activePageTitile = "Favorites";
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(activePageTitile),
      ),
      drawer: MainDrawer(setScreen: _setScreen),
      body: activeScreen,
      bottomNavigationBar: BottomNavigationBar(
          onTap: _onSelectPage,
          currentIndex: _selectedIndexPage,
          items: const [
            BottomNavigationBarItem(
                icon: Icon(Icons.set_meal), label: 'Categories'),
            BottomNavigationBarItem(icon: Icon(Icons.star), label: 'Favorites'),
          ]),
    );
  }
}

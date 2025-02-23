import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meals/providers/filters_provider.dart';
// import 'package:meals/screens/meals.dart';
// import 'package:meals/screens/taps.dart';
// import 'package:meals/widgets/main_drawer.dart';

// enum filter { glutenFree, lactoseFree, vegeterian, vegan }

class FiltersScreen extends ConsumerWidget {
  FiltersScreen({
    super.key,
    // required this.availableFilters
  });
  // final Map<filter, bool> availableFilters;
//   @override
//   ConsumerState<FiltersScreen> createState() => _FiltersScreenState();
// }

// class _FiltersScreenState extends ConsumerState<FiltersScreen> {
  // bool bglutenFreeFilterSet = false;
  // bool blactoseFreeFilterSet = false;
  // bool bvegeterianFilterSet = false;
  // bool bveganFilterSet = false;

  // FilterValue lactoseFreeFilterSet = FilterValue(false);
  // FilterValue glutenFreeFilterSet = FilterValue(false);
  // FilterValue vegeterianFilterSet = FilterValue(false);
  // FilterValue veganFilterSet = FilterValue(false);

  @override
  void initState() {
    // super.initState();
    // final activeFilters = ref.read(filtersProvider);
    // // print(activeFilters[filter.glutenFree]);
    // // print(activeFilters[filter.lactoseFree]);
    // // print(activeFilters[filter.vegeterian]);
    // // print(activeFilters[filter.vegan]);

    // glutenFreeFilterSet = FilterValue(activeFilters[filter.glutenFree]!);
    // lactoseFreeFilterSet = FilterValue(activeFilters[filter.lactoseFree]!);
    // vegeterianFilterSet = FilterValue(activeFilters[filter.vegeterian]!);
    // veganFilterSet = FilterValue(activeFilters[filter.vegan]!);
  }

  String identifier = 'meals';
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final activeFilters = ref.watch(filtersProvider);
    // glutenFreeFilterSet = FilterValue(activeFilters[filter.glutenFree]!);
    // lactoseFreeFilterSet = FilterValue(activeFilters[filter.lactoseFree]!);
    // vegeterianFilterSet = FilterValue(activeFilters[filter.vegeterian]!);
    // veganFilterSet = FilterValue(activeFilters[filter.vegan]!);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Filters'),
      ),
      // drawer: MainDrawer(
      //   setScreen: (identifier) {
      //     Navigator.of(context).pop();
      //     if (identifier == 'meals') {
      //       Navigator.of(context).pushReplacement(
      //         MaterialPageRoute(
      //           builder: (ctx) => const TabsScreen(),
      //         ),
      //       );
      //     }
      //   },
      // ),
      body:
          //--- Commented below PopScope as we update the filter state in the provider in onChanged event

          // PopScope(
          //   canPop: true, //-- to pop up the filter screen back - true
          //   onPopInvokedWithResult: (didPop, result) async {
          //     //if (didPop) return; --- commented due to the bug not executing below code and filters reset again

          //     // ref.read(filtersProvider.notifier).setFilters({
          //     //   filter.glutenFree: glutenFreeFilterSet.value,
          //     //   filter.lactoseFree: lactoseFreeFilterSet.value,
          //     //   filter.vegeterian: vegeterianFilterSet.value,
          //     //   filter.vegan: veganFilterSet.value,
          //     //   //--- pass the filters to the previous screen
          //     // });

          //     // Navigator.of(context).pop(
          //     //   {
          //     //     filter.glutenFree: glutenFreeFilterSet.value,
          //     //     filter.lactoseFree: lactoseFreeFilterSet.value,
          //     //     filter.vegeterian: vegeterianFilterSet.value,
          //     //     filter.vegan: veganFilterSet.value,
          //     //     //--- pass the filters to the previous screen
          //     //   },
          //     // );
          //   },
          //   child:
          Column(
        children: [
          filtersSwitch(
              context, 'Gluten-free', activeFilters[filter.glutenFree]!, ref),
          filtersSwitch(
              context, 'Lactose-free', activeFilters[filter.lactoseFree]!, ref),
          filtersSwitch(
              context, 'Vegetarian', activeFilters[filter.vegeterian]!, ref),
          filtersSwitch(context, 'Vegan', activeFilters[filter.vegan]!, ref),
        ],
      ),
      // ),
    );
  }

  SwitchListTile filtersSwitch(
      BuildContext context,
      String foodType,
      // FilterValue setFilter, WidgetRef ref) {
      bool setFilter,
      WidgetRef ref) {
    return SwitchListTile(
      value: setFilter, //setFilter.value,
      onChanged: (isChecked) {
        // setState(() {
        //   setFilter.value = isChecked;
        //   print(setFilter);
        //   print(setFilter.value);
        // });

        //--- set the filter value
        switch (foodType) {
          case 'Gluten-free':
            ref
                .read(filtersProvider.notifier)
                .setFilter(filter.glutenFree, isChecked);
            break;
          case 'Lactose-free':
            ref
                .read(filtersProvider.notifier)
                .setFilter(filter.lactoseFree, isChecked);
            break;
          case 'Vegetarian':
            ref
                .read(filtersProvider.notifier)
                .setFilter(filter.vegeterian, isChecked);
            break;
          case 'Vegan':
            ref
                .read(filtersProvider.notifier)
                .setFilter(filter.vegan, isChecked);
            break;
          // default:
        }
      },
      title: Text(
        foodType,
        style: Theme.of(context)
            .textTheme
            .titleLarge!
            .copyWith(color: Theme.of(context).colorScheme.onBackground),
      ),
      subtitle: Text(
        'Only include $foodType meals',
        style: Theme.of(context)
            .textTheme
            .labelMedium!
            .copyWith(color: Theme.of(context).colorScheme.onBackground),
      ),
      activeColor: Theme.of(context).colorScheme.tertiary,
      contentPadding: EdgeInsets.only(left: 34, right: 22),
    );
  }
}

class FilterValue {
  bool _value;

  FilterValue(this._value);

  bool get value => _value;

  set value(bool newValue) {
    _value = newValue;
  }
}

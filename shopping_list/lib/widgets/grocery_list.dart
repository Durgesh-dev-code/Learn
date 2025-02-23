import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shopping_list/data/categories.dart';
import 'package:shopping_list/models/category.dart';
import 'package:shopping_list/models/grocery_item.dart';
import 'package:shopping_list/widgets/new_item.dart';

import '../data/dummy_items.dart';
import 'package:http/http.dart' as http;

class GroceryList extends StatefulWidget {
  const GroceryList({Key? key}) : super(key: key);

  @override
  State<GroceryList> createState() => _GroceryListState();
}

class _GroceryListState extends State<GroceryList> {
  List<GroceryItem> groceryItems = [];
  bool _isLoading = true;
  String? _error;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _loadItems();
  }

  void _loadItems() async {
    //-- fetch items from backend
    final List<GroceryItem> loaditems = [];
    final url = Uri.https(
        'flutter-prep-405d9-default-rtdb.firebaseio.com', 'shopping-list.json');

    try {
      final response = await http.get(url);
      if (response.body == 'null') {
        setState(() {
          _isLoading = false;
        });
        return;
      }
      final Map<String, dynamic> items = jsonDecode(response.body);

      if (response.statusCode >= 400) {
        setState(() {
          _error = 'Failed to load items';
        });
      }
      for (var item in items.entries) {
        final categoryItem = categories.entries
            .firstWhere((cat) => cat.value.title == item.value["category"])
            .value;
        loaditems.add(GroceryItem(
            id: item.key,
            name: item.value['name'],
            quantity: item.value['quantity'],
            category: categoryItem));
      }
    } catch (ex) {
      setState(() {
        _error = 'Something went wrog !. Error : $ex';
      });
    }

    setState(() {
      groceryItems = loaditems;
      _isLoading = false;
    });
  }

  void _addItem() async {
    final item = await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (ctx) => const NewItem(),
      ),
    );
    if (item != null) {
      setState(() {
        groceryItems.add(item);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    Widget content = const Center(
      child: Text('No items yet. Continue Shopping !!'),
    );
    if (_isLoading) {
      content = const Center(
        child: CircularProgressIndicator(),
      );
    }

    if (groceryItems.isNotEmpty) {
      content = ListView.builder(
        itemCount: groceryItems.length,
        itemBuilder: (context, index) => Dismissible(
          key: ValueKey(groceryItems[index].id),
          background: Container(
            decoration: BoxDecoration(
              // borderRadius: BorderRadius.all(Radius.circular(10)),
              color: Theme.of(context).colorScheme.secondary.withOpacity(0.50),
            ),
            //color: Theme.of(context).colorScheme.secondary.withOpacity(0.50),
            margin: const EdgeInsets.symmetric(
              // horizontal: Theme.of(context)
              //     .colorScheme
              //     .secondaryContainer
              //     .withOpacity(0.1)
              //     .opacity,
              horizontal: 10,
              vertical: 0,
            ),
          ),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(
                Radius.circular(10),
              ),
              color: Theme.of(context).colorScheme.secondaryContainer,
            ),
            child: ListTile(
              title: Text(groceryItems[index].name),
              leading: Container(
                width: 24,
                height: 24,
                color: groceryItems[index].category.color,
              ),
              trailing: Text(
                groceryItems[index].quantity.toString(),
              ),
            ),
          ),
          onDismissed: (direction) {
            removeItem(index, context);
          },
        ),
      );
    }

    if (_error != null) {
      content = Center(
        child: Text(_error!),
      );
    }
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Groceries'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              _addItem();
            },
          ),
        ],
      ),
      body: content,
    );
  }

  void removeItem(int index, BuildContext context) async {
    String? snackBarMessage;
    bool _isRemoved = true;
    final currentGroceries = groceryItems[index];
    setState(() {
      groceryItems.removeAt(index);
    });

    final url = Uri.https('flutter-prep-405d9-default-rtdb.firebaseio.com',
        'shopping-list/${currentGroceries.id}.json');
    final response = await http.delete(url);

    print(currentGroceries.id);

    if (response.statusCode >= 400) {
      setState(() {
        snackBarMessage = 'Failed to remove item';
        groceryItems.insert(index, currentGroceries);
        _isRemoved = false;
        return;
      });
    } else {
      snackBarMessage = "Groceries removed!";
    }
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        duration: const Duration(seconds: 2),
        content: Text(snackBarMessage!),
        action: SnackBarAction(
            label: _isRemoved ? 'Undo' : 'Retry',
            onPressed: () {
              !_isRemoved
                  ? null
                  : setState(() async {
                      groceryItems.insert(index, currentGroceries);

                      //--- update the database when undo
                      // final url = Uri.https('flutter-prep-405d9-default-rtdb.firebaseio.com',
                      //     'shopping-list/${currentGroceries.id}.json');
                      // final response = await http.delete(url);
                    });
            }),
      ),
    );
  }
}

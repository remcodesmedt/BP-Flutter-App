import 'package:flutter/material.dart';
import 'package:project_flutter/database/DBHelper.dart';
import 'package:project_flutter/database/testdata/ShoppingListsMock.dart';

import '../../database/testdata/IngredientCategoryMock.dart';
import '../../database/testdata/IngredientMock.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String _displayText = "Homescreen";

  Future<void> fillDb() async {
    print("inserting mocks");
    await IngredientCategoryMock.insertMocks();
    await IngredientMock.insertMocks();
    await ShoppingListMock.insertMocks();
  }

  Future<void> logItems() async {
    print("logging mocks");
    await IngredientCategoryMock.logMocks();
    await IngredientMock.logMocks();
    await ShoppingListMock.logMocks();
  }

  Future<void> fabClicked() async {
    await fillDb();
    await logItems();
    setState(() {
      _displayText = "Done";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(_displayText ?? "Homescreen"),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: fabClicked,
        child: const Icon(Icons.add),
      ),
    );
  }
}

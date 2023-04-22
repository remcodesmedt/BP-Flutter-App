import 'package:flutter/material.dart';
import 'package:project_flutter/database/testdata/ShoppingListsMock.dart';

class ShoppingList extends StatefulWidget {
  const ShoppingList({Key? key}) : super(key: key);

  @override
  State<ShoppingList> createState() => _ShoppingListState();
}

class _ShoppingListState extends State<ShoppingList> {
  String displayText = "";

  @override
  void initState() {
    super.initState();
    getLogs();
  }

  Future<void> getLogs() async {
    try {
      String output = await ShoppingListMock.getLogsMocks();
      if (output.trim().isEmpty) output = "Nog geen data!";
      setState(() {
        displayText = output;
      });
    } catch (e) {
      setState(() {
        displayText = "Databank nog niet aangemaakt!";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Text(
        displayText,
      ),
    );
  }
}

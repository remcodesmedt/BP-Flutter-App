import 'package:flutter/material.dart';

import '../../database/testdata/DishMock.dart';
import '../../database/testdata/IngredientCategoryMock.dart';
import '../../database/testdata/IngredientMock.dart';
import '../../database/testdata/MealPlanMock.dart';
import '../../database/testdata/ShoppingListsMock.dart';

class Ingredienten extends StatefulWidget {
  const Ingredienten({Key? key}) : super(key: key);

  @override
  State<Ingredienten> createState() => _IngredientenState();
}

class _IngredientenState extends State<Ingredienten> {
  String displayText = "Ingrediënten";

  @override
  void initState() {
    super.initState();
    getLogs();
  }

  Future<void> getLogs() async {
    try {
      String output = await IngredientMock.getLogsMocks();
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

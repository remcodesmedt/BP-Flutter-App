import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:project_flutter/database/DBHelper.dart';

import '../../database/testdata/DishMock.dart';
import '../../database/testdata/IngredientCategoryMock.dart';
import '../../database/testdata/IngredientMock.dart';
import '../../database/testdata/MealPlanMock.dart';
import '../../database/testdata/ShoppingListsMock.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String? displayText;
  Uint8List? _imageData;

  Future<void> createDB() async {
    await DBHelper.init();

    setState(() {
      displayText =
          "Database gecreëerd!";
    });
  }

  Future<void> insertData() async {
    setState(() {
      displayText = "Data toevoegen...";
    });

    try {
      await IngredientCategoryMock.insertMocks();
      await IngredientMock.insertMocks();
      await ShoppingListMock.insertMocks();
      await DishMock.insertMocks();
      await MealPlanMock.insertMocks();
      setState(() {
        displayText = "Data ingevoerd!";
      });
    } catch (e) {
      setState(() {
        displayText = "Databank nog niet aangemaakt!";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 20),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                  minimumSize: const Size.fromHeight(50),
                  textStyle: const TextStyle(fontSize: 18.0)),
              onPressed: createDB,
              child: const Text(
                "Druk hier om de databank te creëren!",
                textAlign: TextAlign.center,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 20),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                  minimumSize: const Size.fromHeight(50),
                  textStyle: const TextStyle(fontSize: 18.0)),
              onPressed: insertData,
              child: const Text(
                "Druk hier om de databank te vullen!",
                textAlign: TextAlign.center,
              ),
            ),
          ),
          if (displayText != null)
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20),
              child: Text(displayText!),
            ),
          if (_imageData != null) MyImageWidget(imageData: _imageData!),
        ],
      ),
    );
  }
}

class MyImageWidget extends StatelessWidget {
  final Uint8List imageData;

  const MyImageWidget({Key? key, required this.imageData}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Image.memory(
      imageData,
      fit: BoxFit.cover,
      frameBuilder: (BuildContext context, Widget child, int? frame,
          bool wasSynchronouslyLoaded) {
        if (wasSynchronouslyLoaded) {
          return child;
        }
        return AnimatedOpacity(
          opacity: frame == null ? 0 : 1,
          duration: const Duration(seconds: 1),
          curve: Curves.easeOut,
          child: child,
        );
      },
    );
  }
}

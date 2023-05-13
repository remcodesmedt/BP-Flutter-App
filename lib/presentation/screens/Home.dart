import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:project_flutter/database/DBHelper.dart';
import 'package:project_flutter/database/testdata/ExtraImageMock.dart';

import '../../database/testdata/DishMock.dart';
import '../../database/testdata/IngredientCategoryMock.dart';
import '../../database/testdata/IngredientMock.dart';
import '../../database/testdata/MealPlanMock.dart';
import '../../database/testdata/ShoppingListsMock.dart';
import '../../domain/ExtraImage.dart';
import '../widgets/MyImages.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final double vPaddingButtons = 8.0;

  String? displayText;
  List<ExtraImage>? images;

  Future<void> createDB() async {
    await DBHelper.init();

    setState(() {
      displayText = "Database gecreëerd!";
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

  Future<void> insertImages() async {
    setState(() {
      displayText = "Images toevoegen...";
    });

    try {
      await ExtraImageMock.insertMocks();
      setState(() {
        displayText = "Images toegevoegd";
      });
    } catch (e) {
      print(e.toString());
      setState(() {
        displayText = "Databank nog niet gemaakt!";
      });
    }
  }

  Future<void> displayImages() async {
    var res = await ExtraImageMock.getMocks();
    setState(() {
      images = res;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: EdgeInsets.only(bottom: vPaddingButtons),
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
            padding: EdgeInsets.only(bottom: vPaddingButtons),
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
          Padding(
            padding: EdgeInsets.only(bottom: vPaddingButtons),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                  minimumSize: const Size.fromHeight(50),
                  textStyle: const TextStyle(fontSize: 18.0)),
              onPressed: insertImages,
              child: const Text(
                "Druk hier om de databank te vullen met extra images!",
                textAlign: TextAlign.center,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(bottom: vPaddingButtons),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                  minimumSize: const Size.fromHeight(50),
                  textStyle: const TextStyle(fontSize: 18.0)),
              onPressed: displayImages,
              child: const Text(
                "Druk hier om de images te bekijken!",
                textAlign: TextAlign.center,
              ),
            ),
          ),
          if (displayText != null)
            Padding(
              padding: EdgeInsets.symmetric(vertical: vPaddingButtons),
              child: Text(displayText!),
            ),
          if (images != null && images!.isNotEmpty)
            MyImagesWidget(images: images!)
        ],
      ),
    );
  }
}

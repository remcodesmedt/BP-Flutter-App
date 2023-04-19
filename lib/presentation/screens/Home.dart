import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:project_flutter/database/DBHelper.dart';
import 'package:project_flutter/database/testdata/DishMock.dart';
import 'package:project_flutter/database/testdata/ShoppingListsMock.dart';
import 'package:project_flutter/domain/Dish.dart';

import '../../database/testdata/IngredientCategoryMock.dart';
import '../../database/testdata/IngredientMock.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String _displayText = "Homescreen";
  Uint8List? _imageData = null;

  Future<void> fillDb() async {
    print("inserting mocks");
    await IngredientCategoryMock.insertMocks();
    await IngredientMock.insertMocks();
    await ShoppingListMock.insertMocks();
    await DishMock.insertMocks();
  }

  Future<void> logItems() async {
    print("logging mocks");
    await IngredientCategoryMock.logMocks();
    await IngredientMock.logMocks();
    await ShoppingListMock.logMocks();
    var dish = await DishMock.logMocks();
    setState(() {
      _imageData = dish.image;
    });
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
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Center(
            child: Text(
              _displayText ?? "Homescreen",
              textAlign: TextAlign.center,
            ),
          ),
          if (_imageData != null) MyImageWidget(imageData: _imageData!),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: fabClicked,
        child: const Icon(Icons.add),
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
          child: child,
          opacity: frame == null ? 0 : 1,
          duration: const Duration(seconds: 1),
          curve: Curves.easeOut,
        );
      },
    );
  }
}

import 'package:flutter/material.dart';

import '../../database/testdata/DishMock.dart';

class Gerechten extends StatefulWidget {
  const Gerechten({Key? key}) : super(key: key);

  @override
  State<Gerechten> createState() => _GerechtenState();
}

class _GerechtenState extends State<Gerechten> {
  String displayText = "Gerechten";

  @override
  void initState() {
    super.initState();
    getLogs();
  }

  Future<void> getLogs() async {
    try {
      String output = await DishMock.getLogsMocks();
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

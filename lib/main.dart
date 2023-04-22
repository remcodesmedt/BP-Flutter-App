import 'package:flutter/material.dart';
import 'package:project_flutter/presentation/screens/Gerechten.dart';
import 'package:project_flutter/presentation/screens/Home.dart';
import 'package:project_flutter/presentation/screens/Ingredienten.dart';
import 'package:project_flutter/presentation/screens/Planning.dart';
import 'package:project_flutter/presentation/screens/ShoppingList.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter App',
      theme: ThemeData(
          primarySwatch: Colors.deepPurple,
          textTheme: const TextTheme(bodyMedium: TextStyle(fontSize: 18))),
      home: const MyHomePage(title: 'Flutter App'),
    );
  }
}

//config voor state, dus houdt values zoals title provided door de parent (MyApp)
//fields altijd final
//stateful => has State object that contains fields that affect how it looks
class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

//soortvan component die properties heeft en telkens die state wijzigen gaat de
//component rerenderen (die build method dus)
class _MyHomePageState extends State<MyHomePage> {
  int _currentIndex = 0;

  void onNavigate(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  List<BottomNavigationBarItem> navigationItems = [
    const BottomNavigationBarItem(
        icon: Icon(Icons.home),
        label: "Home",
        backgroundColor: Colors.deepPurple),
    const BottomNavigationBarItem(
        icon: Icon(Icons.dining),
        label: "Gerechten",
        backgroundColor: Colors.deepPurpleAccent),
    const BottomNavigationBarItem(
        icon: Icon(Icons.egg),
        label: "Ingrediënten",
        backgroundColor: Colors.purple),
    const BottomNavigationBarItem(
        icon: Icon(Icons.menu_book),
        label: "Planning",
        backgroundColor: Colors.purpleAccent),
    const BottomNavigationBarItem(
        icon: Icon(Icons.receipt_long),
        label: "Shopping list",
        backgroundColor: Color(0xFF4A148C))
  ];

  final List<Widget> tabs = [
    const Home(),
    const Gerechten(),
    const Ingredienten(),
    const Planning(),
    const ShoppingList(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // widget is hier zo de MyHomePage
        title: Text(widget.title),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: tabs[_currentIndex],
      ),
      bottomNavigationBar: BottomNavigationBar(
          items: navigationItems,
          currentIndex: _currentIndex,
          onTap: onNavigate,
          iconSize: 30),
    );
  }
}

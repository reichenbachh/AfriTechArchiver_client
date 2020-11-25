import 'package:flutter/material.dart';
import '../utils/convertColor.dart';
import '../screens/FetchedArticlesScree.dart';
import '../widgets/Drawer.dart';
import '../screens/SavedArticleDetailScreen.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  static const List<Widget> _widgetOptions = [
    FetchedArticlesScreen(),
    SavedArticlesScreen()
  ];
  int currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: AppDrawer(),
      appBar: AppBar(
        title: Center(
          child: Text(
            "AfriTechArchiver",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 26,
              color: colorConvert("#8A0707"),
            ),
          ),
        ),
      ),
      body: Container(child: _widgetOptions.elementAt(currentIndex)),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        selectedItemColor: colorConvert("#8A0707"),
        unselectedItemColor: Colors.grey,
        currentIndex: currentIndex,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: "Home",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.archive),
            label: "archive",
          )
        ],
        onTap: (index) {
          setState(() {
            currentIndex = index;
          });
        },
      ),
    );
  }
}

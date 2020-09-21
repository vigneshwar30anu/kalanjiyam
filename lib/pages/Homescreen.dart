import 'package:flutter/material.dart';
import 'package:kalanjiyam/pages/LandingScreen.dart';

import 'AllSongs.dart';
import 'Search.dart';
import 'Settings.dart';

class Homescreen extends StatefulWidget {
  @override
  _HomescreenState createState() => _HomescreenState();
}

class _HomescreenState extends State<Homescreen> {
  int selectedIndex = 0;
  final widgetOptions = [
    LandingScreen(),
    AllSongs(),
    Settings(),
  ];

  @override
  Widget build(BuildContext context) {
    // return DefaultTextStyle(
    //   style: Theme.of(context).textTheme.bodyText2,
    //   child: LayoutBuilder(
    //     builder: (BuildContext context, BoxConstraints viewportConstraints) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        // appBar: new AppBar(
        //   centerTitle: true,
        //   title: new Text("Kalanjiyam".toUpperCase()),
        //   // automaticallyImplyLeading: false, // this is to disable drawer icon
        //   backgroundColor: Color.fromRGBO(19, 71, 110, 0.9),
        // ),
        body: Center(
          child: widgetOptions.elementAt(selectedIndex),
        ),
        bottomNavigationBar: new BottomNavigationBar(
          currentIndex: selectedIndex,
          onTap: (int index) {
            setState(() {
              selectedIndex = index;
            });
          },
          items: [
            BottomNavigationBarItem(
                icon: new Icon(Icons.home),
                backgroundColor: Colors.black,
                title: new Text('Home')),
            BottomNavigationBarItem(
                icon: new Icon(Icons.library_music),
                title: new Text('All Songs')),
            BottomNavigationBarItem(
              icon: new Icon(Icons.settings),
              title: new Text('Settings'),
            ),
          ],
          fixedColor: Colors.deepPurple,
        ),
      ),
    );
  }
}

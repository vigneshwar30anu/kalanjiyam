import 'package:flutter/material.dart';
import 'package:splashscreen/splashscreen.dart';
import 'package:kalanjiyam/pages/Homescreen.dart';

void main() {
  runApp(new MaterialApp(
    home: new MyApp(),
  ));
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => new _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return new SplashScreen(
      seconds: 5,
      navigateAfterSeconds: new Homescreen(),

      image: Image.asset('assets/images/thiruvalluar_splash.png'),

      //gradientBackground: new LinearGradient(colors: [Colors.cyan, Colors.blue], begin: Alignment.topLeft, end: Alignment.bottomRight),
      // backgroundColor: Color.fromRGBO(19,71,110,1),

      // styleTextUnderTheLoader: new TextStyle(),
      photoSize: 150.0,

      loaderColor: Colors.red,
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_login/src/screen/dashboard.dart';
<<<<<<< HEAD
import 'package:flutter_login/src/screen/detail_movie.dart';
import 'package:flutter_login/src/screen/favorites.dart';
import 'package:flutter_login/src/screen/login.dart';
import 'package:flutter_login/src/screen/profile.dart';
import 'package:flutter_login/src/screen/splashscreen.dart';
=======
import 'package:flutter_login/src/screen/favorites.dart';
import 'package:flutter_login/src/screen/login.dart';
import 'package:flutter_login/src/screen/profile.dart';
>>>>>>> origin/main
import 'package:flutter_login/src/screen/trending.dart';
import 'package:flutter_login/src/screen/search.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(MaterialApp(
    home: MyApp(),
  ));
}

class MyApp extends StatefulWidget {
  const MyApp({Key key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String tokenPreferences;
  bool _sel = false;

  Widget build(BuildContext context) {
    //obtenerPreferencias();
    return MaterialApp(
      routes: {
        '/login': (BuildContext context) => Login(),
        '/trending': (BuildContext context) => Trending(),
        '/dashboard': (BuildContext context) => Dashboard(),
        '/search': (BuildContext context) => Search(),
        '/favorites': (BuildContext context) => Favorites(),
        '/profile': (BuildContext context) => Profile(),
<<<<<<< HEAD
        '/exit': (BuildContext context) => Login(),
        '/detail': (BuildContext context) => DetailMovie()
      },
      home: Splashscreen(),
=======
        '/exit': (BuildContext context) => Login()
      },
      home: Login(),
>>>>>>> origin/main
    );
  }

  Future obtenerPreferencias() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    tokenPreferences = preferences.getString("token") ?? null;
    _sel = preferences.getBool("_sel") ?? _sel;
    print(_sel);
    if (_sel == true)
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => Dashboard()));
  }
}

import 'package:flutter/material.dart';
import 'dart:io';
import 'package:flutter/widgets.dart';
import 'package:flutter_login/src/assets/configuration.dart';
import 'package:flutter_login/src/database/database_helper.dart';
import 'package:flutter_login/src/models/userDao.dart';
import 'package:flutter_login/src/network/api_movies.dart';
import 'package:flutter_login/src/screen/login.dart';
import 'package:flutter_login/src/screen/profile.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'login.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({Key key}) : super(key: key);

  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  String emailUser = "";
  DataBaseHelper _database;

  void initState() {
    super.initState();
    _database = DataBaseHelper();
  }

  @override
  Widget build(BuildContext context) {
    ApiMovies apiMovie = ApiMovies();
    //apiMovie.getTrending();
    return (FutureBuilder(
      future: obtenerPreferencias(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        Future<UserDAO> _objUser = _database.getUsuario(emailUser);
        return (Container(
          child: Scaffold(
            appBar: AppBar(
              backgroundColor: Configuration.colorApps,
              title: Text('Peliculas'),
            ),
            drawer: Drawer(
              child: FutureBuilder(
                  future: _objUser,
                  builder:
                      (BuildContext context, AsyncSnapshot<UserDAO> snapshot) {
                    return (ListView(
                      children: <Widget>[
                        UserAccountsDrawerHeader(
                          decoration:
                              BoxDecoration(color: Configuration.colorItems),
                          currentAccountPicture: snapshot.data == null
                              ? CircleAvatar(
                                  backgroundImage: NetworkImage(
                                      'https://villasmilindovillas.com/wp-content/uploads/2020/01/Profile.png'),
                                )
                              : ClipOval(
                                  child: Image.file(File(snapshot.data.foto),
                                      fit: BoxFit.cover)),
                          accountName: snapshot.data == null
                              ? Text('El brayam')
                              : Text(snapshot.data.nomUser),
                          accountEmail: snapshot.data == null
                              ? (emailUser == ""
                                  ? Text('Email')
                                  : Text(emailUser))
                              : Text(snapshot.data.emailUser),
                          onDetailsPressed: () {
                            Navigator.pop(context);
                            Navigator.pushNamed(context, '/profile');
                          },
                        ),
                        ListTile(
                          leading: Icon(Icons.trending_up,
                              color: Configuration.colorItems),
                          title: Text('Trending'),
                          onTap: () {
                            Navigator.pop(context);
                            Navigator.pushNamed(context, '/trending');
                          },
                        ),
                        ListTile(
                          leading: Icon(Icons.search,
                              color: Configuration.colorItems),
                          title: Text('Search'),
                          onTap: () {
                            Navigator.pop(context);
                            Navigator.pushNamed(context, '/search');
                          },
                        ),
                        ListTile(
                          leading: Icon(Icons.favorite,
                              color: Configuration.colorItems),
                          title: Text('Favorites'),
                          onTap: () {
                            Navigator.pop(context);
                            Navigator.pushNamed(context, '/favorites');
                          },
                        ),
                        ListTile(
                          leading: Icon(Icons.login_outlined,
                              color: Configuration.colorItems),
                          title: Text('Profile'),
                          onTap: () {
                            Navigator.push(
                                context,
                                new MaterialPageRoute(
                                    builder: (context) => new Profile()));
                          },
                        ),
                        ListTile(
                          leading: Icon(Icons.exit_to_app,
                              color: Configuration.colorItems),
                          title: Text('exit'),
                          onTap: () {
                            salir();
                            Navigator.pushAndRemoveUntil(
                                context,
                                MaterialPageRoute(
                                    builder: (BuildContext context) => Login()),
                                ModalRoute.withName('/login'));
                          },
                        )
                      ],
                    ));
                  }),
            ),
          ),
        ));
      },
    ));
  }

  Future<void> salir() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.clear();
  }

  obtenerPreferencias() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    emailUser = preferences.getString("emailLogin") ?? "";
    print(preferences.getString('emailLogin'));
  }
}

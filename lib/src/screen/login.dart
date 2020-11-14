import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_login/src/models/userDao.dart';
import 'package:flutter_login/src/network/api_login.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'dashboard.dart';

class Login extends StatefulWidget {
  Login({Key key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  ApiLogin httpLogin = ApiLogin();
  bool isValidating = false; // variable para el indicador de progreso
  bool _sel = false;
  bool _selPref = false;

  String tokenPreferences;
  TextEditingController txtUser = TextEditingController();
  TextEditingController txtPwd = TextEditingController();
  @override
  void initState() {
    super.initState();
    obtenerPreferencias();
  }

  @override
  Widget build(BuildContext context) {
    final logo = CircleAvatar(
      radius: 35,
      backgroundImage: NetworkImage(
          'https://maryza.gnomio.com/pluginfile.php/2/course/section/1/logoTecNM.png'),
      backgroundColor: Colors.transparent,
    );
    final txtEmail = TextFormField(
      controller: txtUser,
      keyboardType: TextInputType.emailAddress,
      decoration: InputDecoration(
        hintText: "ejem@mail.com",
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
        contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
      ),
    );
    final txtPass = TextFormField(
      controller: txtPwd,
      keyboardType: TextInputType.text,
      decoration: InputDecoration(
          hintText: 'contraseña',
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
          contentPadding: EdgeInsets.symmetric(vertical: 5, horizontal: 20)),
    );

    final cbLogin = Checkbox(
      onChanged: (bool resp) {
        setState(() {
          _sel = resp;
        });
      },
      value: _sel,
    );

    final loginButton = RaisedButton(
      onPressed: () async {
        //Navigator.pushNamed('/miruta');
        setState(() {
          isValidating = true;
        });
        UserDAO objUser = UserDAO(username: txtUser.text, pwduser: txtPwd.text);
        httpLogin.validateUser(objUser).then((token) {
          guardarPreferencias(token); //manda el token al metodo para guardarlo
          if (token != null)
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => Dashboard()));
          else {
            showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: Text('error'),
                    content: Text('The credentials are incorrect'),
                    actions: <Widget>[
                      FlatButton(
                        child: Text('close'),
                        onPressed: () => Navigator.of(context).pop(),
                      )
                    ],
                  );
                });
          }
        });
      },
      child: Text('Validar usuario', style: TextStyle(color: Colors.white)),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      color: Color.fromRGBO(67, 67, 67, 1),
    );

    return (FutureBuilder(
      future: obtenerPreferencias(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
          if (_selPref == true)
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => Dashboard()));
        });
        return (Stack(
          alignment: Alignment.bottomCenter,
          children: <Widget>[
            Container(
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage('assets/back1.jpg'),
                      fit: BoxFit.fitHeight)),
            ),
            Card(
                margin: EdgeInsets.all(15.0),
                color: Colors.white70,
                elevation: 8.0,
                child: Padding(
                  padding: EdgeInsets.all(5),
                  child: ListView(
                    shrinkWrap: true,
                    children: <Widget>[
                      txtEmail,
                      SizedBox(height: 10),
                      txtPass,
                      SizedBox(
                        height: 5,
                      ),
                      Row(
                        children: <Widget>[
                          Text("Guardar Sesion"),
                          cbLogin,
                        ],
                      ),
                      SizedBox(height: 10),
                      loginButton,
                    ],
                  ),
                )),
            Positioned(
              child: logo,
              top: 240,
            ),
            Positioned(
                top: 320,
                child: isValidating ? CircularProgressIndicator() : Container())
          ],
        ));
      },
    ));
  }

  guardarPreferencias(String token) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setString("token", token);
    preferences.setBool("_sel", _sel);
    preferences.setString("emailLogin", txtUser.text);
    preferences.setString("passwdlLogin", txtPwd.text);
  }

  obtenerPreferencias() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    tokenPreferences = preferences.getString("token") ?? null;
    _selPref = preferences.getBool("_sel") ?? false;
  }
}

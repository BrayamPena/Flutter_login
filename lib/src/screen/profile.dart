import 'dart:io';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_login/src/database/database_helper.dart';
import 'package:flutter_login/src/models/userDao.dart';
import 'package:flutter_login/src/screen/dashboard.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Profile extends StatefulWidget {
  const Profile({Key key}) : super(key: key);

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  final picker = ImagePicker();
  String imagePath = "";
  String imagePathUser = "";
  DataBaseHelper _database = DataBaseHelper();
  TextEditingController txtNombre = TextEditingController();
  TextEditingController txtappUser = TextEditingController();
  TextEditingController txtapmUser = TextEditingController();
  TextEditingController txtMail = TextEditingController();
  TextEditingController txtPhone = TextEditingController();
  int id;

  var emailPreferences = "";
  Future<UserDAO> _objUser;
  @override
  void initState() {
    //TODO: implement initState
    super.initState();
    _database = DataBaseHelper();
    obtenerPreferencias();
  }

  @override
  Widget build(BuildContext context) {
    final imgFinal = FutureBuilder(
      future: obtenerPreferencias(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        return ((imagePathUser == "" && imagePath == "")
            ? CircleAvatar(
                radius: 45,
                backgroundImage: NetworkImage(
                    'https://villasmilindovillas.com/wp-content/uploads/2020/01/Profile.png'),
                backgroundColor: Colors.transparent,
              )
            : ClipOval(
                child: Image.file(
                  File(imagePathUser == "" ? imagePath : imagePathUser),
                  fit: BoxFit.cover,
                ),
              ));
      },
    );

    final txtEmail = TextFormField(
      keyboardType: TextInputType.emailAddress,
      style: TextStyle(fontSize: 20, color: Colors.white),
      controller: txtMail,
      enabled: false,
      decoration: InputDecoration(
          hintText: "16030614@itcelaya.edu.mx",
          hintStyle: TextStyle(fontSize: 20, color: Colors.white),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
          contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
          prefixIcon: Icon(Icons.email, color: Colors.white)),
    );

    final buttonNewPhoto = RaisedButton(
      onPressed: () async {
        final pickedFile = await picker.getImage(source: ImageSource.camera);
        imagePath = pickedFile != null ? pickedFile.path : "";
        imagePathUser = imagePath;
        setState(() {});
      },
      child: Icon(Icons.photo_camera_rounded),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      color: Colors.blue[300],
    );

    final txtName = TextFormField(
      keyboardType: TextInputType.name,
      controller: txtNombre,
      style: TextStyle(fontSize: 20, color: Colors.black),
      decoration: InputDecoration(
          hintText: "Nombre",
          hintStyle: TextStyle(fontSize: 20, color: Colors.black),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
          contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
          prefixIcon: Icon(Icons.edit)),
    );

    final txtApellidoP = TextFormField(
      keyboardType: TextInputType.name,
      controller: txtappUser,
      style: TextStyle(fontSize: 20, color: Colors.black),
      decoration: InputDecoration(
          hintText: "Apellido Paterno",
          hintStyle: TextStyle(fontSize: 20, color: Colors.black),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
          contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
          prefixIcon: Icon(Icons.edit)),
    );

    final txtApellidoM = TextFormField(
      keyboardType: TextInputType.name,
      controller: txtapmUser,
      style: TextStyle(fontSize: 20, color: Colors.black),
      decoration: InputDecoration(
          hintText: "Apellido Materno",
          hintStyle: TextStyle(fontSize: 20, color: Colors.black),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
          contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
          prefixIcon: Icon(Icons.edit)),
    );

    final txtTel = TextFormField(
        keyboardType: TextInputType.number,
        controller: txtPhone,
        style: TextStyle(fontSize: 20, color: Colors.black),
        decoration: InputDecoration(
          hintStyle: TextStyle(fontSize: 20, color: Colors.black),
          hintText: "Phone",
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
          contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
          prefixIcon: Icon(Icons.phone),
        ));

    final buttonSave = FutureBuilder(
      future: obtenerPreferencias(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        return (RaisedButton(
          onPressed: () {
            //mandamos a la BDs
            UserDAO user = UserDAO(
              id: id,
              username: "username",
              pwduser: "password",
              nomUser: txtNombre.text,
              appUser: txtappUser.text,
              apmUser: txtapmUser.text,
              telUser: txtPhone.text,
              emailUser: txtMail.text,
              foto: imagePathUser,
            );
            id == null
                ? _database.insertar(user.toJSON(), 'tbl_perfil')
                : _database.actualizar(user.toJSON(), 'tbl_perfil');
            print(user.toJSON());
            Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                    builder: (BuildContext context) => Dashboard()),
                ModalRoute.withName("/login"));
          },
          child: Icon(Icons.save),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          color: Colors.blue[300],
        ));
      },
    );

    return MaterialApp(
      home: Scaffold(
        resizeToAvoidBottomPadding: false,
        appBar: AppBar(title: Text('User Profile')),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Container(
              height: 205,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: NetworkImage(
                          'https://4.bp.blogspot.com/-bSacwnRirt8/UwXpYSJRexI/AAAAAAAAf2E/-TtywDQRf1o/s1600/Descargar+Increibles+fondos+abstractos+HD+%2528472%2529.jpg'),
                      fit: BoxFit.cover)),
              child: Column(
                children: <Widget>[
                  SizedBox(height: 5),
                  Positioned(
                      top:
                          120.0, // (background container size) - (circle height / 2)
                      child: Container(
                          height: 80.0,
                          width: 80.0,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            //color: Colors.green
                          ),
                          child: imgFinal)),
                  SizedBox(height: 5),
                  buttonNewPhoto,
                  SizedBox(height: 5),
                  txtEmail,
                ],
              ),
            ),
            SizedBox(height: 30),
            Card(
                margin: EdgeInsets.all(10.0),
                color: Colors.white70,
                elevation: 8.0,
                child: Padding(
                  padding: EdgeInsets.all(5),
                  child: ListView(
                    shrinkWrap: true,
                    children: <Widget>[
                      txtName,
                      SizedBox(height: 5),
                      txtApellidoP,
                      SizedBox(height: 5),
                      txtApellidoM,
                      SizedBox(height: 10),
                      txtTel,
                      SizedBox(height: 10),
                      buttonSave,
                    ],
                  ),
                )),
          ],
        ),
      ),
    );
  }

  void setValues(String email) async {
    UserDAO user = await _database.getUsuario(email);
    if (user != null) {
      id = user.id;
      txtNombre.text = user.nomUser;
      txtappUser.text = user.appUser;
      txtMail.text = user.emailUser;
      txtapmUser.text = user.apmUser;
      txtPhone.text = user.telUser;
      imagePathUser = imagePath != "" ? imagePath : user.foto;
    } else {
      txtMail.text = emailPreferences;
    }
  }

  obtenerPreferencias() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    emailPreferences = preferences.getString("emailLogin") ?? emailPreferences;
    setValues(emailPreferences);
  }
}

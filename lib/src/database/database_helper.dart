import 'dart:io';
import 'package:flutter_login/src/models/userDao.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DataBaseHelper {
  static final _nombreBD = "PATM2020";
  static final _versionBD = 1;

  static Database _database;
  Future<Database> get database async {
    if (_database != null) return _database;
    _database = await _initDatabase();
    return _database;
  }

  _initDatabase() async {
    Directory carpeta = await getApplicationDocumentsDirectory();
    String rutaBD = join(carpeta.path, _nombreBD);

    return await openDatabase(rutaBD, //ruta
        version: _versionBD, //version
        onCreate: _crearTablas);
  }

  _crearTablas(Database db, int version) async {
    await db.execute(
        "CREATE TABLE tbl_perfil(id INTEGER PRIMARY KEY, nomUser varchar(25),appUser varchar(25),apmUser varchar(25),telUser varchar(10), emailUser varchar(30),foto varchar(200), username varchar(30), pwduser varchar(20))");
  }

  Future<int> insertar(Map<String, dynamic> row, String tabla) async {
    var dbClient = await database;
    return await dbClient.insert(tabla, row);
  }

  Future<int> actualizar(Map<String, dynamic> row, String tabla) async {
    var dbClient = await database;
    return await dbClient
        .update(tabla, row, where: 'id = ?', whereArgs: [row['id']]);
  }

  Future<int> eliminar(int id, String tabla) async {
    var dbClient = await database;
    return await dbClient.delete(tabla, where: 'id = ?', whereArgs: [id]);
  }

  Future<UserDAO> getUsuario(String mailUser) async {
    var dbClient = await database;
    var result = await dbClient
        .query('tbl_perfil', where: 'emailUser = ?', whereArgs: [mailUser]);
    var lista = (result).map((item) => UserDAO.fromJSON(item)).toList();
    return lista.length > 0 ? lista[0] : null
        /*: UserDAO(
            nomUser: 'Invitado',
            appUser: '',
            apmUser: '',
            telUser: '',
            mailUser: 'invitado@gmail.com',
            foto:
                'https://villasmilindovillas.com/wp-content/uploads/2020/01/Profile.png',
            pwduser: '',
            username: '')*/
        ;
  }
}

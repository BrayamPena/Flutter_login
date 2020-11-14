import 'package:flutter_login/src/models/userDao.dart';
import 'package:http/http.dart' show Client;

class ApiLogin {
  final String ENDPOINT = "http://192.168.8.116:8888/signup";
  Client http = Client();
  Future<String> validateUser(UserDAO objUser) async {
    final response = await http.post('$ENDPOINT',
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8'
        },
        body: objUser.userToJSON());
    if (response.statusCode == 200) {
      return response.body;
    } else {
      return null;
    }
  }
}

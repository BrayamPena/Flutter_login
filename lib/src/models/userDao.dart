import 'dart:convert';

class UserDAO {
  String username;
  String pwduser;

  int id;
  String nomUser;
  String appUser;
  String apmUser;
  String telUser;
  String emailUser;
  String foto;

  UserDAO(
      {this.id,
      this.username,
      this.pwduser,
      this.nomUser,
      this.appUser,
      this.apmUser,
      this.telUser,
      this.emailUser,
      this.foto});

  factory UserDAO.fromJSON(Map<String, dynamic> map) {
    return UserDAO(
      id: map['id'],
      username: map['username'],
      pwduser: map['pwduser'],
      nomUser: map['nomUser'],
      appUser: map['appUser'],
      apmUser: map['apmUser'],
      telUser: map['telUser'],
      emailUser: map['emailUser'],
      foto: map['foto'],
    );
  }
  Map<String, dynamic> toJSON() {
    return {
      "id": id,
      "username": username,
      "pwduser": pwduser,
      "nomUser": nomUser,
      "appUser": appUser,
      "apmUser": apmUser,
      "telUser": telUser,
      "emailUser": emailUser,
      "foto": foto
    };
  }

  String userToJSON() {
    final mapUser = this.toJSON();
    //json.encode(mapUser);
    return json.encode(mapUser);
  }
}

import 'package:flutter/cupertino.dart';

class Repository {
  Future<User> getUser() async {
    await Future.delayed(Duration(seconds: 2));
    return User(name: 'John', surname: 'Smith');
  }
}

class User {
  User({
    @required this.name,
    @required this.surname,
  });

  final String name;
  final String surname;
}

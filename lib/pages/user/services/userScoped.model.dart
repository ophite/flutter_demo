import 'package:flutter/cupertino.dart';
import 'package:scoped_model/scoped_model.dart';
import './user.model.dart';
import './user.repository.dart';

class UserScoped extends Model {
  UserScoped(this._repository);
  final UserRepository _repository;

  bool _loading = false;
  User _user;

  User get user => _user;
  bool get loading => _loading;

  void loadUserData() {
    _loading = true;
    notifyListeners();
    _repository.getUser().then((user) {
      _user = user;
      _loading = false;
      notifyListeners();
    });
  }

  static UserScoped of(BuildContext context) =>
      ScopedModel.of<UserScoped>(context);
}

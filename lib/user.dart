import 'package:flutter/material.dart';
import 'package:flutter_app/fetch_data/user.dart';

import 'drawer.dart';

class UserPage extends StatefulWidget {
  UserPage(this._repository);
  final Repository _repository;

  @override
  _UserPageState createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {
  bool _loading = false;
  User _user;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('User'),
      ),
      drawer: DrawerMain(selected: "user"),
      body: SafeArea(
        child: _loading ? _buildLoading() : _buildBody(),
      ),
    );
  }

  Widget _buildBody() {
    if (_user != null) {
      return _buildContent();
    } else {
      return _buildInit();
    }
  }

  Widget _buildInit() {
    return Center(
      child: RaisedButton(
        child: const Text('Load user data'),
        onPressed: () {
          setState(() {
            _loading = true;
          });
          widget._repository.getUser().then((user) {
            setState(() {
              _user = user;
              _loading = false;
            });
          });
        },
      ),
    );
  }

  Widget _buildContent() {
    return Center(
      child: Text('Hello ${_user.name} ${_user.surname}'),
    );
  }

  Widget _buildLoading() {
    return const Center(
      child: CircularProgressIndicator(),
    );
  }
}

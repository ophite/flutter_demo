import 'package:flutter/material.dart';
import 'package:flutter_app/fetch_data/user.dart';
import 'package:flutter_app/fetch_data/user.scoped.dart';
import 'package:scoped_model/scoped_model.dart';
import 'drawer.dart';

class UserScopedPage extends StatefulWidget {
  UserScopedPage(this._repository);
  final Repository _repository;

  @override
  _UserPageScopedState createState() => _UserPageScopedState();
}

class _UserPageScopedState extends State<UserScopedPage> {
  UserScoped _userScoped;

  @override
  void initState() {
    _userScoped = UserScoped(widget._repository);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ScopedModel(
        model: _userScoped,
        child: Scaffold(
          appBar: AppBar(
            title: const Text('Scoped User'),
          ),
          drawer: DrawerMain(selected: "userScoped"),
          body: SafeArea(
            child: ScopedModelDescendant<UserScoped>(
              builder: (context, child, model) {
                if (model.loading) {
                  return _buildLoading();
                } else {
                  if (model.user != null) {
                    return _buildContent(model);
                  } else {
                    return _buildInit(model);
                  }
                }
              },
            ),
          ),
        ));
  }

  Widget _buildInit(UserScoped userScoped) {
    return Center(
      child: RaisedButton(
        child: const Text('Load user data'),
        onPressed: () {
          userScoped.loadUserData();
        },
      ),
    );
  }

  Widget _buildContent(UserScoped userScoped) {
    return Center(
      child: Text('Hello ${userScoped.user.name} ${userScoped.user.surname}'),
    );
  }

  Widget _buildLoading() {
    return const Center(
      child: CircularProgressIndicator(),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_app/pages/user/services/user.model.dart';
import '../../widgets/drawer.widget.dart';

class LakePage extends StatefulWidget {
  @override
  _LakePageState createState() => _LakePageState();
}

class _LakePageState extends State<LakePage> {
  bool _loading = false;
  User _user;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('User'),
      ),
      drawer: DrawerMain(selected: "lake"),
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

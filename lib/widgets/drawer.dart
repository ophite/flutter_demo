import 'package:flutter/material.dart';
import 'package:flutter_app/fetch_data/user.dart';
import 'package:flutter_app/pages/user.scoped.dart';
import '../pages/projects.dart';
import '../pages/home.dart';
import '../pages/user.dart';

class DrawerMain extends StatefulWidget {
  DrawerMain({Key key, this.selected}) : super(key: key);

  final String selected;

  @override
  DrawerMainState createState() {
    return DrawerMainState();
  }
}

class DrawerMainState extends State<DrawerMain> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
        child: ListView(padding: EdgeInsets.zero, children: <Widget>[
      DrawerHeader(
        child: Text(
          'Flutter demo',
          style: TextStyle(
            color: Colors.white,
            fontSize: 32.0,
          ),
        ),
        decoration: BoxDecoration(
          color: Colors.blue,
        ),
      ),
      ListTile(
        selected: widget.selected == 'about',
        leading: Icon(Icons.info),
        title: Text('About menu'),
        onTap: () {
          Navigator.pop(context);
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => MyHomePage()),
          );
        },
      ),
      ListTile(
        selected: widget.selected == 'projects',
        leading: Icon(Icons.list),
        title: Text('Projects menu'),
        onTap: () {
          Navigator.pop(context);
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => ProjectsPage()),
          );
        },
      ),
      ListTile(
        selected: widget.selected == 'user',
        leading: Icon(Icons.verified_user),
        title: Text('User menu'),
        onTap: () {
          Navigator.pop(context);
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => UserPage(new Repository())),
          );
        },
      ),
      ListTile(
        selected: widget.selected == 'userScoped',
        leading: Icon(Icons.supervised_user_circle),
        title: Text('User scoped menu'),
        onTap: () {
          Navigator.pop(context);
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => UserScopedPage(new Repository())),
          );
        },
      )
    ]));
  }
}

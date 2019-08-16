import 'package:flutter/material.dart';
import 'package:flutter_app/pages/user/services/user.repository.dart';
import 'package:flutter_app/pages/lake/lake.page.dart';
import 'package:flutter_app/pages/user/userScoped.page.dart';
import '../pages/project/projects.page.dart';
import '../pages/home/home.page.dart';
import '../pages/user/user.page.dart';

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
            MaterialPageRoute(
                builder: (context) => UserPage(new UserRepository())),
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
                builder: (context) => UserScopedPage(new UserRepository())),
          );
        },
      ),
      ListTile(
        selected: widget.selected == 'lake',
        leading: Icon(Icons.open_with),
        title: Text('Lake menu'),
        onTap: () {
          Navigator.pop(context);
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => LakePage()));
        },
      ),
    ]));
  }
}

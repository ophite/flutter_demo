import 'package:flutter/material.dart';
import 'package:flutter_app/fetch_data/repository.dart';
import 'projects.dart';
import 'home.dart';
import 'user.dart';

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
        title: Text('Про нас'),
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
        title: Text('Проекти'),
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
        title: Text('User2'),
        onTap: () {
          Navigator.pop(context);
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => UserPage(new Repository())));
        },
      ),
    ]));
  }
}

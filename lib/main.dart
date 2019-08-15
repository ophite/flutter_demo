import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_app/fetch_data/project.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/scheduler.dart';
import 'dart:convert';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'about2',),
    );
  }
}


class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}
//class MyHomePage extends StatelessWidget {
//  @override
//  Widget build(BuildContext context) {
//    return Scaffold(
//      appBar: AppBar(
//        title: Text('Про нас'),
//      ),
//      drawer: DrawerMain(selected: "about"),
//      body: Center(
//        child: Text(
//          'Ми робимо додаток на Flutter.',
//        ),
//      ),
//    );
//  }
//}
//
class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    log('>>>>> ');
    log(widget.title.toString());
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text('About'),
      ),
      drawer: DrawerMain(selected: "about"),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          // Column is also layout widget. It takes a list of children and
          // arranges them vertically. By default, it sizes itself to fit its
          // children horizontally, and tries to be as tall as its parent.
          //
          // Invoke "debug painting" (press "p" in the console, choose the
          // "Toggle Debug Paint" action from the Flutter Inspector in Android
          // Studio, or the "Toggle Debug Paint" command in Visual Studio Code)
          // to see the wireframe for each widget.
          //
          // Column has various properties to control how it sizes itself and
          // how it positions its children. Here we use mainAxisAlignment to
          // center the children vertically; the main axis here is the vertical
          // axis because Columns are vertical (the cross axis would be
          // horizontal).
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.display1,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}

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
  Widget build (BuildContext context) {
    return Drawer(
        child: ListView(
            padding: EdgeInsets.zero,
            children: <Widget>[
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
            ]
        )
    );
  }
}

class ProjectsPage extends StatefulWidget {
  @override
  _ProjectsPageState createState() => _ProjectsPageState();
}

class _ProjectsPageState extends State<ProjectsPage> {
  List<Project> list = List();
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey = new GlobalKey<RefreshIndicatorState>();

  Future _fetchData() async {
    final response = await http.get(
        "https://raw.githubusercontent.com/jhekasoft/flutter_demo/master/fake_api/project_list.json"
    );
    if (response.statusCode == 200) {
      setState(() {
        list = (json.decode(response.body) as List)
            .map((data) => new Project.fromJson(data))
            .toList();
      });
    } else {
      throw Exception('Failed to load projects');
    }
  }

  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((_){  _refreshIndicatorKey.currentState?.show(); });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Проекти2"),
      ),
      drawer: DrawerMain(selected: "projects"),
      body: RefreshIndicator(
        key: _refreshIndicatorKey,
        onRefresh: _fetchData,
        child: ListView.builder(
          itemCount: list.length,
          itemBuilder: (BuildContext context, int index) {
            return Card(
              child: Container(
                padding: EdgeInsets.all(16.0),
                child: Column(
                  children: <Widget>[
                    Image.network(
                      list[index].imageUrl,
                      fit: BoxFit.fitHeight,
                      width: 600.0,
                      height: 240.0,
                    ),
                    Text(
                      list[index].title,
                      style: TextStyle(fontSize: 14.0, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      list[index].shortDesc,
                      style: TextStyle(fontSize: 11.0, fontWeight: FontWeight.normal),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

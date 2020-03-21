import 'package:flutter/material.dart';
import 'package:flare_flutter/flare_actor.dart';
import 'package:quarantinerpg/tutorial_overlay.dart';
import 'mappage.dart';
import 'characterpage.dart';
import 'questpage.dart';
import 'settingspage.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Quarantäne RPG',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Quarantäne RPG'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
          actions: <Widget>[
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => SettingsPage()
              ),
            );
              },
              child: Padding(
                padding: EdgeInsets.fromLTRB(0, 0, 25, 0),
                child: Icon(Icons.settings),
              ),
            ),
            
          ],
          bottom: TabBar(
            tabs: [
              Tab(icon: Icon(Icons.directions_car)),
              Tab(icon: Icon(Icons.directions_transit)),
              Tab(icon: Icon(Icons.directions_bike)),
            ],
          ),
        ),
        body: TabBarView(
          children: <Widget>[
            MapPage(),
            CharacterPage(),
            QuestPage(),
          ],
        ),

        floatingActionButton: FloatingActionButton(
            onPressed: () =>
            {
              showDialog(
                  context: context,
                  builder: (BuildContext context) =>
                      TutorialPopup(
                        title: "Anmeldung",
                        desc: "Wähle die Rolle für das Erlebnis aus. Admin erstellt eine neues Spiel. Spieler können bestehenden Spielen beitreten.",
                        okFun: () => {print("it's working :)")},

                      )
              )
            },
            tooltip: 'Increment',
          child: Icon(Icons.add),
        ), // This trailing comma makes auto-formatting nicer for build methods.
      ),
    );
  }

}

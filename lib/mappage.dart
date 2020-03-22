import 'package:flutter/material.dart';
import 'package:flare_flutter/flare_actor.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'questdetailpage.dart';

class MapPage extends StatelessWidget {
  final double imageHeight = 300;
  final double imageWidth = 370;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
        builder: (context, constraints) =>
            Stack(fit: StackFit.expand, children: <Widget>[
              Positioned(
                top: 0,
                left: 0,
                width: constraints.maxWidth,
                height: constraints.maxHeight,
                child: Container(color: Color.fromRGBO(207, 234, 255, 1)),
              ),
              Positioned(
                top: 0,
                left: 0,
                child: Container(
                  width: constraints.maxWidth,
                  height: constraints.maxHeight / 2,
                  child: FlareActor(
                    'assets/House1.flr',
                    alignment: Alignment.topCenter,
                    fit: BoxFit.fitWidth,
                    animation: "Idle",
                  ),
                ),
              ),
              Positioned(top: 200, left: 75, child: createCircle(50, 50, "1")),
              Positioned(top: 205, left: 225, child: createCircle(50, 50, "2")),
              Positioned(
                top: constraints.maxHeight / 2 + 10,
                left: 0,
                height: constraints.maxHeight / 2,
                width: constraints.maxWidth,
                child: createQuestList(),
              )
            ]));
  }

  Widget createCircle(double xSize, double ySize, String id) {
    return Padding(
        padding: const EdgeInsets.all(10.0),

      child:RawMaterialButton(
        onPressed: () {

          //TODO::anfrage an server und ListView neu zeichnen!

        },
        child: Text(id),
        shape: new CircleBorder(),
        elevation: 1.0,
        fillColor: Colors.transparent,
      ),
    );
  }

  Widget createQuestList() {
    return Column(children: [
      StreamBuilder(
        stream: Firestore.instance
            .collection('quests')
            .where("game", isEqualTo: "game1")
            .where("room", isEqualTo: "bedroom")
            .snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) return new Text("Error: ${snapshot.error}");
          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
              return new Text("Loading...");
            default:
              return new Expanded(
                child: ListView(
                  children:
                  snapshot.data.documents.map((DocumentSnapshot document) {
                    return new Card(
                      child: ListTile(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => QuestDetailPage(
                                  quest: document,
                                )),
                          );
                        },
                        leading: Container(
                          width: 50,
                          height: 50,
                          child: FlareActor(
                            'assets/${document['icon']}.flr',
                            alignment: Alignment.centerLeft,
                            // fit: BoxFit.contain,
                          ),
                        ),
                        title: Container(child: Text(document['title'])),
                        subtitle: Text(document['subtitle']),
                        trailing: Text(
                          "${document['experience']} XP",
                          style:
                          TextStyle(fontSize: 30, color: Colors.lightBlue),
                        ),
                      ),
                    );
                  }).toList(),
                ),
              );
          }
        },
      ),
    ]);
  }
}

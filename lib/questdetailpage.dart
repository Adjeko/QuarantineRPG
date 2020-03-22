import 'package:flutter/material.dart';
import 'package:flare_flutter/flare_actor.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'rewarddialog.dart';

class QuestDetailPage extends StatelessWidget {
  DocumentSnapshot quest;

  QuestDetailPage({Key key, @required this.quest}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    final double imageX = 0.3 * size.width;

    final double imageY = 0.2 * size.height;
    final double yPadding = 0.0005 * size.height;

    final double xPadding = 0.0005 * size.width;

    final double yTitleText = 0.05 * size.height;

    final double yXp = 0.05 * size.height;

    final double yDesc = 0.2 * size.height;

    final double yReward = 0.3 * size.height;

    return Scaffold(
      appBar: AppBar(
        title: Text(quest['title']),
      ),
      body: LayoutBuilder(
          builder: (context, constraints) => Stack(
                children: <Widget>[
                  Positioned(
                    top: 0,
                    left: 0,
                    width: constraints.maxWidth,
                    height: constraints.maxHeight,
                    child: Container(color: Color.fromRGBO(207, 234, 255, 1)),
                  ),

                  //TODO: layering ist noch ned gut
                  Positioned(
                      top: yPadding,
                      left: (constraints.maxWidth - imageX) / 2 - xPadding,
                      height: imageY,
                      child: Container(
                        width: imageX,
                        height: imageY,
                        child: FlareActor(
                          'assets/${quest['icon']}.flr',
                          alignment: Alignment.center,
                          // fit: BoxFit.contain,
                        ),
                      )),

                  Positioned(
                    top: imageY,
                    width: constraints.maxWidth - xPadding,
                    height: yTitleText,
                    child: Center(
                        child: Text(quest['title'],
                            textAlign: TextAlign.center,
                            style: TextStyle(fontSize: 30))),
                  ),

                  //TODO: wieso hier keine Position??
                  Positioned(
                    top: yTitleText + imageY,
                    height: yDesc,
                    width: constraints.maxWidth - xPadding,
                    child: Center(
                      child: Text(quest['description'],
                          style: TextStyle(
                              fontSize: 20, fontStyle: FontStyle.italic)),
                    ),
                  ),

                  Positioned(
                    top: yTitleText + imageY + yDesc,
                    height: yXp,
                    width: constraints.maxWidth - xPadding,
                    child: Center(
                        child: Text(
                      "${quest['experience']} XP",
                      style: TextStyle(fontSize: 30, color: Colors.lightBlue),
                    )),
                  ),

                  Positioned(
                      top: imageY + yDesc + yXp + yTitleText + yPadding,
                      width: constraints.maxWidth - xPadding,
                      height: yReward,
                      child: Column(
                        children: <Widget>[
                          Align(
                            alignment: Alignment.center,
                            child: Text("Belohnungen",
                                style: TextStyle(fontSize: 25)),
                          ),
                          ListView.builder(
                              shrinkWrap: true,
                              itemCount: quest['realRewards'].length,
                              itemBuilder: (context, index) {
                                return StreamBuilder(
                                    stream: Firestore.instance
                                        .collection('realrewards')
                                        .where("name",
                                            isEqualTo: quest['realRewards']
                                                [index])
                                        .snapshots(),
                                    builder: (BuildContext context,
                                        AsyncSnapshot<QuerySnapshot> snapshot) {
                                      if (snapshot.hasError)
                                        return new Text(
                                            "Error: ${snapshot.error}");
                                      switch (snapshot.connectionState) {
                                        case ConnectionState.waiting:
                                          return new Text("Loading...");
                                        default:
                                          return createListItem(snapshot.data.documents[0]['description']);
                                      }
                                    });
                              }),
                          ListView.builder(
                              shrinkWrap: true,
                              itemCount: quest['digitalItems'].length,
                              itemBuilder: (context, index) {
                                return StreamBuilder(
                                    stream: Firestore.instance
                                        .collection('digitalitems')
                                        .where("name",
                                            isEqualTo: quest['digitalItems']
                                                [index])
                                        .snapshots(),
                                    builder: (BuildContext context,
                                        AsyncSnapshot<QuerySnapshot> snapshot) {
                                      if (snapshot.hasError)
                                        return new Text(
                                            "Error: ${snapshot.error}");
                                      switch (snapshot.connectionState) {
                                        case ConnectionState.waiting:
                                          return new Text("Loading...");
                                        default:
                                          return createListItem(snapshot.data.documents[0]['icon']);
                                      }
                                    });
                              }),
                        ],
                      ))
                ],
              )),
      floatingActionButton: SpeedDial(
        animatedIcon: AnimatedIcons.add_event,
        children: [
          SpeedDialChild(
            child: Icon(Icons.add),
            label: "Reale Belohnung hinzufügen",
            onTap: () {
              showDialog(
                context: context,
                builder: (BuildContext context) => RewardDialog(
                  title: "Belohnungen",
                  description: "Suche eine Belohnung aus",
                  collection: "realrewards",
                  field: "description",
                  questArray: "realRewards",
                  questName: quest['name'],
                ),
              );
            },
          ),
          SpeedDialChild(
            child: Icon(Icons.add),
            label: "Digitale Belohnung hinzufügen",
            onTap: () {
              showDialog(
                context: context,
                builder: (BuildContext context) => RewardDialog(
                  title: "Belohnungen",
                  description: "Suche eine Belohnung aus",
                  collection: "digitalitems",
                  field: "icon",
                  questArray: "digitalItems",
                  questName: quest['name'],
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget createListItem(String text) {
    return new Card(
        elevation: 8.0,
        margin: new EdgeInsets.symmetric(
            horizontal: 10.0,
            vertical: 6.0),
        child: Container(
          decoration: BoxDecoration(
            color: Color.fromRGBO(21, 154, 149, 0.9)),
          child: ListTile(
            title: Text(
              text,
              style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
            ),
          ),
        ));
  }
}

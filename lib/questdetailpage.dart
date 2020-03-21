import 'package:flutter/material.dart';
import 'package:flare_flutter/flare_actor.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class QuestDetailPage extends StatelessWidget {

  DocumentSnapshot quest;

  QuestDetailPage({Key key, @required this.quest}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return 
    Scaffold(
      appBar: AppBar(
        title: Text(quest['title']),
      ),
      body: Column(
        children: [
          Container(
            width: 200,
            height: 200,
            child: FlareActor(
              'assets/${quest['icon']}.flr',
              alignment: Alignment.center,
              // fit: BoxFit.contain,
            ),
          ),
          Center(
            child: Text(quest['title']),
          ),
          Center(
            child: Text(quest['description']),
          ),
          FutureBuilder(
            future: quest['reward'].get(),
            builder: (context, rewardsSnap) {
              if(rewardsSnap.connectionState == ConnectionState.done) {
                if(rewardsSnap.hasData){
                  return Center(
                        child: Text("Erfahrung: ${rewardsSnap.data['experience']}"),
                      );
                } else {
                  return Text("keine String");
                } 
              } else {
                return CircularProgressIndicator();
              }
            }
          ),
          Center(
            child: Text("Reale Belohnungen"),
          ),
          FutureBuilder(
            future: quest['reward'].get(),
            builder: (context, rewardsSnap) {
              if(rewardsSnap.connectionState == ConnectionState.done) {
                if(rewardsSnap.hasData){
                  return ListView.builder(
                    shrinkWrap: true,
                    itemCount: rewardsSnap.data['realItems'].length,
                    itemBuilder: (context, index) {
                      return Text(rewardsSnap.data['realItems'][index]);
                    }
                  );
                } else {
                  return Text("keine String");
                } 
              } else {
                return CircularProgressIndicator();
              }
            }
          ),
          Center(
            child: Text("Digitale Belohnungen"),
          ),
          FutureBuilder(
            future: quest['reward'].get(),
            builder: (context, rewardsSnap) {
              if(rewardsSnap.connectionState == ConnectionState.done) {
                if(rewardsSnap.hasData){
                  return ListView.builder(
                    shrinkWrap: true,
                    itemCount: rewardsSnap.data['digitalItems'].length,
                    itemBuilder: (context, index) {
                      return FutureBuilder(
                        future: rewardsSnap.data['digitalItems'][0].get(),
                        builder: (context, digitalItemsSnap) {
                          if(digitalItemsSnap.connectionState == ConnectionState.done) {
                            if(digitalItemsSnap.hasData){
                              return Text(digitalItemsSnap.data['icon'].toString());
                            } else {
                              return Text("Item has no data");
                            }
                          } else {
                            return CircularProgressIndicator();
                          }
                        }
                      );
                    },
                  );
                } else {
                  return Text("keine String");
                } 
              } else {
                return CircularProgressIndicator();
              }
            }
          ),
        ],
      ),
    );
  }
}
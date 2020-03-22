import 'package:cloud_firestore/cloud_firestore.dart';

class GameModel {
  final String id;
  final String sessionId; // wird beim "Load" angegeben!
  final String flrID; // 1 == House1.flr, 2 == House2.flr, etc.
  final List rooms;

  GameModel({ this.id, this.sessionId, this.flrID, this.rooms,});

  factory GameModel.fromFirebase(DocumentSnapshot doc) {
    Map data = doc.data;

    return GameModel(
      //TODO: id stimmen?
        id: doc.documentID,
        sessionId: data['name'] ?? '',
    );
  }

}
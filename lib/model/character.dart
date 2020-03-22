import 'package:cloud_firestore/cloud_firestore.dart';

class CharacterModel {
  final String id;
  final String name;
  final int xp;
  final List inventory;

  CharacterModel({ this.id, this.name, this.xp, this.inventory});

  factory CharacterModel.fromFirebase(DocumentSnapshot doc) {
    Map data = doc.data;

    return CharacterModel(
      //TODO: id stimmen?
      id: doc.documentID,
    );
  }

}
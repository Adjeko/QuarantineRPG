import 'package:cloud_firestore/cloud_firestore.dart';

class RoomModel {
  final String id;
  final String name;
  final Category categoryID;
  final List quests;

  RoomModel({ this.id, this.name, this.categoryID, this.quests});

  factory RoomModel.fromFirebase(DocumentSnapshot doc) {
    Map data = doc.data;

    return RoomModel(
      //TODO: id stimmen?
        id: doc.documentID,
        name: data['name'] ?? '',
        categoryID: data['img'] ?? ''
    );
  }

}

enum Category {
  wohnzimmer,
  kueche,
  schlafzimmer
}
import 'package:cloud_firestore/cloud_firestore.dart';

class QuestModel {
  final String id;
  final String name;
  final String desc;
  final int xp;
  final List rewards;
  final String img;

  QuestModel({ this.id, this.name, this.desc, this.xp, this.rewards, this.img});

  factory QuestModel.fromFirebase(DocumentSnapshot doc) {
    Map data = doc.data;

    return QuestModel(
      //TODO: id stimmen?
        id: doc.documentID,
        name: data['name'] ?? '',
        img: data['img'] ?? ''
    );
  }

}
import 'package:cloud_firestore/cloud_firestore.dart';

class RewardItemModel {
  final String id;
  final String name;
  final String img;

  RewardItemModel({ this.id, this.name, this.img});

  factory RewardItemModel.fromFirebase(DocumentSnapshot doc) {
    Map data = doc.data;

    return RewardItemModel(
      //TODO: id stimmen?
        id: doc.documentID,
        name: data['name'] ?? '',
        img: data['img'] ?? ''
    );
  }

}
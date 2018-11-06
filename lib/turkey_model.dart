import 'package:cloud_firestore/cloud_firestore.dart';

class TurkeyModel {
  TurkeyModel.fromSnapshot(this.snapshot)
      : id = snapshot.documentID,
        name = snapshot['name'],
        count = snapshot['count'],
        text = snapshot['text'],
        images = snapshot['images'].cast<String>();

  final String id;
  final String name;
  final int count;
  final String text;
  final List<String> images;
  final DocumentSnapshot snapshot;
}

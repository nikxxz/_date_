import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'models/user.dart';

class GetInfo {
  final String userId;

  GetInfo({this.userId});

  final CollectionReference users =
      FirebaseFirestore.instance.collection('users');

  final firebase_storage.FirebaseStorage storage =
      firebase_storage.FirebaseStorage.instance;

  Future get_info(field) {
    users.doc(userId).get().then((DocumentSnapshot documentSnapshot) {
      if (documentSnapshot.exists) {
        return documentSnapshot[field];
      } else {
        return null;
      }
    });
  }
}

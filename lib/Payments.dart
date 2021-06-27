import 'package:cloud_firestore/cloud_firestore.dart';

class Payments {
  final userId;

  Payments({this.userId});

  final CollectionReference users =
      FirebaseFirestore.instance.collection('users');

  Future updatePaymentInfo(DateTime expiry) async {
    Timestamp expiryDate;
    expiryDate = Timestamp.fromDate(expiry);
    return await users.doc(userId).update({'expiryDate': expiryDate});
  }

  Future fetchUserData(field) async {
    await FirebaseFirestore.instance
        .collection('users')
        .doc(userId)
        .get()
        .then((DocumentSnapshot documentSnapshot) {
      if (documentSnapshot.exists) {
        return documentSnapshot[field];
      } else {
        return null;
      }
    });
  }

  Future ExpiryDate() async {
    DateTime expiry;
    await FirebaseFirestore.instance
        .collection('users')
        .doc(userId)
        .get()
        .then((DocumentSnapshot documentSnapshot) {
      if (documentSnapshot.exists) {
        expiry = documentSnapshot['expiryDate'].toDate();
        return expiry;
      } else {
        return null;
      }
    });
  }
}

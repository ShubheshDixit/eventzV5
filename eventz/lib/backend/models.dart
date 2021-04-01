import 'package:cloud_firestore/cloud_firestore.dart';

class MyUser {
  final String displayName, email, phoneNumber, uid;
  MyUser({this.displayName, this.email, this.phoneNumber, this.uid});

  factory MyUser.fromDoc(DocumentSnapshot doc) {
    return MyUser(
      displayName: doc.get('displayName'),
      email: doc.get('email'),
      phoneNumber: doc.get('phoneNumber'),
      uid: doc.get('uid'),
    );
  }

  toJson() {
    return {
      'displayName': displayName,
      'email': email,
      'phoneNumber': phoneNumber,
      'uid': uid
    };
  }
}

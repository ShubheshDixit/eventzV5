import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirebaseUtil {
  FirebaseUtil._();
  factory FirebaseUtil() => _instance;
  static final FirebaseUtil _instance = FirebaseUtil._();

  Future<void> addUserToFirebase(User user) async {
    DocumentSnapshot doc = await FirebaseFirestore.instance
        .collection('users')
        .doc(user.uid)
        .get();
    if (!doc.exists) {
      doc.reference.set({
        'displayName': user.displayName,
        'email': user.email,
        'uid': user.uid,
        'phoneNumber': user.phoneNumber,
      });
    }
  }
}

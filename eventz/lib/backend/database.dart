import 'dart:io';
import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

FirebaseAuth auth = FirebaseAuth.instance;
CollectionReference usersRef = FirebaseFirestore.instance.collection('users');
CollectionReference schRef = FirebaseFirestore.instance.collection('schedules');

class AuthService {
  AuthService._();
  factory AuthService() => _instance;
  static final AuthService _instance = AuthService._();
  FirebaseAuth auth = FirebaseAuth.instance;
  Future<User> signInEmail(
      {@required String email, @required String password}) async {
    UserCredential userCredential =
        await auth.signInWithEmailAndPassword(email: email, password: password);
    return userCredential.user;
  }

  Future<void> signInMobile(
      {@required String number,
      @required void Function(FirebaseAuthException) onVerificationFailed,
      @required void Function(String, int) onCodeSent,
      @required void Function(String) codeAutoRetrievalTimeout,
      @required void Function(PhoneAuthCredential) verificationCompleted,
      int forceResendingToken,
      Duration timeout}) async {
    await auth.verifyPhoneNumber(
        phoneNumber: number,
        timeout: timeout ?? Duration(seconds: 30),
        verificationCompleted: verificationCompleted,
        verificationFailed: onVerificationFailed,
        codeSent: onCodeSent,
        forceResendingToken: forceResendingToken,
        codeAutoRetrievalTimeout: codeAutoRetrievalTimeout);
  }

  Future<User> signUpUser(
      {@required String email,
      @required String password,
      @required String name}) async {
    UserCredential cred = await auth.createUserWithEmailAndPassword(
        email: email, password: password);
    await cred.user.updateDisplayName(name);
    await cred.user.sendEmailVerification();
    await cred.user.reload();
    return cred.user;
  }

  Future<void> sendResetEmail({@required email}) async {
    await auth.sendPasswordResetEmail(email: email);
  }

  Future<void> logout({isGoogle = false}) async {
    await auth.signOut();
  }
}

class DatabaseService {
  DatabaseService._();
  Future<String> uploadToFirebase(String path,
      {File file, Uint8List data}) async {
    final filePath = '$path'; //path to save Storage
    try {
      var uploadTask = file != null
          ? await FirebaseStorage.instance.ref(filePath).putFile(file)
          : await FirebaseStorage.instance.ref(filePath).putData(data);
      var url = await uploadTask.ref.getDownloadURL();
      return url;
    } catch (e) {
      print('error:$e');
      return null;
    }
  }

  Future<void> setDocument(String path, Map<String, dynamic> data) async {
    await FirebaseFirestore.instance.doc(path).set(data);
  }

  Future<void> addToCollection(String path, Map<String, dynamic> data) async {
    await FirebaseFirestore.instance.collection(path).add(data);
  }
}

String generateRandomRoomId() {
  var id = Uuid().v4().replaceAll('-', '').substring(0, 10);
  return id;
}

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';
import 'package:sharedoc/core/entity/Users.dart';

class UserServices with ChangeNotifier {
  final FirebaseAuth _firebaseAuth;

  Stream<User?> get authStreamChanges => _firebaseAuth.authStateChanges();

  UserServices(this._firebaseAuth);

  CollectionReference users = FirebaseFirestore.instance.collection('users');

  Future<String?> signIn(
      {required String email, required String password}) async {
    try {
      await _firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
    } on FirebaseAuthException catch (e) {
      return e.message;
    }
    return null;
  }

  Future<String?> signUp(Users user) async {
    try {
      await _firebaseAuth.createUserWithEmailAndPassword(
          email: user.email, password: user.password);
      users.add({
        'uid': _firebaseAuth.currentUser!.uid,
        'nama_depan': user.nama_depan,
        'nama_belakang': user.nama_belakang,
        'email': user.email,
        'nomor_telpon': user.notelp,
        'password': user.password,
        'role': user.role
      });
    } on FirebaseAuthException catch (e) {
      return e.message;
    }
    return null;
  }
}

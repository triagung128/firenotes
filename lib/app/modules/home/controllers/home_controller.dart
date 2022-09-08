import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  final _auth = FirebaseAuth.instance;
  final _firestore = FirebaseFirestore.instance;

  Stream<QuerySnapshot<Map<String, dynamic>>> streamNotes() async* {
    final uid = _auth.currentUser?.uid;

    yield* _firestore
        .collection('users')
        .doc(uid)
        .collection('notes')
        .orderBy(
          'created_at',
          descending: true,
        )
        .snapshots();
  }

  Stream<DocumentSnapshot<Map<String, dynamic>>> streamProfile() async* {
    final uid = _auth.currentUser?.uid;
    yield* _firestore.collection('users').doc(uid).snapshots();
  }

  void deleteNote(String docId) async {
    try {
      final uid = _auth.currentUser?.uid;
      await _firestore
          .collection('users')
          .doc(uid)
          .collection('notes')
          .doc(docId)
          .delete();
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
      Get.snackbar('Terjadi Kesalahan', 'Gagal menghapus data');
    }
  }
}

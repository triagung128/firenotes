import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
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

  void deleteNote(String docId) {
    try {
      final uid = _auth.currentUser?.uid;
      Get.defaultDialog(
        title: 'Delete Note',
        titlePadding: const EdgeInsets.all(16),
        content: const Padding(
          padding: EdgeInsets.all(16),
          child: Text('Are you sure you want to delete?'),
        ),
        actions: [
          OutlinedButton(
            onPressed: () async {
              Get.back();
              await _firestore
                  .collection('users')
                  .doc(uid)
                  .collection('notes')
                  .doc(docId)
                  .delete();
            },
            child: const Text('Yes'),
          ),
          OutlinedButton(
            onPressed: () => Get.back(),
            child: const Text('Cancel'),
          ),
        ],
      );
    } catch (e) {
      debugPrint(e.toString());
      Get.snackbar('Error', 'Failed to delete data!');
    }
  }
}

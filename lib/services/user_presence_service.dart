import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';

class UserPresenceService {
  static void setupUserPresence() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) return;

    final firestoreRef = FirebaseFirestore.instance.collection('users').doc(user.uid);
    final rtdbRef = FirebaseDatabase.instance.ref("status/${user.uid}");

    final isOfflineForFirestore = {
      "online": false,
      "last_changed": FieldValue.serverTimestamp(),
    };

    final isOnlineForFirestore = {
      "online": true,
      "last_changed": FieldValue.serverTimestamp(),
    };

    final connectedRef = FirebaseDatabase.instance.ref(".info/connected");

    connectedRef.onValue.listen((event) {
      final connected = event.snapshot.value as bool? ?? false;

      if (connected) {
        rtdbRef.onDisconnect().set({
          "state": "offline",
          "last_changed": ServerValue.timestamp,
        }).then((_) {
          rtdbRef.set({
            "state": "online",
            "last_changed": ServerValue.timestamp,
          });
          firestoreRef.update(isOnlineForFirestore);
        });
      } else {
        firestoreRef.update(isOfflineForFirestore);
      }
    });
  }
}

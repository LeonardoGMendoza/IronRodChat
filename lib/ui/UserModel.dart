import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  final String uid;
  final String email;
  final DateTime joinedAt;
  final List<String> organizationIds;
  final List<String> spiritualGifts;
  final List<dynamic> callings;

  UserModel({
    required this.uid,
    required this.email,
    required this.joinedAt,
    required this.organizationIds,
    required this.spiritualGifts,
    required this.callings,
  });

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      uid: map['uid'],
      email: map['email'],
      joinedAt: (map['joinedAt'] as Timestamp).toDate(),
      organizationIds: List<String>.from(map['organizationIds'] ?? []),
      spiritualGifts: List<String>.from(map['spiritualGifts'] ?? []),
      callings: List<dynamic>.from(map['callins'] ?? []),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'email': email,
      'joinedAt': Timestamp.fromDate(joinedAt),
      'organizationIds': organizationIds,
      'spiritualGifts': spiritualGifts,
      'callins': callings,
    };
  }
}

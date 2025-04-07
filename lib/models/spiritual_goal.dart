import 'package:cloud_firestore/cloud_firestore.dart';

class SpiritualGoal {
  final String id;
  final String description;
  final String frequency;
  final int progress;
  final DateTime lastUpdated;

  SpiritualGoal({
  required this.id,
  required this.description,
  required this.frequency,
  required this.progress,
  required this.lastUpdated,
  });

  factory SpiritualGoal.fromMap(Map<String, dynamic> map, String documentId) {
  return SpiritualGoal(
  id: documentId,
  description: map['description'] ?? '',
  frequency: map['frequency'] ?? '',
  progress: map['progress'] ?? 0,
  lastUpdated: (map['lastUpdated'] as Timestamp?)?.toDate() ?? DateTime.now(),
  );
  }

  Map<String, dynamic> toMap() {
  return {
  'description': description,
  'frequency': frequency,
  'progress': progress,
  'lastUpdated': lastUpdated,
  };
  }
  }


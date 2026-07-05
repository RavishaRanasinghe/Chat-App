import 'package:cloud_firestore/cloud_firestore.dart';

/// Represents a single chat message stored in Firestore.
class Message {
  final String id;
  final String senderId;
  final String senderName;
  final String text;
  final Timestamp? timestamp;

  Message({
    required this.id,
    required this.senderId,
    required this.senderName,
    required this.text,
    required this.timestamp,
  });

  /// Build a Message from a Firestore document snapshot.
  factory Message.fromDoc(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return Message(
      id: doc.id,
      senderId: data['senderId'] ?? '',
      senderName: data['senderName'] ?? 'Unknown',
      text: data['text'] ?? '',
      timestamp: data['timestamp'] as Timestamp?,
    );
  }

  /// Convert this Message into a map for writing to Firestore.
  Map<String, dynamic> toMap() {
    return {
      'senderId': senderId,
      'senderName': senderName,
      'text': text,
      'timestamp': FieldValue.serverTimestamp(),
    };
  }
}

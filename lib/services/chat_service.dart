import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/message.dart';

/// Handles all Firestore interactions for the chat feature.
///
/// This is where the "real-time" part happens: messagesStream() returns
/// a Stream that Firestore pushes new data into automatically whenever
/// the "messages" collection changes, no manual refreshing needed.
class ChatService {
  final CollectionReference _messagesRef =
      FirebaseFirestore.instance.collection('messages');

  /// Returns a live stream of messages ordered oldest -> newest.
  Stream<List<Message>> messagesStream() {
    return _messagesRef
        .orderBy('timestamp', descending: false)
        .snapshots()
        .map((snapshot) =>
            snapshot.docs.map((doc) => Message.fromDoc(doc)).toList());
  }

  /// Sends a new message to Firestore.
  Future<void> sendMessage({
    required String senderId,
    required String senderName,
    required String text,
  }) async {
    if (text.trim().isEmpty) return;

    final message = Message(
      id: '', // Firestore will auto-generate the doc ID
      senderId: senderId,
      senderName: senderName,
      text: text.trim(),
      timestamp: null, // set server-side
    );

    await _messagesRef.add(message.toMap());
  }
}

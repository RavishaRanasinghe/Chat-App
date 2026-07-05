import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/message.dart';

/// Displays a single chat bubble, styled differently depending on whether
/// the current user sent it or someone else did.
class MessageBubble extends StatelessWidget {
  final Message message;
  final bool isMe;

  const MessageBubble({
    super.key,
    required this.message,
    required this.isMe,
  });

  String _formatTime() {
    final ts = message.timestamp;
    if (ts == null) return '...'; // still pending server timestamp
    return DateFormat('h:mm a').format(ts.toDate());
  }

  @override
  Widget build(BuildContext context) {
    final bubbleColor = isMe
        ? Theme.of(context).colorScheme.primary
        : Theme.of(context).colorScheme.surfaceContainerHighest;
    final textColor = isMe
        ? Theme.of(context).colorScheme.onPrimary
        : Theme.of(context).colorScheme.onSurface;

    return Align(
      alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
        constraints: BoxConstraints(
          maxWidth: MediaQuery.of(context).size.width * 0.75,
        ),
        decoration: BoxDecoration(
          color: bubbleColor,
          borderRadius: BorderRadius.only(
            topLeft: const Radius.circular(14),
            topRight: const Radius.circular(14),
            bottomLeft: Radius.circular(isMe ? 14 : 2),
            bottomRight: Radius.circular(isMe ? 2 : 14),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (!isMe)
              Text(
                message.senderName,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 12,
                  color: textColor.withOpacity(0.7),
                ),
              ),
            Text(message.text, style: TextStyle(color: textColor, fontSize: 15)),
            const SizedBox(height: 2),
            Text(
              _formatTime(),
              style: TextStyle(color: textColor.withOpacity(0.6), fontSize: 10),
            ),
          ],
        ),
      ),
    );
  }
}

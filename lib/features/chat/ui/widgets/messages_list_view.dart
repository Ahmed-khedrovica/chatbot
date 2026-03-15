import 'package:flutter/material.dart';

import '../../data/models/chat_message_model.dart';
import 'chat_message_bubble_widget.dart';

class MessagesListView extends StatelessWidget {
  const MessagesListView({super.key, required this.messages});
  final List<ChatMessageModel> messages;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      reverse: true,
      padding: const EdgeInsets.symmetric(vertical: 16),
      itemCount: messages.length,
      itemBuilder: (context, index) {
        var reversedMessages = messages.reversed.toList();
        final msg = reversedMessages[index];
        return ChatMessageBubbleWidget(
          text: msg.displayText,
          isUser: msg.isUser,
        );
      },
    );
  }
}

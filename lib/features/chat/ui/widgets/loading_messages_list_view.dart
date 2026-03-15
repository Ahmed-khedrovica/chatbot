import 'package:flutter/material.dart';

import '../../data/models/chat_message_model.dart';
import 'chat_message_bubble_widget.dart';
import 'loading_chat_message_bubble_widget.dart';

class LoadingMessagesListView extends StatelessWidget {
  const LoadingMessagesListView(this.messages, {super.key});
  final List<ChatMessageModel> messages;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      reverse: true,
      padding: const EdgeInsets.symmetric(vertical: 16),
      itemCount: messages.length + 1,
      itemBuilder: (context, index) {
        var newIndex = messages.length - (index + 0);
        if (index == 0) {
          return const LoadingChatMessageBubbleWidget();
        }
        final msg = messages[newIndex];
        return ChatMessageBubbleWidget(
          text: msg.displayText,
          isUser: msg.isUser,
        );
      },
    );
  }
}

import 'package:flutter_application_1/features/chat/data/models/chat_message_model.dart';

abstract class ChatRepo {
  Future<ChatMessageModel> sendMessage({
    required List<ChatMessageModel> messages,
  });
}

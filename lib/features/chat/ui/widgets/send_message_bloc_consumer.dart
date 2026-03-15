import 'package:flutter/material.dart';
import 'package:flutter_application_1/features/chat/ui/cubits/chat_cubit/chat_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/models/chat_message_model.dart';
import 'failure_messages_list_view.dart';
import 'loading_messages_list_view.dart';
import 'messages_list_view.dart';

class SendMessageBlocConsumer extends StatelessWidget {
  const SendMessageBlocConsumer({
    super.key,
    required List<ChatMessageModel> sampleMessages,
  }) : _sampleMessages = sampleMessages;

  final List<ChatMessageModel> _sampleMessages;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SendMessageCubit, SendMessageState>(
      listener: (context, state) {
        if (state is SendMessageSuccess) {
          _sampleMessages.add(state.chatMessageModel);
        }
      },
      builder: (context, state) {
        if (state is SendMessageSuccess) {
          return MessagesListView(messages: _sampleMessages);
        } else if (state is SendMessageFailure) {
          return FailureMessagesListView(_sampleMessages);
        } else if (state is SendMessageLoading) {
          return LoadingMessagesListView(_sampleMessages);
        }
        return const SizedBox.shrink();
      },
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_application_1/features/chat/data/repos/gemenai_chat_repo_impl.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/di/dependancy_injection.dart';
import '../../data/models/chat_message_model.dart';
import '../../data/services/gemenai_chat_service.dart';
import '../cubits/chat_cubit/chat_cubit.dart';
import '../widgets/chat_app_bar_widget.dart';
import '../widgets/chat_input_bar_widget.dart';
import '../widgets/send_message_bloc_consumer.dart';

class ChatScreenWidget extends StatefulWidget {
  const ChatScreenWidget({super.key});

  @override
  State<ChatScreenWidget> createState() => _ChatScreenWidgetState();
}

class _ChatScreenWidgetState extends State<ChatScreenWidget> {
  late final TextEditingController _controller;

  final List<ChatMessageModel> _sampleMessages = [];

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<SendMessageCubit>(),
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: const ChatAppBarWidget(),
        body: Column(
          children: [
            Expanded(
              child: SendMessageBlocConsumer(sampleMessages: _sampleMessages),
            ),
            ChatInputBarWidget(
              controller: _controller,
              onSendPressed: () {},
              messages: _sampleMessages,
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_application_1/features/chat/data/models/chat_message_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubits/chat_cubit/chat_cubit.dart';

class ChatInputBarWidget extends StatelessWidget {
  const ChatInputBarWidget({
    super.key,
    required this.controller,
    required this.onSendPressed,
    this.onMicPressed,
    this.enabled = true,
    required this.messages,
  });

  final TextEditingController controller;
  final VoidCallback onSendPressed;
  final VoidCallback? onMicPressed;
  final bool enabled;
  final List<ChatMessageModel> messages;

  static const Color _primaryBlue = Color(0xFF2196F3);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        left: 16,
        right: 16,
        top: 12,
        bottom: 12 + MediaQuery.of(context).padding.bottom,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.06),
            blurRadius: 8,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: SafeArea(
        top: false,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Expanded(
              child: Container(
                constraints: const BoxConstraints(minHeight: 48),
                decoration: BoxDecoration(
                  color: const Color(0xFFF5F5F5),
                  borderRadius: BorderRadius.circular(24),
                ),
                child: TextField(
                  controller: controller,
                  enabled: enabled,
                  maxLines: 4,
                  minLines: 1,
                  textCapitalization: TextCapitalization.sentences,
                  decoration: InputDecoration(
                    hintText: 'Write your message',
                    hintStyle: TextStyle(
                      color: Colors.grey.shade500,
                      fontSize: 15,
                    ),
                    border: InputBorder.none,
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 14,
                    ),
                    suffixIcon: IconButton(
                      onPressed: onMicPressed,
                      icon: Icon(
                        Icons.mic_none_outlined,
                        color: Colors.grey.shade600,
                        size: 22,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(width: 12),
            Material(
              color: _primaryBlue,
              shape: const CircleBorder(),
              child: InkWell(
                onTap: () {
                  if (enabled && controller.text.isNotEmpty) {
                    var sendMessageCubit = context.read<SendMessageCubit>();
                    var message = ChatMessageModel.fromUserMessage(
                      controller.text,
                    );
                    if (sendMessageCubit.state is SendMessageFailure) {
                      messages.removeLast();
                    }
                    messages.add(message);
                    context.read<SendMessageCubit>().sendMessage(
                      messages: messages,
                    );
                    controller.clear();
                  }
                },
                customBorder: const CircleBorder(),
                child: const SizedBox(
                  width: 48,
                  height: 48,
                  child: Icon(
                    Icons.send_rounded,
                    color: Colors.white,
                    size: 24,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

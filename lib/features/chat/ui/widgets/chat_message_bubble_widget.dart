import 'package:flutter/material.dart';

/// Chat message bubble matching the Figma design.
/// User messages: blue, right-aligned. Bot messages: grey, left-aligned with avatar.
class ChatMessageBubbleWidget extends StatelessWidget {
  const ChatMessageBubbleWidget({
    super.key,
    required this.text,
    required this.isUser,
  });

  final String text;
  final bool isUser;

  static const Color _userBubbleColor = Color(0xFF2196F3);
  static const Color _botBubbleColor = Color(0xFFEEEEEE);
  static const Color _botTextColor = Color(0xFF424242);

  @override
  Widget build(BuildContext context) {
    if (text.isEmpty) return const SizedBox.shrink();

    if (isUser) {
      return Align(
        alignment: Alignment.centerRight,
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          decoration: BoxDecoration(
            color: _userBubbleColor,
            borderRadius: BorderRadius.circular(18),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.05),
                blurRadius: 4,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          constraints: BoxConstraints(
            maxWidth: MediaQuery.of(context).size.width * 0.75,
          ),
          child: Text(
            text,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 15,
              height: 1.4,
            ),
          ),
        ),
      );
    }

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 36,
            height: 36,
            decoration: BoxDecoration(
              color: _userBubbleColor,
              borderRadius: BorderRadius.circular(10),
            ),
            child: const Icon(
              Icons.smart_toy_outlined,
              color: Colors.white,
              size: 20,
            ),
          ),
          const SizedBox(width: 10),
          Flexible(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              decoration: BoxDecoration(
                color: _botBubbleColor,
                borderRadius: BorderRadius.circular(18),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.04),
                    blurRadius: 4,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Text(
                text,
                style: const TextStyle(
                  color: _botTextColor,
                  fontSize: 15,
                  height: 1.4,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

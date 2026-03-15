import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class ChatFailure extends StatelessWidget {
  const ChatFailure({
    super.key,
    required this.message,
    required this.lastSentMessage,
    this.onResend,
  });

  final String message;
  final String lastSentMessage;
  final VoidCallback? onResend;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'You: "$lastSentMessage"',
            style: const TextStyle(
              color: Colors.black,
              fontStyle: FontStyle.italic,
            ),
          ),
          const SizedBox(height: 8),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Icon(
                Icons.error_outline,
                color: Colors.red,
                size: 16,
              ),
              const SizedBox(width: 8),
              Expanded(
                child: RichText(
                  text: TextSpan(
                    style: DefaultTextStyle.of(context).style,
                    children: <TextSpan>[
                      TextSpan(
                        text: 'Error: $message ',
                        style: const TextStyle(color: Colors.red),
                      ),
                      if (onResend != null)
                        TextSpan(
                          text: 'Resend',
                          style: const TextStyle(
                            color: Colors.blue,
                            fontWeight: FontWeight.bold,
                            decoration: TextDecoration.underline,
                          ),
                          recognizer: TapGestureRecognizer()..onTap = onResend,
                        ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

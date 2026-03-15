import 'package:flutter/material.dart';

/// Error chat bubble with last sent user message and error message,
/// styled to look more like an error, and prominently features a resend option.
class FailureChatMessageBubbleWidget extends StatelessWidget {
  const FailureChatMessageBubbleWidget({
    super.key,
    required this.lastSentMessage,
    required this.errorMessage,
    this.onResend,
  });

  final String lastSentMessage;
  final String errorMessage;
  final VoidCallback? onResend;

  static const Color _bubbleColor = Color(0xFFFFEBEE); // Light error background
  static const Color _errorColor = Color(0xFFE53935); // Deep error red

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
        constraints: BoxConstraints(
          maxWidth: MediaQuery.of(context).size.width * 0.75,
        ),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          decoration: BoxDecoration(
            color: _bubbleColor,
            borderRadius: BorderRadius.circular(18),
            border: Border.all(color: _errorColor.withOpacity(0.9), width: 2),
            boxShadow: [
              BoxShadow(
                color: _errorColor.withOpacity(0.08),
                blurRadius: 6,
                offset: const Offset(0, 1),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(Icons.error_outline, size: 24, color: _errorColor),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      lastSentMessage,
                      style: const TextStyle(
                        color: Colors.black87,
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                        height: 1.4,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(width: 32),
                  Expanded(
                    child: Text(
                      errorMessage,
                      style: TextStyle(
                        color: _errorColor,
                        fontSize: 13,
                        fontWeight: FontWeight.bold,
                        height: 1.3,
                      ),
                    ),
                  ),
                ],
              ),
              if (onResend != null) ...[
                const SizedBox(height: 10),
                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton.icon(
                    onPressed: onResend,
                    style: TextButton.styleFrom(
                      foregroundColor: _errorColor,
                      backgroundColor: _errorColor.withOpacity(0.13),
                      minimumSize: const Size(20, 34),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 4,
                      ),
                      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      visualDensity: VisualDensity.compact,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                        side: BorderSide(color: _errorColor.withOpacity(0.3)),
                      ),
                    ),
                    icon: const Icon(Icons.refresh, size: 18),
                    label: const Text(
                      "Resend",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}

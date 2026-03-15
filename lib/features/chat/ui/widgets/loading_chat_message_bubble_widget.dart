import 'package:flutter/material.dart';

/// Animated loading chat message bubble for bot "typing" state.
/// Matches the bot bubble layout (avatar + bubble) with bouncing dots animation.
class LoadingChatMessageBubbleWidget extends StatefulWidget {
  const LoadingChatMessageBubbleWidget({super.key});

  @override
  State<LoadingChatMessageBubbleWidget> createState() =>
      _LoadingChatMessageBubbleWidgetState();
}

class _LoadingChatMessageBubbleWidgetState
    extends State<LoadingChatMessageBubbleWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late List<Animation<double>> _dotAnimations;

  static const Color _userBubbleColor = Color(0xFF2196F3);
  static const Color _botBubbleColor = Color(0xFFEEEEEE);
  static const Color _dotColor = Color(0xFF757575);

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    )..repeat();

    _dotAnimations = List.generate(
      3,
      (index) => Tween<double>(begin: 0.4, end: 1.0).animate(
        CurvedAnimation(
          parent: _controller,
          curve: Interval(
            0.2 * index,
            0.4 + 0.2 * index,
            curve: Curves.easeInOut,
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
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
            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                3,
                (index) => AnimatedBuilder(
                  animation: _controller,
                  builder: (context, child) {
                    return Padding(
                      padding: EdgeInsets.only(
                        left: index > 0 ? 6 : 0,
                      ),
                      child: Transform.scale(
                        scale: _dotAnimations[index].value,
                        child: Container(
                          width: 8,
                          height: 8,
                          decoration: BoxDecoration(
                            color: _dotColor,
                            shape: BoxShape.circle,
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';

/// Custom app bar for the chat screen matching the Figma design.
/// Displays ChatGPT branding with robot icon, online status, and action icons.
class ChatAppBarWidget extends StatelessWidget implements PreferredSizeWidget {
  const ChatAppBarWidget({
    super.key,
    this.onBackPressed,
    this.onSpeakerPressed,
    this.onUploadPressed,
  });

  final VoidCallback? onBackPressed;
  final VoidCallback? onSpeakerPressed;
  final VoidCallback? onUploadPressed;

  static const double _height = 56;

  @override
  Size get preferredSize => const Size.fromHeight(_height);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      leading: IconButton(
        onPressed: onBackPressed ?? () => Navigator.of(context).pop(),
        icon: const Icon(Icons.arrow_back_ios_new),
        color: Colors.black87,
        iconSize: 20,
        padding: const EdgeInsets.only(left: 8),
      ),
      titleSpacing: 0,
      title: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: const Color(0xFF2196F3),
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Icon(
              Icons.smart_toy_outlined,
              color: Colors.white,
              size: 24,
            ),
          ),
          const SizedBox(width: 12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'ChatGPT',
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                      color: Colors.black87,
                    ),
              ),
              Row(
                children: [
                  Container(
                    width: 8,
                    height: 8,
                    decoration: const BoxDecoration(
                      color: Color(0xFF4CAF50),
                      shape: BoxShape.circle,
                    ),
                  ),
                  const SizedBox(width: 6),
                  Text(
                    'Online',
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: const Color(0xFF4CAF50),
                          fontWeight: FontWeight.w500,
                        ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
      actions: [
        IconButton(
          onPressed: onSpeakerPressed,
          icon: const Icon(Icons.volume_up_outlined),
          color: Colors.black54,
          iconSize: 24,
        ),
        IconButton(
          onPressed: onUploadPressed,
          icon: const Icon(Icons.upload_outlined),
          color: Colors.black54,
          iconSize: 24,
        ),
        const SizedBox(width: 8),
      ],
    );
  }
}

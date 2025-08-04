import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:hosta_app/theme/app_colors.dart';
import 'package:hosta_app/widgets/app_bar.dart' show SimpleAppBar;
import 'package:hosta_app/widgets/custom_bottom_navigation.dart';
import 'package:hosta_app/data/models/chat_model.dart';
import 'package:hosta_app/presentation/providers/chat_provider.dart';
import 'package:hosta_app/shared/widgets/index.dart';

class ChatsListScreen extends StatefulWidget {
  const ChatsListScreen({super.key});

  @override
  State<ChatsListScreen> createState() => _ChatsListScreenState();
}

class _ChatsListScreenState extends State<ChatsListScreen> {
  @override
  void initState() {
    super.initState();
    _loadChats();
  }

  Future<void> _loadChats() async {
    final chatProvider = context.read<ChatProvider>();
    await chatProvider.loadUserChats();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const SimpleAppBar(),
      body: Consumer<ChatProvider>(
        builder: (context, chatProvider, child) {
          if (chatProvider.isLoading) {
            return const LoadingWidget(message: 'Loading chats...');
          }

          if (chatProvider.error != null) {
            return CustomErrorWidget(
              message: chatProvider.error!,
              onRetry: () => _loadChats(),
            );
          }

          if (chatProvider.chats.isEmpty) {
            return const EmptyWidget(
              message: 'لا توجد محادثات بعد',
              icon: Icons.chat_bubble_outline,
            );
          }

          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: chatProvider.chats.length,
            itemBuilder: (context, index) {
              final chat = chatProvider.chats[index];
              return _buildChatTile(chat);
            },
          );
        },
      ),
      bottomNavigationBar: CustomBottomNavigation(
        currentIndex: 1, // My services index
        onTap: _onBottomNavTap,
      ),
    );
  }

  void _onBottomNavTap(int index) {
    if (index == 0) {
      // Home
      Navigator.pushNamedAndRemoveUntil(context, '/home', (route) => false);
    } else if (index == 1) {
      // My services
      Navigator.pushNamedAndRemoveUntil(context, '/search', (route) => false);
    } else if (index == 2) {
      // Profile
      Navigator.pushNamedAndRemoveUntil(context, '/profile', (route) => false);
    }
  }

  Widget _buildChatTile(ChatModel chat) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    // Get last message
    final lastMessage = chat.messages.isNotEmpty ? chat.messages.last : null;

    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: ListTile(
        contentPadding: const EdgeInsets.all(16),
        leading: CircleAvatar(
          radius: 25,
          backgroundColor: AppColors.primaryBlue,
          child: const Icon(Icons.person, color: Colors.white, size: 30),
        ),
        title: Text(
          'مزود الخدمة', // TODO: Get provider name
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16,
            color: isDark ? Colors.white : Colors.black87,
          ),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (lastMessage != null) ...[
              const SizedBox(height: 4),
              Text(
                lastMessage.content,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontSize: 14,
                  color: isDark ? Colors.grey[300] : Colors.grey[600],
                ),
              ),
              const SizedBox(height: 4),
              Text(
                _formatTime(lastMessage.timestamp),
                style: TextStyle(fontSize: 12, color: Colors.grey[500]),
              ),
            ] else ...[
              const SizedBox(height: 4),
              Text(
                'لا توجد رسائل بعد',
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey[500],
                  fontStyle: FontStyle.italic,
                ),
              ),
            ],
          ],
        ),
        trailing: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (lastMessage != null && !lastMessage.isRead) ...[
              Container(
                width: 12,
                height: 12,
                decoration: const BoxDecoration(
                  color: AppColors.primaryBlue,
                  shape: BoxShape.circle,
                ),
              ),
            ],
            const SizedBox(height: 4),
            Text(
              '${chat.messages.length}',
              style: TextStyle(fontSize: 12, color: Colors.grey[500]),
            ),
          ],
        ),
        onTap: () {
          // Navigate to chat screen
          context.read<ChatProvider>().loadChatMessages(chat.id);
          // TODO: Navigate to chat screen with provider info
        },
      ),
    );
  }

  String _formatTime(DateTime time) {
    final now = DateTime.now();
    final difference = now.difference(time);

    if (difference.inDays > 0) {
      return '${difference.inDays} يوم';
    } else if (difference.inHours > 0) {
      return '${difference.inHours} ساعة';
    } else if (difference.inMinutes > 0) {
      return '${difference.inMinutes} دقيقة';
    } else {
      return 'الآن';
    }
  }
}

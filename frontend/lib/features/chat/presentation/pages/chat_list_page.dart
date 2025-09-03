import 'package:flutter/material.dart';
import 'package:frontend/shared/widgets/app_bottom_nav.dart';
import 'package:frontend/shared/widgets/search_header.dart';
import 'package:go_router/go_router.dart';
import '../../../../../core/config/app_colors.dart';

class ChatListPage extends StatefulWidget {
  const ChatListPage({super.key});

  @override
  State<ChatListPage> createState() => _ChatListPageState();
}

class _ChatListPageState extends State<ChatListPage> {
  int _currentIndex = 1;

  final List<Map<String, dynamic>> _chats = [
    {"name": "Pedro Miguel Radwanski", "lastMsg": "Bora marcar a coleta!"},
    {"name": "Maria Silva", "lastMsg": "Enviei o endereço 👍"},
    {"name": "João Santos", "lastMsg": "Consegui os tecidos."},
    {"name": "Ana Clara", "lastMsg": "Pode buscar amanhã?"},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      body: SafeArea(
        child: Column(
          children: [
            const Padding(
              padding: EdgeInsets.fromLTRB(16, 16, 16, 8),
              child: SearchHeader(),
            ),

            Expanded(
              child: ListView.separated(
                itemCount: _chats.length,
                separatorBuilder: (_, __) => const Divider(height: 1),
                itemBuilder: (context, index) {
                  final chat = _chats[index];
                  return ListTile(
                    leading: CircleAvatar(
                      backgroundColor: AppColors.navy,
                      child: const Icon(Icons.person, color: Colors.white),
                    ),
                    title: Text(
                      chat["name"],
                      style: const TextStyle(
                        fontWeight: FontWeight.w600,
                        color: AppColors.textPrimary,
                      ),
                    ),
                    subtitle: Text(
                      chat["lastMsg"],
                      style: const TextStyle(color: AppColors.textSecondary),
                    ),
                    trailing: const Icon(
                      Icons.chevron_right,
                      color: Colors.grey,
                    ),
                    onTap: () {
                      context.go('/chat');
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),

      bottomNavigationBar: AppBottomNavBar(currentIndex: _currentIndex),
    );
  }
}

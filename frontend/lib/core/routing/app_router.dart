import 'package:flutter/material.dart';
import 'package:frontend/features/auth/presentation/pages/signin_page.dart';
import 'package:frontend/features/chat/presentation/pages/chat_page.dart';
import 'package:frontend/features/map/presentation/pages/map_page.dart';
import 'package:go_router/go_router.dart';
import '../../features/auth/presentation/pages/signup_page.dart';

GoRouter buildRouter() => GoRouter(
  initialLocation: '/chat',
  routes: [
    GoRoute(path: '/signup', builder: (_, __) => const SignUpPage()),
    GoRoute(path: '/signin', builder: (_, __) => const SignInPage()),
    GoRoute(path: '/map', builder: (_, __) => const MapPage()),
    GoRoute(path: '/chat', builder: (_, __) => const ChatPage()),
  ],
  errorBuilder: (_, state) => Scaffold(
    appBar: AppBar(title: const Text('Ops')),
    body: Center(child: Text(state.error.toString())),
  ),
);

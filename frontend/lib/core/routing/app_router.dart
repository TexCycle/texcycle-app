import 'package:flutter/material.dart';
import 'package:frontend/features/account/presentation/pages/account_page.dart';
import 'package:frontend/features/auth/presentation/pages/signin_page.dart';
import 'package:frontend/features/chat/presentation/pages/chat_list_page.dart';
import 'package:frontend/features/donor/presentation/pages/donor_info_page.dart';
import 'package:frontend/features/map/presentation/pages/map_page.dart';
import 'package:go_router/go_router.dart';
import '../../features/auth/presentation/pages/signup_page.dart';

GoRouter buildRouter() => GoRouter(
  initialLocation: '/sign-in',
  routes: [
    GoRoute(path: '/sign-up', builder: (_, __) => const SignUpPage()),
    GoRoute(path: '/sign-in', builder: (_, __) => const SignInPage()),
    GoRoute(path: '/map', builder: (_, __) => const MapPage()),
    GoRoute(path: '/my-account', builder: (_, __) => const AccountPage()),
    GoRoute(path: '/donor-info', builder: (_, __) => const DonorInfoPage()),
    GoRoute(path: '/services', builder: (_, __) => const ChatListPage()),
  ],
  errorBuilder: (_, state) => Scaffold(
    appBar: AppBar(title: const Text('Ops')),
    body: Center(child: Text(state.error.toString())),
  ),
);

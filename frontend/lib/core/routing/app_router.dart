import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../features/auth/presentation/pages/signup_page.dart';

GoRouter buildRouter() => GoRouter(
  initialLocation: '/signup',
  routes: [
    GoRoute(path: '/signup', builder: (_, __) => const SignUpPage()),
  ],
  errorBuilder: (_, state) => Scaffold(
    appBar: AppBar(title: const Text('Ops')),
    body: Center(child: Text(state.error.toString())),
  ),
);

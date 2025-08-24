import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

GoRouter buildRouter() => GoRouter(
  initialLocation: '/login',
  routes: [
    
  ],
  errorBuilder: (_, state) => Scaffold(
    appBar: AppBar(title: const Text('Ops')),
    body: Center(child: Text(state.error.toString())),
  ),
);

import 'package:flutter/material.dart';
import 'core/config/theme.dart';
import 'core/routing/app_router.dart';

class TextileApp extends StatelessWidget {
  const TextileApp({super.key});

  @override
  Widget build(BuildContext context) {
    final router = buildRouter();
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      theme: buildTheme(),
      routerConfig: router,
    );
  }
}
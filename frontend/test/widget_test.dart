import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:frontend/app.dart';

void main() {
  testWidgets('App loads and shows Login screen', (WidgetTester tester) async {
    // Build our app
    await tester.pumpWidget(const TextileApp());

    // Verify that LoginPage loads with title "Entrar"
    expect(find.text('Entrar'), findsOneWidget);
    expect(find.text('Bem-vindo(a)'), findsOneWidget);

    // Check if the "Criar conta" button exists
    expect(find.text('Criar conta'), findsOneWidget);
  });
}

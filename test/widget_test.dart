import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';
import 'package:novelvio/app/app.dart';

void main() {
  testWidgets('Novelvio app starts on rewards shell', (WidgetTester tester) async {
    await tester.pumpWidget(const NovelvioApp());
    await tester.pumpAndSettle();

    expect(find.byType(NovelvioApp), findsOneWidget);
    expect(find.text('مكافآت'), findsOneWidget);
    expect(find.text('فيديو'), findsOneWidget);
    expect(find.byType(NavigationBar), findsOneWidget);
  });
}

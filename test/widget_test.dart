import 'package:flutter_test/flutter_test.dart';
import 'package:novelvio/app/app.dart';

void main() {
  testWidgets('Novelvio app starts', (WidgetTester tester) async {
    await tester.pumpWidget(const NovelvioApp());
    await tester.pumpAndSettle();

    expect(find.byType(NovelvioApp), findsOneWidget);
    expect(find.text('Sign in'), findsOneWidget);
    expect(find.byType(TextField), findsNWidgets(2));
  });
}

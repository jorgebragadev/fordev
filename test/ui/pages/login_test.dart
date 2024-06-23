import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fordev/ui/pages/login_page.dart';

void main() {
  Future<void> loadPage(WidgetTester tester) async {
    final loginPage = MaterialApp(home: LoginPage());
    await tester.pumpWidget(loginPage);
  }

  testWidgets('Should load with corrent initial state',
      (WidgetTester tester) async {
    await loadPage(tester);

    final emailTextChildren = find.descendant(
        of: find.bySemanticsLabel('Email'), matching: find.byType(Text));

    expect(emailTextChildren, findsOneWidget);

    final passwordTextChildren = find.descendant(
        of: find.bySemanticsLabel('Password'), matching: find.byType(Text));

    expect(emailTextChildren, findsOneWidget);

    final button = tester.widget<ElevatedButton>(find.byType(ElevatedButton));
    expect(button.onPressed, null);
  });

  
}

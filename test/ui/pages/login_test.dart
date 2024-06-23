import 'dart:async';

import 'package:faker/faker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fordev/ui/pages/login/login_page.dart';
import 'package:fordev/ui/pages/login/login_presenter.dart';
import 'package:mocktail/mocktail.dart';

class LoginPresenterSpy extends Mock implements LoginPresenter {}

void main() {
  late LoginPresenter presenter;
  late StreamController<String?> emailErrorController;

  Future<void> loadPage(WidgetTester tester) async {
    presenter = LoginPresenterSpy();
    emailErrorController = StreamController<String?>(); // Defina o tipo do StreamController
    when(() => presenter.emailErrorStream).thenAnswer((_) => emailErrorController.stream);

    final loginPage = MaterialApp(home: LoginPage(presenter));
    await tester.pumpWidget(loginPage);
  }

  setUp(() {
    presenter = LoginPresenterSpy();
    when(() => presenter.validateEmail(any())).thenReturn(null); // Configura o mock
    when(() => presenter.validatePassword(any())).thenReturn(null); // Configura o mock
  });

  tearDown(() {
    emailErrorController.close();
  });

  testWidgets('Should load with correct initial state', (WidgetTester tester) async {
    await loadPage(tester);

    final emailTextChildren = find.descendant(
      of: find.bySemanticsLabel('Email'),
      matching: find.byType(Text),
    );

    expect(emailTextChildren, findsOneWidget);

    final passwordTextChildren = find.descendant(
      of: find.bySemanticsLabel('Password'),
      matching: find.byType(Text),
    );

    expect(passwordTextChildren, findsOneWidget);

    final button = tester.widget<ElevatedButton>(find.byType(ElevatedButton));
    expect(button.onPressed, null);
  });

  testWidgets('Should call validate with correct values', (WidgetTester tester) async {
    await loadPage(tester);

    final email = faker.internet.email();
    await tester.enterText(find.bySemanticsLabel('Email'), email);
    await tester.pump(); // Adicione isto para garantir que todas as interações assíncronas sejam processadas

    verify(() => presenter.validateEmail(email)).called(1); // Verifique se o método foi chamado exatamente uma vez
  });

  testWidgets('Should present error if email is invalid', (WidgetTester tester) async {
    await loadPage(tester);

    emailErrorController.add('any error');
    await tester.pump(); // Aguarde a atualização do StreamBuilder

    expect(find.text('any error'), findsOneWidget); // Verifique se o texto de erro é encontrado
  });
}

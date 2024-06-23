import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fordev/ui/pages/login/login_page.dart';
import 'package:fordev/ui/pages/login/login_presenter.dart';
import 'dart:async';

class FakeLoginPresenter extends LoginPresenter {
  final _emailErrorController = StreamController<String?>.broadcast();
  final _passwordErrorController = StreamController<String?>.broadcast();
  final _isFormValidStream = StreamController<bool>.broadcast();
  final _isFormValidController = StreamController<bool>.broadcast();
  final _isLoadingStream = StreamController<bool>.broadcast();

  @override
  Stream<String?> get emailErrorStream => _emailErrorController.stream;

  @override
  void validateEmail(String email) {}

  @override
  void validatePassword(String password) {}

  @override
  void aut() {}

  void dispose() {
    _emailErrorController.close();
    _passwordErrorController.close();
    _isFormValidStream.close();
    _isFormValidController.close();
  }

  @override
  Stream<String?> get passwordErrorStream => throw UnimplementedError();

  @override
  Stream<bool> get isFormValidStream => throw UnimplementedError();

  @override
  void auth() {}
  
  @override
  // TODO: implement isLoadingStream
  Stream<bool> get isLoadingStream => throw UnimplementedError();
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light);
    const primaryColor = Color.fromRGBO(136, 14, 79, 1);
    const primaryColorDark = Color.fromRGBO(96, 0, 39, 1);
    const primaryColorLight = Color.fromRGBO(188, 71, 123, 1);

    final LoginPresenter presenter = FakeLoginPresenter();

    return MaterialApp(
      title: '4Dev',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: primaryColor,
        primaryColorDark: primaryColorDark,
        primaryColorLight: primaryColorLight,
        hintColor: primaryColor,
        colorScheme: ColorScheme.fromSwatch().copyWith(
          primary: primaryColor,
          secondary: primaryColorLight,
          background: Colors.white,
        ),
        textTheme: TextTheme(
          headlineLarge: TextStyle(
            fontSize: 30,
            fontWeight: FontWeight.bold,
            color: primaryColorDark,
          ),
        ),
        inputDecorationTheme: InputDecorationTheme(
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: primaryColorLight),
          ),
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: primaryColor),
          ),
          alignLabelWithHint: true,
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: primaryColor,
            foregroundColor: Colors.white,
            padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
          ),
        ),
        textButtonTheme: TextButtonThemeData(
          style: TextButton.styleFrom(
            foregroundColor: primaryColor,
          ),
        ),
      ),
      home: LoginPage(presenter), // Passe o presenter para o LoginPage
    );
  }
}

void main() {
  runApp(App());
}

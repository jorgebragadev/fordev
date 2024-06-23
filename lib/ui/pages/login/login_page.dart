import 'package:flutter/material.dart';
import 'package:fordev/ui/components/app.dart';
import 'package:fordev/ui/components/headlineLarge.dart';
import 'package:fordev/ui/components/login_header.dart';
import 'package:fordev/ui/pages/login/login_presenter.dart';

class LoginPage extends StatelessWidget {
  final LoginPresenter presenter;

  const LoginPage(this.presenter);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            LoginHeader(),
            headlineLarge(
              text: 'Login',
            ),
            Padding(
              padding: const EdgeInsets.all(32),
              child: Form(
                child: Column(
                  children: [
                    TextFormField(
                      decoration: InputDecoration(
                        labelText: 'Email',
                        icon: Icon(Icons.email, color: Theme.of(context).primaryColorLight),
                      ),
                      keyboardType: TextInputType.emailAddress,
                      onChanged: presenter.validateEmail,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 8, bottom: 32),
                      child: TextFormField(
                        decoration: InputDecoration(
                          labelText: 'Password',
                          icon: Icon(Icons.lock, color: Theme.of(context).primaryColorLight),
                        ),
                        obscureText: true,
                        onChanged: presenter.validatePassword,
                      ),
                    ),
                    ElevatedButton(
                      onPressed: null,
                      child: const Text('ENTRAR'),
                    ),
                    TextButton.icon(
                      onPressed: () {},
                      icon: Icon(Icons.person, color: Theme.of(context).primaryColorLight),
                      label: Text('Criar Conta'),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

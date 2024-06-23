import 'package:flutter/material.dart';
import 'package:fordev/ui/components/headlineLarge.dart';
import 'package:fordev/ui/components/login_header.dart';
import 'package:fordev/ui/pages/login/login_presenter.dart';

class LoginPage extends StatelessWidget {
  final LoginPresenter presenter;

  const LoginPage(this.presenter, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const LoginHeader(),
            headlineLarge(
              text: 'Login',
            ),
            Padding(
              padding: const EdgeInsets.all(32),
              child: Form(
                child: Column(
                  children: [
                    StreamBuilder<String?>(
                      stream: presenter.emailErrorStream,
                      builder: (context, snapshot) {
                        return TextFormField(
                          decoration: InputDecoration(
                            labelText: 'Email',
                            icon: Icon(Icons.email,
                                color: Theme.of(context).primaryColorLight),
                            errorText: snapshot.data?.isEmpty == true
                                ? null
                                : snapshot.data,
                          ),
                          keyboardType: TextInputType.emailAddress,
                          onChanged: presenter.validateEmail,
                        );
                      },
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 8, bottom: 32),
                      child: StreamBuilder<String?>(
                          stream: presenter.passwordErrorStream,
                          builder: (context, snapshot) {
                            return TextFormField(
                              decoration: InputDecoration(
                                labelText: 'Password',
                                icon: Icon(Icons.lock,
                                    color: Theme.of(context).primaryColorLight),
                                errorText: snapshot.data?.isEmpty == true
                                    ? null
                                    : snapshot.data,
                              ),
                              obscureText: true,
                              onChanged: presenter.validatePassword,
                            );
                          }),
                    ),
                    StreamBuilder<bool>(
                      stream: presenter.isFormValidStream,
                      builder: (context, snapshot) {
                        return ElevatedButton(
                          onPressed: snapshot.data == true ? () {} : null,
                          child: const Text('ENTRAR'),
                        );
                      }
                    ),
                    TextButton.icon(
                      onPressed: () {},
                      icon: Icon(Icons.person,
                          color: Theme.of(context).primaryColorLight),
                      label: const Text('Criar Conta'),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

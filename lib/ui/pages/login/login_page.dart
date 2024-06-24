import 'package:flutter/material.dart';
import 'package:fordev/ui/components/error_message.dart';
import 'package:fordev/ui/components/headlineLarge.dart';
import 'package:fordev/ui/components/login_header.dart';
import 'package:fordev/ui/components/spinner_dialog.dart';
import 'package:fordev/ui/pages/login/components/email_input.dart';
import 'package:fordev/ui/pages/login/components/login_button.dart';
import 'package:fordev/ui/pages/login/components/password_input.dart';
import 'package:fordev/ui/pages/login/login_presenter.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget {
  final LoginPresenter presenter;

  const LoginPage(this.presenter, {Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  void dispose() {
    super.dispose();
    widget.presenter.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Builder(
        builder: (context) {
          widget.presenter.isLoadingStream.listen((isLoading) {
            if (isLoading) {
              showLoading(context);
            } else {
              hideLoading(context);
            }
          });
          widget.presenter.mainErrorStream.listen((error) {
            if (error != null) {
              showErrorMessage(context, error);
            }
          });

          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const LoginHeader(),
                headlineLarge(
                  text: 'Login',
                ),
                Padding(
                  padding: const EdgeInsets.all(32),
                  child: Provider<LoginPresenter>.value(
                    value: widget.presenter,
                    child: Form(
                      child: Column(
                        children: [
                          const EmailInput(),
                          Padding(
                            padding: const EdgeInsets.only(top: 8, bottom: 32),
                            child: const PasswordInput(),
                          ),
                          const LoginButton(),
                          TextButton.icon(
                            onPressed: () {},
                            icon: Icon(Icons.person, color: Theme.of(context).primaryColorLight),
                            label: const Text('Criar Conta'),
                          ),
                        ],
                      ),
                    ),
                  ),
                )
              ],
            ),
          );
        },
      ),
    );
  }
}



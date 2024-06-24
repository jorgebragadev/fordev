import 'package:flutter/material.dart';
import 'package:fordev/ui/pages/login/login_presenter.dart';
import 'package:provider/provider.dart';

class LoginButton extends StatelessWidget {
  const LoginButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final LoginPresenter presenter =
        Provider.of<LoginPresenter>(context, listen: false);
    return StreamBuilder<bool>(
      stream: presenter.isFormValidStream,
      builder: (context, snapshot) {
        return ElevatedButton(
          onPressed: snapshot.data == true ? presenter.auth : null,
          child: const Text('ENTRAR'),
        );
      },
    );
  }
}

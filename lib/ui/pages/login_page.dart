import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
          child: Column(children: [
        Container(
          child: const Image(
            image: AssetImage('lib/ui/assets/logo.png'),
          ),
        ),
        Text('Login'.toUpperCase()),
        Form(
            child: Column(
          children: [
            TextFormField(
              decoration: const InputDecoration(
                  labelText: 'Email', icon: Icon(Icons.email)),
              keyboardType: TextInputType.emailAddress,
            ),
            TextFormField(
              decoration: const InputDecoration(
                  labelText: 'Password', icon: Icon(Icons.lock)),
              obscureText: true,
            ),
            ElevatedButton(
              onPressed: () {},
              child: const Text('ENTRAR'),
            ),
            TextButton.icon(
              onPressed: () {},
              icon: Icon(Icons.person),
              label: Text('Criar Conta'),
            ),
          ],
        ))
      ])),
    );
  }
}

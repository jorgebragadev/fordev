import 'package:flutter/material.dart';

class headlineLarge extends StatelessWidget {
  final String text;
  const headlineLarge({
    super.key, required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
     text.toUpperCase(),
      textAlign: TextAlign.center,
      style: Theme.of(context).textTheme.headlineLarge,
    );
  }
}
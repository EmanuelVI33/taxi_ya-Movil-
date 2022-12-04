import 'package:flutter/material.dart';

class MyTextButton extends StatelessWidget {
  final String _text;
  final String _route;

  const MyTextButton(this._text, this._route, {super.key});

  @override
  Widget build(BuildContext context) {
    return TextButton(
      child: Text(
        _text,
        style: const TextStyle(
          fontSize: 15,
          color: Colors.indigo,
          fontWeight: FontWeight.bold,
          letterSpacing: 2,
        ),
      ),
      onPressed: () {
        Navigator.pushNamed(context, _route);
      },
    );
  }
}

import 'package:flutter/material.dart';

class RegisterDriverScreen extends StatelessWidget {
  const RegisterDriverScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Registrate como Conductor'),
      ),
      body: const Center(
        child: Text('Registrate'),
      ),
    );
  }
}

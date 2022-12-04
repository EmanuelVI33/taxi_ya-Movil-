import 'package:flutter/material.dart';
import 'package:taxi_ya/constant.dart';

class PunctationScreen extends StatelessWidget {
  const PunctationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: MyAppBar("Puntuación"), body: const Text("Puntuación "));
  }
}

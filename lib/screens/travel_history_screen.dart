import 'package:flutter/material.dart';
import 'package:taxi_ya/constant.dart';

class TravelHistoryScreen extends StatelessWidget {
  const TravelHistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar("Historial de Viajes"),
      body: const Text("Historial de Viaje"),
    );
  }
}

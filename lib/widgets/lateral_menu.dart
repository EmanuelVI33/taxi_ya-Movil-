import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:taxi_ya/providers/providers.dart';
import 'package:taxi_ya/screens/screens.dart';

class LateralMenu extends StatelessWidget {
  const LateralMenu({super.key});

  @override
  Widget build(BuildContext context) {
    final driverProvider = Provider.of<HomeProvider>(context);

    return Drawer(
      child: Container(
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.only(left: 10, right: 20, top: 30),
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.only(top: 30, bottom: 20),
                child: _builderIcon(),
              ),
              const Text(
                "Taxi Ya",
                style: TextStyle(
                  fontSize: 24,
                  color: Colors.indigo,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 20),
                padding:
                    const EdgeInsets.symmetric(vertical: 20, horizontal: 5),
                width: double.infinity,
                color: Colors.grey[100],
                child: Column(
                  children: [
                    const TextDrawer("Modo Conductor"),
                    const SizedBox(
                      width: 15,
                    ),
                    Switch(
                        value: driverProvider.isDriver,
                        onChanged: (bool value) {
                          driverProvider.isDriver = value;
                        })
                  ],
                ),
              ),

              // Mis Viajes
              Container(
                  padding:
                      const EdgeInsets.symmetric(vertical: 20, horizontal: 5),
                  color: Colors.grey[100],
                  width: double.infinity,
                  child: TextButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    const TravelHistoryScreen()));
                      },
                      child: const TextDrawer("Historial de Viajes"))),

              // Puntuación
              Container(
                  padding:
                      const EdgeInsets.symmetric(vertical: 20, horizontal: 5),
                  width: double.infinity,
                  color: Colors.grey[100],
                  child: TextButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    const PunctationScreen()));
                      },
                      child: const TextDrawer("Puntuación"))),

              // Soporte
              Container(
                  padding:
                      const EdgeInsets.symmetric(vertical: 20, horizontal: 5),
                  width: double.infinity,
                  color: Colors.grey[100],
                  child: TextButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    const TravelHistoryScreen()));
                      },
                      child: const TextDrawer("Soporte"))),

              // Ajustes
              Container(
                  padding:
                      const EdgeInsets.symmetric(vertical: 20, horizontal: 5),
                  width: double.infinity,
                  color: Colors.grey[100],
                  child: TextButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    const TravelHistoryScreen()));
                      },
                      child: const TextDrawer("Ajuste"))),

              Container(
                  padding:
                      const EdgeInsets.symmetric(vertical: 20, horizontal: 5),
                  width: double.infinity,
                  color: Colors.black,
                  child: const Text(
                    "Derechos Reservados 2022",
                    style: TextStyle(color: Colors.white),
                  ))
            ],
          ),
        ),
      ),
    );
  }

  Icon _builderIcon() {
    return const Icon(
      Icons.local_taxi_outlined,
      size: 100,
      color: Colors.indigo,
      semanticLabel: "Taxi Ya",
    );
  }
}

class TextDrawer extends StatelessWidget {
  final String _text;

  const TextDrawer(this._text, {super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      _text,
      style: const TextStyle(
        fontSize: 15,
        color: Colors.indigo,
        fontWeight: FontWeight.bold,
        letterSpacing: 2,
      ),
    );
  }
}

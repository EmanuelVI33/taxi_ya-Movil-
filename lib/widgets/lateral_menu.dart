import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:taxi_ya/providers/providers.dart';
import 'package:taxi_ya/widgets/text_button.dart';

class LateralMenu extends StatelessWidget {
  const LateralMenu({super.key});

  @override
  Widget build(BuildContext context) {
    final driverProvider = Provider.of<DriverProvider>(context, listen: false);

    return Drawer(
      child: Container(
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.only(left: 10, right: 20, top: 30),
          child: Column(
            children: [
              Container(
                child: _builderIcon(),
                padding: EdgeInsets.only(top: 30, bottom: 20),
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
                margin: EdgeInsets.only(top: 20),
                padding: EdgeInsets.symmetric(vertical: 20, horizontal: 5),
                width: double.infinity,
                color: Colors.grey[100],
                child: Column(
                  children: [
                    const MyTextButton("Modo Conductor"),
                    const SizedBox(
                      width: 10,
                    ),
                    Switch(
                        value: driverProvider.isDriver,
                        onChanged: (value) {
                          driverProvider.isDriver = value;
                        })
                  ],
                ),
              ),
              Container(
                  padding:
                      const EdgeInsets.symmetric(vertical: 20, horizontal: 5),
                  color: Colors.grey[100],
                  width: double.infinity,
                  child: const MyTextButton("Mis Viajes")),
              Container(
                  padding:
                      const EdgeInsets.symmetric(vertical: 20, horizontal: 5),
                  width: double.infinity,
                  color: Colors.grey[100],
                  child: const MyTextButton("Puntuación")),
              Container(
                  padding:
                      const EdgeInsets.symmetric(vertical: 20, horizontal: 5),
                  width: double.infinity,
                  color: Colors.grey[100],
                  child: const MyTextButton("Soporte")),
              Container(
                  padding:
                      const EdgeInsets.symmetric(vertical: 20, horizontal: 5),
                  width: double.infinity,
                  color: Colors.grey[100],
                  child: const MyTextButton("Ajuste")),
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

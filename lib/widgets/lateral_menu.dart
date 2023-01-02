import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:taxi_ya/constant.dart' show displayDialog, myText;
import 'package:taxi_ya/models/models.dart';
import 'package:taxi_ya/providers/providers.dart';
import 'package:taxi_ya/screens/screens.dart';
import 'package:taxi_ya/services/services.dart';

class LateralMenu extends StatelessWidget {
  const LateralMenu({super.key});

  @override
  Widget build(BuildContext context) {
    final driverProvider = Provider.of<HomeProvider>(context);
    final userProvider = Provider.of<UserProvider>(context);
    final userService = Provider.of<UserService>(context);

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
                        onChanged: (bool value) async {
                          if (userProvider.isDriver) {
                            // Esta registrdo como conductor

                            // Muestra el dialog y almacena si el usuario cambia a driver
                            displayDialogDriver(context, driverProvider);
                            return;
                          }

                          final response = await userService.sendRequest(
                              context, userProvider.id);

                          if (response.error == null) {
                            // Esta en espera o rechazada su solicitud
                            RequestDriver request =
                                response.data as RequestDriver;

                            if (request.estado == 'E') {
                              displayDialog(
                                  context,
                                  'Solicitud en Espera',
                                  'Debe espera para que su solicitud sea revisada',
                                  'Ok',
                                  'home',
                                  Icons.drive_eta_rounded);
                            } else if (request.estado == 'R') {
                              displayDialog(
                                  context,
                                  'Solicitud Rechazada',
                                  'Su solicitud ha sido rechazada',
                                  'Aceptar',
                                  'home',
                                  Icons.drive_eta_rounded);
                            } else {
                              userProvider.isDriver = true;

                              displayDialogAccept(
                                  context,
                                  'Solicitud Aceptada',
                                  'Su solicitud ha sido aceptada, bienvenido a Taxi Ya',
                                  'Ok',
                                  'home',
                                  Icons.check_box);
                            }
                          } else {
                            // Debe llenar la solicitud
                            displayDialog(
                                context,
                                'Registrate',
                                'Para entrar en modo conductor debes llenar una solitud',
                                'Registrarme',
                                'register_driver',
                                Icons.drive_eta_rounded);
                          }
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

void displayDialogDriver(BuildContext context, HomeProvider driver) {
  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        elevation: 0,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadiusDirectional.circular(15)),
        title: Container(
            padding: const EdgeInsets.symmetric(vertical: 5),
            width: double.infinity,
            decoration: BoxDecoration(
                color: Colors.indigo, borderRadius: BorderRadius.circular(15)),
            child: myText(driver.isDriver ? 'Modo Pasajero' : 'Modo Conductor',
                18, Colors.white, FontWeight.bold)),
        content: Column(
            mainAxisSize: MainAxisSize.min, // Se adapta al tamaño de los hijos
            children: [
              Text(
                driver.isDriver
                    ? 'Deseas cambiar a modo pasajero'
                    : 'Deseas cambiar a modo conductor',
                style: const TextStyle(color: Colors.black),
                textAlign: TextAlign.center,
              ),
              const SizedBox(
                height: 10,
              ),
              Icon(
                driver.isDriver ? Icons.person : Icons.drive_eta_outlined,
                size: 50,
              ),
            ]),
        actions: [
          TextButton(
            onPressed: () {
              driver.isDriver = !driver.isDriver;
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) => const HomeScreen()));
            },
            child: const Text('Si'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text(
              'Cancelar',
              style: TextStyle(color: Colors.redAccent),
            ),
          ),
        ],
      );
    },
  );
}

void displayDialogAccept(BuildContext context, String titulo, String content,
    String message, String route, IconData icon) {
  showDialog(
    // barrierDismissible:
    //     true, // Para que se desactiva al presionar fuera del dialogo
    context: context,
    builder: (context) {
      return AlertDialog(
        elevation: 5,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadiusDirectional.circular(15)),
        title: Text(titulo),
        content: Column(
            mainAxisSize: MainAxisSize.min, // Se adapta al tamaño de los hijos
            children: [
              Text(content),
              const SizedBox(
                height: 10,
              ),
              Icon(
                icon,
                size: 50,
              ),
            ]),
        actions: [
          TextButton(
            onPressed: () => Navigator.pushReplacementNamed(context, 'home'),
            child: Text(message),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text(
              'Cancelar',
              style: TextStyle(color: Colors.redAccent),
            ),
          ),
        ],
      );
    },
  );
}

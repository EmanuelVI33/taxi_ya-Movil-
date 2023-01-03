import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:taxi_ya/constant.dart';
import 'package:taxi_ya/models/carrera.dart';
import 'package:taxi_ya/models/models.dart';
import 'package:taxi_ya/providers/providers.dart';

class TravelHistoryScreen extends StatelessWidget {
  const TravelHistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final historyProvider = Provider.of<HistoryProvider>(context);

    return Scaffold(
      appBar: myAppBar('Historial de Viaje'),
      body: Column(
        children: [
          Container(
              decoration: BoxDecoration(
                color: Colors.indigo,
                borderRadius: BorderRadius.circular(40),
              ),
              width: double.infinity,
              margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
              padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 10),
              child: myText(
                  'Historial de Viajes', 17, Colors.white, FontWeight.bold)),
          Container(
            margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
            child: myText(
                'Cantidad de Viajes: ${historyProvider.carreras.length}',
                15,
                Colors.black,
                FontWeight.bold),
          ),
          historyProvider.isNull()
              ? Center(
                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.indigo,
                        borderRadius: BorderRadius.circular(15)),
                    padding: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 15),
                    child: myText('No ha realizo ning;un viaje', 18,
                        Colors.white, FontWeight.bold),
                  ),
                )
              : Expanded(
                  child: ListView.builder(
                    itemBuilder: ((BuildContext context, index) {
                      return (radioCar(index, historyProvider, context));
                    }),
                    itemCount: historyProvider.carreras.length,
                  ),
                ),
        ],
      ),
    );
  }

  Widget radioCar(int index, HistoryProvider history, BuildContext context) {
    final isDriver = Provider.of<UserProvider>(context, listen: false).isDriver;
    List<Carrera> carreras = history.carreras;
    User user = carreras[index].user;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 20),
      margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      decoration: BoxDecoration(
          color: Colors.indigo, borderRadius: BorderRadius.circular(20)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            mainAxisSize: MainAxisSize.max,
            children: [
              carreras[index].estado == 'F'
                  ? myText('Finalizado', 14, Colors.green, FontWeight.bold)
                  : myText('Rechazado', 14, Colors.red, FontWeight.bold),
              Container(
                padding: EdgeInsets.all(3),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        topRight: Radius.circular(15),
                        bottomLeft: Radius.circular(15))),
                child: myText('${carreras[index].precio} BS', 15, Colors.indigo,
                    FontWeight.bold),
              )
            ],
          ),
          Container(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
            child: myText('Cliente: ${user.nombre} ${user.apellido}', 14,
                Colors.white, FontWeight.normal),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            mainAxisSize: MainAxisSize.max,
            children: [
              myText(carreras[index].hora, 11, Colors.white, FontWeight.normal),
              myText(
                  carreras[index].fecha, 11, Colors.white, FontWeight.normal),
            ],
          ),
        ],
      ),
    );
    // Radio(value: index, groupValue: 1, onChanged: (value) {});
  }
}

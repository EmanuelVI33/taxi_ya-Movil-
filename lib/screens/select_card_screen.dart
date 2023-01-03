import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:taxi_ya/constant.dart';
import 'package:taxi_ya/models/vehiculo.dart';
import 'package:taxi_ya/providers/select_car_provider.dart';

class SelectCarScreen extends StatelessWidget {
  const SelectCarScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final carProvider = Provider.of<SelectCarProvider>(context);

    return Scaffold(
      appBar: myAppBar('Seleccionar Vehículo'),
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
                  'Selecciona un Vehículo', 16, Colors.white, FontWeight.bold)),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
              decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      topRight: Radius.circular(15),
                      bottomRight: Radius.circular(15))),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.check_box,
                    size: 30,
                  ),
                  SizedBox(
                    width: 15,
                  ),
                  myText('Seleccionar', 15, Colors.black, FontWeight.bold)
                ],
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemBuilder: ((BuildContext context, index) {
                return (radioCar(index, carProvider, context));
              }),
              itemCount: 2,
            ),
          ),
        ],
      ),
    );
  }

  Widget radioCar(int index, SelectCarProvider car, BuildContext context) {
    Size size = MediaQuery.of(context).size;
    List<Vehiculo> cars = car.cards;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      decoration: BoxDecoration(
          color: Colors.indigo, borderRadius: BorderRadius.circular(20)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Colors.indigo[900],
              borderRadius: BorderRadius.circular(15),
            ),
            width: size.width / 2.5,
            child: FadeInImage(
              placeholder: const AssetImage('assets/jar-loading.gif'),
              image: AssetImage(cars[index].fotoVehiculo),
            ),
          ),
          Container(
            color: Colors.indigo,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                myText('Placa: ${cars[index].placa}', 14, Colors.white,
                    FontWeight.normal),
                const SizedBox(
                  height: 10,
                ),
                myText('Marca ${cars[index].marca}', 14, Colors.white,
                    FontWeight.normal),
                const SizedBox(
                  height: 10,
                ),
                cars[index].estado == 'H'
                    ? myText('Habilitado', 14, Colors.green, FontWeight.bold)
                    : myText('Desahabilitado', 14, Colors.red, FontWeight.bold),
              ],
            ),
          ),
          Radio(
              activeColor: Colors.white,
              value: index,
              groupValue: car.selectCar,
              onChanged: (value) {
                car.selectCar = value;
              })
        ],
      ),
    );
    // Radio(value: index, groupValue: 1, onChanged: (value) {});
  }
}

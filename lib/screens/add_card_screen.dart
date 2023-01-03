import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:taxi_ya/constant.dart';
import 'package:taxi_ya/models/api_response.dart';
import 'package:taxi_ya/providers/providers.dart';
import 'package:taxi_ya/providers/register_car_provider.dart';
import 'package:taxi_ya/services/services.dart';
import 'package:taxi_ya/ui/input_decorations.dart';

class AddCarScreen extends StatelessWidget {
  AddCarScreen({super.key});
  ImagePicker picker = ImagePicker();

  @override
  Widget build(BuildContext context) {
    final registerCarProvider =
        Provider.of<RegisterCarProvider>(context, listen: false);
    return Scaffold(
      appBar: myAppBar('Registrar Vehículo'),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 30),
        child: SingleChildScrollView(
          child: Form(
            child: Column(
              children: [
                Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                        color: Colors.indigo,
                        borderRadius: BorderRadius.circular(10)),
                    child: textTitle('Datos del Vehículo')),
                const SizedBox(
                  height: 30,
                ),
                TextFormField(
                  autocorrect: false,
                  keyboardType: TextInputType.name,
                  decoration: InputDecorations.authInputDecorations(
                      hintText: '',
                      labelText: 'Nro de Placa',
                      prefixIcon: Icons.numbers_rounded),
                  onChanged: (value) => {registerCarProvider.placa = value},
                ),
                const SizedBox(
                  height: 30,
                ),
                TextFormField(
                  autocorrect: false,
                  keyboardType: TextInputType.name,
                  decoration: InputDecorations.authInputDecorations(
                      hintText: '2015',
                      labelText: 'Año',
                      prefixIcon: Icons.document_scanner),
                  onChanged: (value) => {registerCarProvider.anio = value},
                ),
                const SizedBox(
                  height: 30,
                ),
                TextFormField(
                  autocorrect: false,
                  keyboardType: TextInputType.name,
                  decoration: InputDecorations.authInputDecorations(
                      hintText: 'Toyota',
                      labelText: 'Marca del Vehículo',
                      prefixIcon: Icons.drive_eta_outlined),
                  onChanged: (value) => {registerCarProvider.marca = value},
                ),
                const SizedBox(
                  height: 30,
                ),
                TextFormField(
                  autocorrect: false,
                  keyboardType: TextInputType.name,
                  decoration: InputDecorations.authInputDecorations(
                      hintText: 'Supra',
                      labelText: 'Modelo del vehiculo',
                      prefixIcon: Icons.drive_eta_outlined),
                  onChanged: (value) => {registerCarProvider.modelo = value},
                ),
                const SizedBox(
                  height: 30,
                ),
                textForm('Foto de Papeles del Auto'),
                // const SizedBox(
                //   height: 8,
                // ),
                imageContainer(
                    'fotoPapelesAuto', registerCarProvider.imageCar, context),
                const SizedBox(
                  height: 30,
                ),
                textForm('Foto del Vehículo'),
                const SizedBox(
                  height: 8,
                ),
                imageContainer(
                    'fotoVehiculo', registerCarProvider.imageCar, context),
                const SizedBox(
                  height: 30,
                ),
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(vertical: 5),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      color: Colors.white),
                  child: TextButton(
                    onPressed: registerCarProvider.isLoading
                        ? null
                        : () async {
                            final carService = Provider.of<CarsService>(context,
                                listen: false);

                            ApiResponse response = await carService.store(
                                registerCarProvider.imageCar,
                                registerCarProvider.placa,
                                registerCarProvider.anio,
                                registerCarProvider.marca,
                                registerCarProvider.modelo);

                            response.error == null
                                ? displayDialog(context,
                                    'Solicitud registrada corectamente', true)
                                : displayDialog(context,
                                    'Error al registrar la solicitud', false);
                          },
                    child: Text(
                      registerCarProvider.isLoading ? 'Espere' : 'Registrar',
                      style: TextStyle(
                        fontSize: 19,
                        fontWeight: FontWeight.bold,
                        color: registerCarProvider.isLoading
                            ? Colors.indigo
                            : Colors.blueGrey[900],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void takePhoto(ImageSource source, String imagen, context) async {
    // ImagePicker picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: source);

    final imageCar = Provider.of<RegisterCarProvider>(context, listen: false);

    if (pickedFile != null) {
      // Verificar que no sea null
      imageCar.addImagen(imagen, File(pickedFile.path));
    }
  }

  // Botton en la parte inferior para selecionar imagen
  // image: La imagen que vamos a modificar  context: contexto de la aplicación
  Widget bottonSheet(String image, context) {
    return Container(
      height: 100,
      width: MediaQuery.of(context).size.width,
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      child: Column(
        children: [
          const Text(
            'Selecciona una imagen',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          const SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              TextButton.icon(
                  onPressed: () {
                    takePhoto(ImageSource.gallery, image, context);
                  },
                  icon: const Icon(Icons.image),
                  label: const Text('Galeria')),
              TextButton.icon(
                  onPressed: () {
                    takePhoto(ImageSource.camera, image, context);
                  },
                  icon: const Icon(Icons.add_a_photo),
                  label: const Text('Camera')),
            ],
          )
        ],
      ),
    );
  }

  // Image Container
  // Text: Texto para mostrsar en pantalla
  // image: Imagen a mostrar
  // context de la aplicación
  Widget imageContainer(String imagen, Map<String, File> imagenForm, context) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: Colors.indigo,
          ),
          child: Column(
            children: [
              TextButton.icon(
                  onPressed: () {
                    showModalBottomSheet(
                        context: context,
                        builder: ((builder) => bottonSheet(imagen, context)));
                  },
                  icon: const Icon(
                    Icons.edit,
                    color: Colors.white,
                    size: 22,
                  ),
                  label: const Text(
                    'Tomar Foto',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 15,
                        fontWeight: FontWeight.bold),
                  )),
              Container(
                child: imagenForm[imagen] == null
                    ? const Image(image: AssetImage('assets/no-image.png'))
                    : Image.file(
                        imagenForm[imagen]!,
                        width: 500,
                        height: 500,
                      ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget textTitle(String text) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          text,
          style: const TextStyle(
              fontSize: 17, fontWeight: FontWeight.bold, color: Colors.white),
        ),
        const SizedBox(
          width: 12,
        ),
        const Icon(
          Icons.drive_eta_rounded,
          size: 30,
          color: Colors.lightBlueAccent,
        ),
      ],
    );
  }

  Widget textForm(String text) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 7, horizontal: 30),
      margin: const EdgeInsets.only(bottom: 1),
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(15),
          topRight: Radius.circular(15),
        ),
        color: Colors.indigo,
      ),
      child: Text(
        text,
        style: const TextStyle(
            fontSize: 15, fontWeight: FontWeight.bold, color: Colors.white),
      ),
    );
  }

  void displayDialog(BuildContext context, String text, bool exito) {
    showDialog(
      // barrierDismissible:
      //     true, // Para que se desactiva al presionar fuera del dialogo
      context: context,
      builder: (context) {
        return AlertDialog(
          elevation: 5,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadiusDirectional.circular(15)),
          title: Container(
            alignment: Alignment.center,
            child: Text(
              text,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: exito ? Colors.green[300] : Colors.red[300],
              ),
            ),
          ),
          content: Column(
              mainAxisSize:
                  MainAxisSize.min, // Se adapta al tamaño de los hijos
              children: [
                Icon(
                  exito ? Icons.check : Icons.error_outline_outlined,
                  color: exito ? Colors.green : Colors.red,
                  size: 45,
                ),
              ]),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.popAndPushNamed(context, 'home');
              },
              child: const Text(
                'Salir',
                style: TextStyle(fontSize: 16),
              ),
            ),
            if (!exito)
              const SizedBox(
                width: 10,
              ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text(
                'Regresar',
                style: TextStyle(fontSize: 16),
              ),
            ),
          ],
        );
      },
    );
  }
}

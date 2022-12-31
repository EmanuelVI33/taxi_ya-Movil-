import 'dart:ffi';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:taxi_ya/models/api_response.dart';
import 'package:taxi_ya/providers/providers.dart';
import 'package:taxi_ya/screens/home_screen.dart';
import 'package:taxi_ya/screens/punctation_screen.dart';
import 'package:taxi_ya/services/register_driver.dart';
import 'package:taxi_ya/ui/input_decorations.dart';

class RegisterRequestScreen extends StatelessWidget {
  RegisterRequestScreen({super.key});
  // Map<String, File> imagesForm = {}; // Almacenar la imagenes en un map
  ImagePicker picker = ImagePicker();

  @override
  Widget build(BuildContext context) {
    final registerDriver = Provider.of<DriverProvider>(context, listen: true);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Registrate como Conductor'),
      ),
      backgroundColor: Colors.white,
      body: Container(
        decoration: BoxDecoration(
          color: Colors.grey[200],
        ),
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 10),
          child: Form(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                  decoration: BoxDecoration(
                      borderRadius: const BorderRadius.only(
                          bottomRight: Radius.circular(40),
                          topRight: Radius.circular(20)),
                      color: Colors.blueGrey[600]),
                  child: Column(
                    children: [
                      const Text(
                        'Completar todos los campos',
                        style: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.w700,
                          letterSpacing: 1,
                          color: Colors.white,
                        ),
                        maxLines: 1,
                      ),
                      const SizedBox(
                        height: 12,
                      ),
                      textTitle('Datos del Conductor'),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                // textForm('Carnet de Identidad'),
                TextFormField(
                  autocorrect: false,
                  autofocus: true,
                  keyboardType: TextInputType.name,
                  decoration: InputDecorations.authInputDecorations(
                      hintText: 'CI',
                      labelText: 'Carnet de Identidad',
                      prefixIcon: Icons.person),
                  onChanged: (value) => {registerDriver.ci = value},
                ),
                const SizedBox(
                  height: 30,
                ),
                textForm('Foto de Perfil Conductor'),
                const SizedBox(
                  height: 8,
                ),
                imageContainer('foto', registerDriver.imagenDriver, context),
                const SizedBox(
                  height: 30,
                ),
                textForm('Foto del carnet de identidad (Anverso)'),
                const SizedBox(
                  height: 8,
                ),
                imageContainer(
                    'ciAnverso', registerDriver.imagenDriver, context),
                const SizedBox(
                  height: 30,
                ),
                textForm('Foto del carnet de identidad (Reverso)'),
                const SizedBox(
                  height: 8,
                ),
                imageContainer(
                    'ciReverso', registerDriver.imagenDriver, context),
                const SizedBox(
                  height: 30,
                ),
                textForm('Foto Antecedentes'),
                const SizedBox(
                  height: 8,
                ),
                imageContainer(
                    'fotoAntecedentes', registerDriver.imagenDriver, context),
                const SizedBox(
                  height: 30,
                ),
                textForm('Foto de Licencia de conducir'),
                const SizedBox(
                  height: 8,
                ),
                imageContainer(
                    'fotoLicencia', registerDriver.imagenDriver, context),
                const SizedBox(
                  height: 30,
                ),
                textForm('Foto TIC'),
                const SizedBox(
                  height: 8,
                ),
                imageContainer('fotoTIC', registerDriver.imagenDriver, context),
                const SizedBox(
                  height: 30,
                ),
                Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                        color: Colors.grey[700],
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
                  onChanged: (value) => {registerDriver.placa = value},
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
                  onChanged: (value) => {registerDriver.anio = value},
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
                  onChanged: (value) => {registerDriver.marca = value},
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
                  onChanged: (value) => {registerDriver.modelo = value},
                ),
                const SizedBox(
                  height: 30,
                ),
                textForm('Foto de Papeles del Auto'),
                const SizedBox(
                  height: 8,
                ),
                imageContainer(
                    'fotoPapelesAuto', registerDriver.imagenDriver, context),
                const SizedBox(
                  height: 30,
                ),
                textForm('Foto del Vehículo'),
                const SizedBox(
                  height: 8,
                ),
                imageContainer(
                    'fotoVehiculo', registerDriver.imagenDriver, context),
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
                    onPressed: registerDriver.isLoading
                        ? null
                        : () async {
                            registerDriver.isLoading = true;
                            final register = Provider.of<RegisterDriver>(
                                context,
                                listen: false);

                            final ApiResponse response = await register.store(
                                registerDriver.imagenDriver,
                                registerDriver.ci,
                                registerDriver.placa,
                                registerDriver.anio,
                                registerDriver.marca,
                                registerDriver.modelo);

                            response.error == null
                                ? displayDialog(context,
                                    'Solicitud registrada corectamente', true)
                                : displayDialog(context,
                                    'Error al registrar la solicitud', false);

                            registerDriver.isLoading = false;
                          },
                    child: Text(
                      registerDriver.isLoading ? 'Espere' : 'Enviar Solicitud',
                      style: TextStyle(
                        fontSize: 19,
                        fontWeight: FontWeight.bold,
                        color: registerDriver.isLoading
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

  // takePhoto
  // source: Mandamos el tipo de recurso galeria o camara
  // image: La imagen que deseamos modificar
  void takePhoto(ImageSource source, String imagen, context) async {
    // ImagePicker picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: source);

    final imagenDriver = Provider.of<DriverProvider>(context, listen: false);

    if (pickedFile != null) {
      // Verificar que no sea null
      imagenDriver.addImagen(imagen, File(pickedFile.path));
    }

    // setState(() {
    //   if (pickedFile != null) {
    //     imagesForm[imagen] = File(pickedFile.path);
    //   }
    // });
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
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(30),
                bottomRight: Radius.circular(30)),
            color: Colors.blueGrey[700],
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
      padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 30),
      decoration: BoxDecoration(
          borderRadius: const BorderRadius.only(
            bottomRight: Radius.circular(20),
          ),
          color: Colors.blueGrey[400]),
      child: Text(
        text,
        style: const TextStyle(
            fontSize: 14, fontWeight: FontWeight.bold, color: Colors.white),
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

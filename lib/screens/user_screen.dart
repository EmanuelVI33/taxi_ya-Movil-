import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:taxi_ya/constant.dart';
import 'package:taxi_ya/models/vehiculo.dart';
import 'package:taxi_ya/providers/providers.dart';
import 'package:taxi_ya/providers/select_car_provider.dart';
import 'package:taxi_ya/services/services.dart';

class UserScreen extends StatefulWidget {
  const UserScreen({super.key});

  @override
  State<UserScreen> createState() => _UserScreenState();
}

class _UserScreenState extends State<UserScreen> {
  @override
  void initState() {
    super.initState();
    final userService = Provider.of<UserService>(context, listen: false);
    userService.loaded(context);
  }

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);

    return userProvider.loading
        ? const CircularProgressIndicator()
        : screenUser(context, userProvider);
  }
}

Widget screenUser(BuildContext context, UserProvider userProvider) {
  Size size = MediaQuery.of(context).size;
  final driver = Provider.of<HomeProvider>(context).isDriver;

  return SingleChildScrollView(
    child: Column(
      children: [
        _parteSuperior(context, userProvider, size),
        _iconoPasajero(context, userProvider, size, driver),
        _datosUser(context, userProvider, size),
        _accesoDirectos(context, userProvider, size, driver),
        driver
            ? _vehiculoSeleccionado(context, userProvider, size, driver)
            : const SizedBox(),
        // Diseño estrellas
      ],
    ),
  );
}

Widget _vehiculoSeleccionado(
    BuildContext context, UserProvider userProvider, Size size, driver) {
  final carsProvider = Provider.of<SelectCarProvider>(context);
  List<Vehiculo> cars = carsProvider.cards;
  int select = carsProvider.selectCar;

  return (Container(
    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
    margin: const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
    decoration: BoxDecoration(
        color: Colors.indigo, borderRadius: BorderRadius.circular(20)),
    child: Column(
      children: [
        myText('Vehículo', 16, Colors.white, FontWeight.bold),
        const SizedBox(
          height: 10,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
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
                image: AssetImage(cars[select].fotoVehiculo),
              ),
            ),
            const SizedBox(
              width: 10,
            ),
            Container(
              color: Colors.indigo,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  myText('Placa: ${cars[select].placa}', 14, Colors.white,
                      FontWeight.normal),
                  const SizedBox(
                    height: 10,
                  ),
                  myText('Marca: ${cars[select].marca}', 14, Colors.white,
                      FontWeight.normal),
                  const SizedBox(
                    height: 10,
                  ),
                  cars[select].estado == 'H'
                      ? myText('Habilitado', 14, Colors.green, FontWeight.bold)
                      : myText(
                          'Desahabilitado', 14, Colors.red, FontWeight.bold),
                ],
              ),
            ),
          ],
        ),
      ],
    ),
  ));
}

Widget _accesoDirectos(
    BuildContext context, UserProvider userProvider, Size size, bool driver) {
  return Column(
    mainAxisAlignment: MainAxisAlignment.center,
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          columnText(
              driver ? 'Seleccionar Vehículo' : 'Solicitar Viaje',
              driver ? Icons.drive_eta : Icons.map_outlined,
              size,
              driver ? 'select_ car' : 'service',
              context),
          columnText('Historial de Viaje', Icons.account_balance_wallet_rounded,
              size, 'travel_history', context),
        ],
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          columnText(
              driver ? 'Agregar Vehículo' : 'Postular Conductor',
              Icons.drive_eta_rounded,
              size,
              driver ? 'add_car' : 'register_driver',
              context),
          columnText(
              'Editar Perfil', Icons.edit, size, 'edit_profile', context),
        ],
      ),
    ],
  );
}

Container columnText(
    String text, IconData icon, Size size, String route, BuildContext context) {
  return Container(
    margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
    padding: const EdgeInsets.all(10),
    width: size.width / 2.50,
    decoration: BoxDecoration(
        color: Colors.white, borderRadius: BorderRadius.circular(30)),
    child: TextButton(
      onPressed: () {
        Navigator.pushNamed(context, route);
      },
      child: Column(
        children: [
          Icon(
            icon,
            size: 30,
          ),
          const SizedBox(
            height: 10,
          ),
          myText(text, 10, Colors.black, FontWeight.normal),
        ],
      ),
    ),
  );
}

Container _datosUser(
    BuildContext context, UserProvider userProvider, Size size) {
  return Container(
    width: double.infinity,
    decoration: BoxDecoration(
        color: Colors.blue[800], borderRadius: BorderRadius.circular(30)),
    margin: const EdgeInsets.symmetric(vertical: 20, horizontal: 15),
    padding: const EdgeInsets.symmetric(vertical: 20),
    child: Column(
      children: [
        myText('Datos del usuario', 17, Colors.white, FontWeight.w900),
        const SizedBox(
          height: 20,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
              backgroundColor: Colors.blueGrey[800],
              child: myText(
                  textoAvatar(userProvider.nombre, userProvider.apellido),
                  16,
                  Colors.white,
                  FontWeight.bold),
            ),
            const SizedBox(
              width: 30,
            ),
            myText('Nombre : ${userProvider.nombre}', 15, Colors.white,
                FontWeight.normal),
          ],
        ),
        const SizedBox(
          height: 15,
        ),
        myText('Apellido(s) : ${userProvider.apellido}', 15, Colors.white,
            FontWeight.normal),
        const SizedBox(
          height: 15,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.phone_android, size: 40, color: Colors.grey[800]),
            const SizedBox(
              width: 10,
            ),
            myText('Teléfono : ${userProvider.telefono}', 15, Colors.white,
                FontWeight.normal),
          ],
        ),
        const SizedBox(
          height: 15,
        ),
      ],
    ),
  );
}

Container _iconoPasajero(
    BuildContext context, UserProvider userProvider, Size size, bool driver) {
  return Container(
    margin: const EdgeInsets.only(top: 20),
    padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
    decoration: BoxDecoration(
        color: Colors.white, borderRadius: BorderRadius.circular(15)),
    child: Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              driver ? Icons.drive_eta : Icons.person_pin,
              size: 40,
            ),
            const SizedBox(
              width: 30,
            ),
            Text(driver ? 'Modo Conductor' : 'Modo Pasajero',
                style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                    color: Colors.blueGrey[900])),
            const SizedBox(
              width: 30,
            ),
          ],
        )
      ],
    ),
  );
}

// Recibe el contexto, el provider de usuario, y el tamaño de la pantalla
Column _parteSuperior(
    BuildContext context, UserProvider userProvider, Size size) {
  return Column(
    children: [
      const SizedBox(
        height: 10,
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Text(
            'Foto de Perfil',
            style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.bold,
                color: Colors.lightBlue[900]),
          ),
          IconButton(
            icon: const Icon(Icons.edit),
            color: Colors.black,
            iconSize: 25,
            onPressed: () {},
          ),
        ],
      ),
      Container(
        margin: const EdgeInsets.only(top: 5),
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Colors.indigo[800],
        ),
        width: size.width / 1.35,
        child: (userProvider.image == '')
            ? const Image(
                image: AssetImage('assets/user.jpg'),
                fit: BoxFit.cover,
                height: 300,
              )
            : FadeInImage(
                placeholder: const AssetImage('assets/jar-loading.gif'),
                image: NetworkImage('$url/${userProvider.image}'),
                fit: BoxFit.cover, // Para que se ajuste la imagen a la altura
                fadeInDuration: const Duration(
                    milliseconds: 200), // Duración de la tracción de la imagen
              ),
      ),
    ],
  );
}

// Devuel la primer letra delnombre y apellido concatenado
String textoAvatar(String nombre, String apellido) {
  return (nombre == '' || apellido == '')
      ? 'US'
      : (nombre.substring(0, 1) + apellido.substring(0, 1)).toUpperCase();
}

// Container(
//               margin: const EdgeInsets.only(top: 20),
//               padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
//               decoration: BoxDecoration(
//                 borderRadius: BorderRadius.circular(30),
//                 color: Colors.blue[800],
//               ),
//               width: size.width / 1.25,
//               child: Column(
//                 children: [
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     crossAxisAlignment: CrossAxisAlignment.center,
//                     children: [
//                       const Text(
//                         "Foto de Perfil",
//                         style: TextStyle(
//                             fontSize: 15,
//                             fontWeight: FontWeight.bold,
//                             color: Colors.white),
//                       ),
//
//                     ],
//                   ),
//                   const SizedBox(
//                     height: 10,
//                   ),
//                   (userProvider.image == '')
//                       ? Image(
//                           image: const AssetImage('assets/no-image.png'),
//                           fit: BoxFit.cover,
//                           width: size.width / 2,
//                           height: 300,
//                         )
//                       : FadeInImage(
//                           placeholder: const AssetImage('assets/no-image.png'),
//                           image: NetworkImage('$url/${userProvider.image}'),
//                           // width: size.width / 2,
//                           // height: 300, // Se ajusta a la pantalla
//                           fit: BoxFit
//                               .cover, // Para que se ajuste la imagen a la altura
//                           fadeInDuration: const Duration(
//                               milliseconds:
//                                   200), // Duración de la tracción de la imagen
//                         ),
//                 ],
//               ),
//             ),
//             Text(userProvider.nombre),
//             const SizedBox(
//               height: 10,
//             ),
//             Text(userProvider.apellido),
//             const SizedBox(
//               height: 10,
//             ),
//             Text(userProvider.telefono),
//             const SizedBox(
//               height: 10,
//             ),
//             Text(userProvider.email),
//             const SizedBox(
//               height: 10,
//             ),
//             TextButton(
//                 onPressed: () {
//                   print('$url/${userProvider.image}');
//                 },
//                 child: Text("Ver url imagen")),
// : Image(
//     // http://192.168.0.8/storage/cliente/8xnHBA73nPkphA7zMLV6Y6qhSEcxzEwYzeN0X99n.png
//     image: NetworkImage('$url/${userProvider.image}'),
//   ),

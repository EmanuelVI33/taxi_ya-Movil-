import 'package:flutter/material.dart';

class RequestServiceScreen extends StatelessWidget {
  RequestServiceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Maps in Flutter'),
          centerTitle: true,
        ),
        body: Text("Registra Viaje"));
  }
}

// class RequestServiceScreen extends StatefulWidget {
//   _RequestServiceScreenState createState() => _RequestServiceScreenState();
// }

// class _RequestServiceScreenState extends State<RequestServiceScreen> {
//   late GoogleMapController mapController;

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         // appBar: AppBar(
//         //   title: Text("Viajes"),
//         // ),
        
//         body: GoogleMap(
//       initialCameraPosition: CameraPosition(target: LatLng(344353, 454545),
//       ),
//     ));
//   }
// }

// class RequestServiceScreen extends StatefulWidget {
//   const RequestServiceScreen({super.key, required this.title});

//   final String title;

//   @override
//   State<RequestServiceScreen> createState() => _RequestServiceScreenState();
// }

// class _RequestServiceScreenState extends State<RequestServiceScreen> {
//   LatLng position = const LatLng(-17.775329220642107, -63.18161601007854);
//   LatLng position2 = const LatLng(-17.783713981813097, -63.1818784678571);

//   MapType mapType = MapType.normal;
//   BitmapDescriptor icon = BitmapDescriptor.defaultMarker;
//   bool isShowInfo = false;
//   late GoogleMapController controller;

//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//     getIcons();
//   }

//   getIcons() async {
//     // Especificamos la configuración y la ruta de la imagen
//     var icon = await BitmapDescriptor.fromAssetImage(
//         const ImageConfiguration(devicePixelRatio: 2.5), "img/driver.png");
//     setState(() {
//       this.icon = icon;
//     });
//   }

//   onMapCreated(GoogleMapController controller) {
//     this.controller = controller;
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(widget.title),
//       ),
//       body: Stack(
//         children: [
//           GoogleMap(
//             initialCameraPosition: CameraPosition(
//               // Atributo para especificar donde va iniciar la camara
//               target: position,
//               zoom: 13,
//               bearing: 0, // Es la orientación
//               tilt: 90, // Inclinación 0 .. 90
//             ),
//             onMapCreated: onMapCreated,
//             mapType: mapType,
//             markers: {
//               Marker(
//                 markerId: MarkerId(position.toString()),
//                 position: position,
//                 icon: icon,
//                 alpha: 0.8, // Opacidad del marcador
//                 anchor: const Offset(0.2, 0.2), // Permite mover el marcador
//                 draggable: true, // Permite mover el marcador
//                 onDragEnd: onDragEnd,
//                 onTap: () => setState(() {
//                   controller.animateCamera(CameraUpdate.newCameraPosition(
//                       CameraPosition(
//                           target:
//                               LatLng(-17.775177836641845, -63.195931085558826),
//                           zoom: 10)));
//                 this.isShowInfo = !this.isShowInfo;
//                 infoWindow: InfoWindow(
//                     title: "Marca tu dirección",
//                     snippet:
//                         "Latitud ${position.latitude} - Longitud ${position.longitude}"),
//                 // zIndex: 1,
//               ),
//               // Marker(
//               //   markerId: MarkerId(position2.toString()),
//               //   position: position2,
//               //   alpha: 0.8, // Opacidad del marcador
//               //   anchor: const Offset(0.2, 0.2), // Permite mover el marcador
//               //   draggable: true, // Permite mover el marcador
//               //   onDragEnd: onDragEnd,
//               //   zIndex: 2, // Tiene un valor mayor, tendra mayor importancia
//               //   // onTap: () => setState(() {
//               //   //   this.isShowInfo = !this.isShowInfo;
//               //   // }),
//               // ),
//             },
//           ),
//           SpeedDial(
//             animatedIcon: AnimatedIcons.menu_close,
//             overlayColor: Colors.black,
//             overlayOpacity: 0.5,
//             elevation: 8.0,
//             switchLabelPosition: true,
//             direction: SpeedDialDirection.down,
//             children: [
//               SpeedDialChild(
//                   label: "Normal",
//                   child: Icon(Icons.map_outlined),
//                   onTap: () => setState(() => mapType = MapType.normal)),
//               SpeedDialChild(
//                   label: "Satelital",
//                   child: Icon(Icons.satellite),
//                   onTap: () => setState(() => mapType = MapType.satellite)),
//               SpeedDialChild(
//                   label: "Terrenal",
//                   child: Icon(Icons.map_outlined),
//                   onTap: () => setState(() => mapType = MapType.terrain)),
//               SpeedDialChild(
//                   label: "Hibrido",
//                   child: Icon(Icons.map_outlined),
//                   onTap: () => setState(() => mapType = MapType.hybrid)),
//             ],
//           ),
//           Visibility(
//               visible: isShowInfo,
//               child: MarketInformation(
//                   "Mi ubicación", position, "img/driver.png")),
//         ],
//       ),
//     );
//   }

//   onDragEnd(LatLng position) {
//     print("New position ${position}");
//   }
// }

import 'package:taxi_ya/models/models.dart';

class Carrera {
  String id;
  String fecha;
  String hora;
  String estado;
  int precio;
  User user;

  Carrera({
    required this.id,
    required this.fecha,
    required this.hora,
    required this.estado,
    required this.precio,
    required this.user,
  });

  factory Carrera.fromJson(Map<String, dynamic> json) {
    return Carrera(
        id: json['id'],
        fecha: json['fecha'],
        hora: json['hora'],
        estado: json['estado'],
        precio: int.parse(json['precio']),
        user: User.fromJson(json));
  }

  static List<Carrera> listCarrera(Map<String, dynamic> json) {
    List<Carrera> list = [];
    json.forEach((key, value) {
      Carrera vehiculo = Carrera.fromJson(json[key]);
      list.add(vehiculo);
    });

    return list;
  }
}

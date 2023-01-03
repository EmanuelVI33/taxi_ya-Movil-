class Vehiculo {
  String placa;
  String marca;
  String modelo;
  String anio;
  String estado;
  String fotoVehiculo;

  Vehiculo({
    required this.placa,
    required this.marca,
    required this.modelo,
    required this.anio,
    required this.estado,
    required this.fotoVehiculo,
  });

  factory Vehiculo.fromJson(Map<String, dynamic> json) {
    return Vehiculo(
      placa: json['placa'],
      marca: json['marca'],
      modelo: json['modelo'],
      anio: json['anio'],
      estado: json['estado'],
      fotoVehiculo: json['foto_vehiculo'],
    );
  }

  static List<Vehiculo> listVehiculo(Map<String, dynamic> json) {
    List<Vehiculo> list = [];
    json.forEach((key, value) {
      Vehiculo vehiculo = Vehiculo.fromJson(json[key]);
      list.add(vehiculo);
    });

    return list;
  }
}

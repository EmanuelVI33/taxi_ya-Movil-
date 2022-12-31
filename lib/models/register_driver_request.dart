import 'dart:io';

class RegisterDriverRequest {
  String ci;
  File foto;
  File ciAnverso;
  File ciReverso;
  File fotoAntecedentes;
  File fotoLicencia;
  String placa;
  String anio;
  String modelo;
  String marca;
  File fotoPapelesAuto;
  File fotoVehiculo;

  RegisterDriverRequest({
    required this.ci,
    required this.foto,
    required this.ciAnverso,
    required this.ciReverso,
    required this.fotoAntecedentes,
    required this.fotoLicencia,
    required this.placa,
    required this.anio,
    required this.modelo,
    required this.marca,
    required this.fotoPapelesAuto,
    required this.fotoVehiculo,
  });

  // factory RegisterDriverRequest.fromJson();
}

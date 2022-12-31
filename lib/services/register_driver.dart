import 'package:http/http.dart' as http;
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:taxi_ya/constant.dart';
import 'package:taxi_ya/models/api_response.dart';

class RegisterDriver extends ChangeNotifier {
  // Almecenar Solicitud de COnductores
  Future<ApiResponse> store(Map<String, File> imagen, String ci, String placa,
      String anio, String marca, String modelo) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    ApiResponse apiResponse = ApiResponse();
    String token = prefs.getString('token') ?? '';
    try {
      final response = await http.post(Uri.parse(solicitud), headers: {
        'Accept': 'application/json',
        'Authorization': 'Bearer $token'
      }, body: {
        'ci': ci,
        'foto': imagen['foto'].toString(),
        'fotoCI_Anverso': imagen['ciAnverso'].toString(),
        'fotoCI_Reverso': imagen['ciReverso'].toString(),
        'fotoAntecedentes': imagen['fotoAntedentes'].toString(),
        'fotoLicencia': imagen['fotoLicencia'].toString(),
        'fotoTIC': imagen['fotoTIC'].toString(),
        // Vehiculo
        'placa': placa,
        'anio': anio,
        'marca': marca,
        'modelo': modelo,
        'fotoPapelesAuto': imagen['fotoPapelesAuto'].toString(),
        'fotoVehiculo': imagen['fotoVehiculo'].toString(),
      });

      if (response.statusCode != 201) {
        apiResponse.error = "Ha ocurrido un error";
      }
    } catch (e) {
      apiResponse.error = "Ha ocurrido un error";
    }
    return apiResponse;
  }
}

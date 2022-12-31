import 'package:dio/dio.dart';
// import 'package:http/http.dart' as http;
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:taxi_ya/constant.dart';
import 'package:taxi_ya/models/api_response.dart';

class RegisterDriver extends ChangeNotifier {
  Dio dio = Dio();

  // Almecenar Solicitud de Conductores
  Future<ApiResponse> store(Map<String, File> imagen, String ci, String placa,
      String anio, String marca, String modelo) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    ApiResponse apiResponse = ApiResponse();
    String token = prefs.getString('token') ?? '';

    FormData formData = FormData.fromMap({
      'ci': ci,
      'foto': await MultipartFile.fromFile(imagen['foto']!.path),
      'fotoCI_Anverso': await MultipartFile.fromFile(imagen['ciAnverso']!.path),
      'fotoCI_Reverso': await MultipartFile.fromFile(imagen['ciReverso']!.path),
      'fotoAntecedentes':
          await MultipartFile.fromFile(imagen['fotoAntecedentes']!.path),
      'fotoLicencia':
          await MultipartFile.fromFile(imagen['fotoLicencia']!.path),
      'fotoTIC': await MultipartFile.fromFile(imagen['fotoTIC']!.path),
      // Vehiculo
      'placa': placa,
      'anio': anio,
      'marca': marca,
      'modelo': modelo,
      'fotoPapelesAuto':
          await MultipartFile.fromFile(imagen['fotoPapelesAuto']!.path),
      'fotoVehiculo':
          await MultipartFile.fromFile(imagen['fotoVehiculo']!.path),
    });

    try {
      await dio
          .post(solicitud,
              data: formData,
              options: Options(headers: {
                'Accept': 'application/json',
                'Authorization': 'Bearer $token'
              }))
          .then((value) {
        if (value.statusCode == 201) {
          apiResponse.data = 'Solitud Enviada Corectamente';
        } else {
          apiResponse.data = 'Error al enviar la solicitud';
        }
      });

      // final response = await http.post(Uri.parse(solicitud), headers: {
      //   'Accept': 'application/json',
      //   'Authorization': 'Bearer $token'
      // }, body: {
      //   'ci': ci,
      //   'foto': imagen['foto'],
      //   'fotoCI_Anverso': imagen['ciAnverso'],
      //   'fotoCI_Reverso': imagen['ciReverso'],
      //   'fotoAntecedentes': imagen['fotoAntedentes'],
      //   'fotoLicencia': imagen['fotoLicencia'],
      //   'fotoTIC': imagen['fotoTIC'],
      //   // Vehiculo
      //   'placa': placa,
      //   'anio': anio,
      //   'marca': marca,
      //   'modelo': modelo,
      //   'fotoPapelesAuto': imagen['fotoPapelesAuto'].toString(),
      //   'fotoVehiculo': imagen['fotoVehiculo'].toString(),
      // });

      // if (response.statusCode != 201) {
      //   apiResponse.error = "Ha ocurrido un error";
      // }
    } catch (e) {
      apiResponse.error = "Ha ocurrido un error";
    }
    return apiResponse;
  }
}

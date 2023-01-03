import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:taxi_ya/models/models.dart';
import 'package:taxi_ya/constant.dart';
import 'package:taxi_ya/models/vehiculo.dart';
import 'package:taxi_ya/providers/providers.dart';

class CarsService extends ChangeNotifier {
  // final storage = const FlutterSecureStorage();

  static const headers = {
    'Accept': 'application/json',
  };

  Future<ApiResponse> getCars() async {
    ApiResponse apiResponse = ApiResponse();
    Map<String, dynamic> cars = {
      '0': {
        'placa': '234frd',
        'marca': 'Toyota',
        'modelo': 'Supra',
        'anio': '2015',
        'estado': 'H',
        'foto_vehiculo': 'assets/user.jpg',
      },
      '1': {
        'placa': '74f9ad',
        'marca': 'Nissan',
        'modelo': 'Portage',
        'anio': '2012',
        'estado': 'H',
        'foto_vehiculo': 'assets/user.jpg',
      },
      // '2': {
      //   'placa': '234frd',
      //   'marca': 'Toyota',
      //   'foto_vehiculo': 'assets/user.jpg'
      // },
    };

    List<Vehiculo> listCars = Vehiculo.listVehiculo(cars);

    apiResponse.data = listCars;
    return apiResponse;
  }

  Future<ApiResponse> store(Map<String, File> imagen, String placa, String anio,
      String marca, String modelo) async {
    ApiResponse apiResponse = ApiResponse();

    apiResponse.data = 'Vehículo registrado exitosamente';

    return apiResponse;
  }
}

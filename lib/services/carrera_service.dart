import 'dart:io';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:taxi_ya/models/carrera.dart';
import 'package:taxi_ya/models/models.dart';
import 'package:taxi_ya/constant.dart';
import 'package:taxi_ya/models/vehiculo.dart';
import 'package:taxi_ya/providers/providers.dart';

class CarreraService extends ChangeNotifier {
  // final storage = const FlutterSecureStorage();

  static const headers = {
    'Accept': 'application/json',
  };

  Future<ApiResponse> get(String userID) async {
    ApiResponse apiResponse = ApiResponse();
    Map<String, dynamic> cars = {
      '0': {
        'id': '1',
        'fecha': '12/10/2022',
        'hora': '8:11 AM',
        'estado': 'F',
        'precio': '22',
        // 'user_driver': {
        //   'id': 2,
        //   'nombre': 'Emanuel',
        //   'apellido': 'Vaca Ibañez',
        //   'role': ['cliente'],
        // },
        'user': {
          'id': 3,
          'nombre': 'Roberto',
          'apellido': 'Vaca Torrez',
          'role': ['cliente'],
        },
      },
      '1': {
        'id': '2',
        'fecha': '12/10/2022',
        'hora': '13:11 PM',
        'estado': 'F',
        'precio': '17',
        // 'user_driver': {
        //   'id': 2,
        //   'nombre': 'Emanuel',
        //   'apellido': 'Vaca Ibañez',
        //   'role': ['cliente'],
        // },
        'user': {
          'id': 3,
          'nombre': 'Rodrigo',
          'apellido': 'Carrasco Torrez',
          'role': ['cliente'],
        },
      },
      '2': {
        'id': '3',
        'fecha': '14/10/2022',
        'hora': '9:23 AM',
        'estado': 'R',
        'precio': '23',
        'user_driver': {
          'id': 2,
          'nombre': 'Emanuel',
          'apellido': 'Vaca Ibañez'
        },
        'user': {'id': 3, 'nombre': 'Rodrigo', 'apellido': 'Carrasco Torrez'},
        'role': ['cliente'],
      },
    };

    List<Carrera> listCars = Carrera.listCarrera(cars);

    apiResponse.data = listCars;
    return apiResponse;
  }

  // Future<ApiResponse> store(Map<String, File> imagen, String placa, String anio,
  //     String marca, String modelo) async {
  //   ApiResponse apiResponse = ApiResponse();

  //   apiResponse.data = 'Vehículo registrado exitosamente';

  //   return apiResponse;
  // }
}

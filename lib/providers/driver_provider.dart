import 'dart:io';
import 'package:flutter/material.dart';

class DriverProvider extends ChangeNotifier {
  String? _ci = '';
  String? _placa = '';
  String? _anio = '';
  String? _marca = '';
  String? _modelo = '';
  Map<String, File> _imagenDriver = {}; // Imagenes de todos los coductores
  bool _isDriver = false;
  bool _isLoading = false;

  addImagen(String key, File? imagen) {
    if (imagen != null) {
      _imagenDriver[key] = imagen;
      notifyListeners();
    }
  }

  get imagenDriver => _imagenDriver;

  set isDriver(isDriver) {
    _isDriver = isDriver;
  }

  get isDriver => _isDriver;

  set ci(ci) {
    _ci = ci;
  }

  get ci => _ci;

  set placa(placa) {
    _placa = placa;
  }

  get placa => _placa;

  set anio(anio) {
    _anio = anio;
  }

  get anio => _anio;

  set marca(marca) {
    _marca = marca;
  }

  get marca => _marca;

  set modelo(modelo) {
    _modelo = modelo;
  }

  get modelo => _modelo;

  set isLoading(isLoading) {
    _isLoading = isLoading;
    notifyListeners();
  }

  get isLoading => _isLoading;
}

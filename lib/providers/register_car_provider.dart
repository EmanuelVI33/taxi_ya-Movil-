import 'dart:io';
import 'package:flutter/material.dart';

class RegisterCarProvider extends ChangeNotifier {
  String? _placa = '';
  String? _anio = '';
  String? _marca = '';
  String? _modelo = '';
  Map<String, File> _imageCar = {}; // Imagenes de todos los coductores
  bool _isLoading = false;

  addImagen(String key, File? imagen) {
    if (imagen != null) {
      _imageCar[key] = imagen;
      notifyListeners();
    }
  }

  get imageCar => _imageCar;

  set imageCar(imageCar) {
    _imageCar = imageCar;
  }

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

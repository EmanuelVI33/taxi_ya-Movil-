import 'package:flutter/cupertino.dart';
import 'package:taxi_ya/models/carrera.dart';
import 'package:taxi_ya/models/vehiculo.dart';

class HistoryProvider extends ChangeNotifier {
  List<Carrera> _carreras = [];

  get carreras => _carreras;

  set carreras(cards) {
    _carreras = cards;
    notifyListeners();
  }

  addCarrera(Carrera vehiculo) {
    _carreras.add(vehiculo);
    notifyListeners();
  }

  bool isNull() {
    return _carreras.isEmpty;
  }
}

import 'package:flutter/cupertino.dart';
import 'package:taxi_ya/models/vehiculo.dart';

class SelectCarProvider extends ChangeNotifier {
  List<Vehiculo> _cars = [];
  int _selectCar = 0;

  get cards => _cars;

  set cards(cards) {
    _cars = cards;
  }

  get selectCar => _selectCar;

  set selectCar(selectCar) {
    _selectCar = selectCar;
    notifyListeners();
  }

  addCard(Vehiculo vehiculo) {
    _cars.add(vehiculo);
  }

  bool isNull() {
    return _cars.isEmpty;
  }
}

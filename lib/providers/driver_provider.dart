import 'package:flutter/cupertino.dart';

class DriverProvider extends ChangeNotifier {
  bool _isDriver = false;

  set isDriver(isDriver) {
    _isDriver = isDriver;
  }

  get isDriver => _isDriver;
}

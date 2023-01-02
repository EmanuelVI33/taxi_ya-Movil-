import 'package:flutter/material.dart';
import 'package:taxi_ya/screens/request_service_screen.dart';
import 'package:taxi_ya/screens/screens.dart';

class HomeProvider extends ChangeNotifier {
  int _actualPage = 0;
  bool _isDriver = false;

  final List<Widget> _pages = [
    const UserScreen(),
    RequestServiceScreen(),
  ];

  set actualPage(page) {
    _actualPage = page;
    notifyListeners();
  }

  int get actualPage => _actualPage;

  set isDriver(isDriver) {
    _isDriver = isDriver;
    notifyListeners();
  }

  get isDriver => _isDriver;

  List<Widget> get pages => _pages;
}

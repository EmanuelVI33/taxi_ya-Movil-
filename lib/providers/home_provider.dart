import 'package:flutter/cupertino.dart';
import 'package:taxi_ya/screens/screens.dart';

class HomeProvider extends ChangeNotifier {
  int _actualPage = 0;
  bool _isDriver = false;

  final List<Widget> _pages = [
    const UserScreen(),
    const RequestServiceScreen(),
  ];

  set actualPage(page) {
    _actualPage = page;
    notifyListeners();
  }

  int get actualPage => _actualPage;

  set isDriver(isDriver) {
    _isDriver = isDriver;
    _pages.removeAt(0);
    if (_isDriver) {
      _pages.insert(0, const DriverScreen());
    } else {
      _pages.insert(0, const UserScreen());
    }
    notifyListeners();
  }

  get isDriver => _isDriver;

  List<Widget> get pages => _pages;
}

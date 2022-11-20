import 'package:flutter/cupertino.dart';
import 'package:taxi_ya/screens/screens.dart';

class HomeProvider extends ChangeNotifier {
  int _actualPage = 0;

  final List<Widget> _pages = [
    const UserScreen(),
    const RequestServiceScreen(),
  ];

  set actualPage(page) {
    _actualPage = page;
    notifyListeners();
  }

  int get actualPage => _actualPage;

  List<Widget> get pages => _pages;
}

import 'package:flutter/material.dart';
import 'package:taxi_ya/models/user.dart';
import 'package:taxi_ya/screens/login_screen.dart';
import 'package:taxi_ya/screens/services_taxi/request_service.dart';
import 'package:taxi_ya/screens/user/user_screen.dart';
import 'package:taxi_ya/services/user_service.dart';
import 'package:taxi_ya/theme/app_theme.dart';

class HomeScreen extends StatefulWidget {
  // final int userID;
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _actual_page = 0;
  final List<Widget> _pages = [
    const UserScreen(),
    const RequestServiceScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Pagina Principal',
      theme: AppTheme.lightTheme,
      home: Scaffold(
        appBar: _buildAppBar(),
        body: _pages[_actual_page],
        bottomNavigationBar: BottomNavigationBar(
            currentIndex: _actual_page,
            onTap: (index) {
              setState(() {
                _actual_page = index;
              });
            },
            items: const [
              BottomNavigationBarItem(
                  icon: Icon(Icons.home), label: 'Principal'),
              BottomNavigationBarItem(
                  icon: Icon(Icons.map_rounded), label: 'Viajar'),
            ]),
      ),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      leading: const Icon(
        Icons.menu,
        size: 30,
      ),
      actions: [
        IconButton(
          icon: const Icon(
            Icons.logout_outlined,
            size: 32,
          ),
          onPressed: () {
            logout().then((value) => {
                  Navigator.of(context).pushAndRemoveUntil(
                      MaterialPageRoute(
                          builder: (context) => const LoginScreen()),
                      (route) => false)
                });
          },
        ),
      ],
      centerTitle: true,
      title: const Text(
        'Pagina Principal',
        style: TextStyle(
          fontSize: 17,
        ),
      ),
      elevation: 0,
      backgroundColor: Colors.indigo,
    );
  }
}

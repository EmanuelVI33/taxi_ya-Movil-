import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:taxi_ya/providers/providers.dart';
import 'package:taxi_ya/screens/login_screen.dart';
import 'package:taxi_ya/services/auth_service.dart';
import 'package:taxi_ya/theme/app_theme.dart';
import 'package:taxi_ya/widgets/widgets.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    final homeProvider = Provider.of<HomeProvider>(context);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Pagina Principal',
      theme: AppTheme.lightTheme,
      home: Scaffold(
        appBar: _builderAppBar(context),
        drawer: const LateralMenu(),
        body: homeProvider.pages[homeProvider.actualPage],
        bottomNavigationBar: BottomNavigationBar(
            currentIndex: homeProvider.actualPage,
            onTap: (index) {
              setState(() {
                homeProvider.actualPage = index;
              });
            },
            items: [
              homeProvider.isDriver
                  ? const BottomNavigationBarItem(
                      icon: Icon(Icons.map_rounded), label: 'Modo conductor')
                  : const BottomNavigationBarItem(
                      icon: Icon(Icons.home), label: 'Principal'),
              const BottomNavigationBarItem(
                  icon: Icon(Icons.map_rounded), label: 'Viajar'),
            ]),
      ),
    );
  }

  AppBar _builderAppBar(BuildContext context) {
    final userProvider = Provider.of<AuthService>(context, listen: false);
    return AppBar(
      actions: [
        IconButton(
          icon: const Icon(
            Icons.logout_outlined,
            size: 32,
          ),
          onPressed: () {
            userProvider.logout().then((_) => {
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

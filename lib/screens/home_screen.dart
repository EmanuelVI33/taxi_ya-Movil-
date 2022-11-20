import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:taxi_ya/providers/home_provider.dart';
import 'package:taxi_ya/theme/app_theme.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    final homeProvider = Provider.of<HomeProvider>(context, listen: false);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Pagina Principal',
      theme: AppTheme.lightTheme,
      home: Scaffold(
        appBar: _builderAppBar(context),
        body: homeProvider.pages[homeProvider.actualPage],
        bottomNavigationBar: BottomNavigationBar(
            currentIndex: homeProvider.actualPage,
            onTap: (index) {
              setState(() {
                homeProvider.actualPage = index;
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

  AppBar _builderAppBar(BuildContext context) {
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
            // logout().then((value) => {
            //       Navigator.of(context).pushAndRemoveUntil(
            //           MaterialPageRoute(
            //               builder: (context) => const LoginScreen()),
            //           (route) => false)
            //     });
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

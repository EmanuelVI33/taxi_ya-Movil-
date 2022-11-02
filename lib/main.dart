import 'package:flutter/material.dart';
import 'package:taxi_ya/screens/screens.dart';
import 'package:taxi_ya/theme/app_theme.dart';

void main() => runApp(const MyApp());

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Pagina Principal',
      initialRoute: 'login',
      routes: {
        'login': (_) => const LoginScreen(),
        'home': (_) => HomeScreen(),
        'register': (_) => const RegisterScreen(),
      },
      theme: AppTheme.lightTheme,
    );
  }
}

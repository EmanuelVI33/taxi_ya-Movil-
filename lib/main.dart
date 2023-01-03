import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:taxi_ya/providers/providers.dart';
import 'package:taxi_ya/screens/register_driver_screen.dart';
import 'package:taxi_ya/screens/screens.dart';
import 'package:taxi_ya/services/services.dart';
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
    return MultiProvider(providers: [
      ChangeNotifierProvider(
        create: (_) => AuthService(),
      ),
      ChangeNotifierProvider(create: (_) => HomeProvider()),
      ChangeNotifierProvider(
        create: (_) => UserProvider(),
      ),
      ChangeNotifierProvider(
        create: (_) => DriverProvider(),
      ),
      ChangeNotifierProvider(
        create: (_) => UserService(),
      ),
      ChangeNotifierProvider(
        create: (_) => RegisterDriver(),
      ),
      ChangeNotifierProvider(
        create: (_) => SelectCarProvider(),
      ),
      ChangeNotifierProvider(
        create: (_) => CarsService(),
      ),
      ChangeNotifierProvider(
        create: (_) => SelectCarProvider(),
      ),
      ChangeNotifierProvider(
        create: (_) => RegisterCarProvider(),
      ),
      ChangeNotifierProvider(
        create: (_) => CarreraService(),
      ),
      ChangeNotifierProvider(
        create: (_) => HistoryProvider(),
      ),
    ], child: const _MyApp());
  }
}

class _MyApp extends StatelessWidget {
  const _MyApp({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Pagina Principal',
      routes: {
        'check': (_) => const CheckAuthScreen(),
        'login': (_) => const LoginScreen(),
        'home': (_) => const HomeScreen(),
        'user': (_) => const UserScreen(),
        'driver': (_) => const DriverScreen(),
        'register_driver': (_) => RegisterRequestScreen(),
        'register': (_) => const RegisterScreen(),
        'service': (_) => RequestServiceScreen(),
        'travel_history': (_) => const TravelHistoryScreen(),
        'punctuation': (_) => const PunctationScreen(),
        'select_ car': (_) => const SelectCarScreen(),
        'add_car': (_) => AddCarScreen(),
      },
      initialRoute: 'check',
      theme: AppTheme.lightTheme,
    );
  }
}

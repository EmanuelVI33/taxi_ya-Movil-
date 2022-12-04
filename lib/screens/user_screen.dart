import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:taxi_ya/models/models.dart';
import 'package:taxi_ya/providers/providers.dart';
import 'package:taxi_ya/services/services.dart';

class UserScreen extends StatefulWidget {
  const UserScreen({super.key});

  @override
  State<UserScreen> createState() => _UserScreenState();
}

class _UserScreenState extends State<UserScreen> {
  Future<void> loaded() async {
    final user = Provider.of<UserService>(context, listen: false);
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final userId = prefs.getString('userId');
    ApiResponse response = await user.show(userId);
    if (response.error == null) {
      final user = response.data as User;
      userProvider.id = user.id;
      userProvider.nombre = user.nombre;
      userProvider.apellido = user.apellido;
      userProvider.telefono = user.telefono;
      userProvider.email = user.email;
      userProvider.image = user.image;
    }
  }

  @override
  void initState() {
    super.initState();
    final userProvider = Provider.of<UserProvider>(context, listen: false);

    if (userProvider.existNull()) {
      loaded();
    }
  }

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);

    return userProvider.loading
        ? const CircularProgressIndicator()
        : Center(
            child: Column(
              children: [
                Text(userProvider.nombre),
                const SizedBox(
                  height: 10,
                ),
                Text(userProvider.apellido),
                const SizedBox(
                  height: 10,
                ),
                Text(userProvider.telefono),
                const SizedBox(
                  height: 10,
                ),
                Text(userProvider.email),
                const SizedBox(
                  height: 10,
                ),
                userProvider.image != ''
                    ? const Image(
                        image: AssetImage('assets/no-image.png'),
                        fit: BoxFit.cover,
                        width: 300,
                        height: 200,
                      )
                    : const Image(
                        image: NetworkImage(
                            'http://192.168.0.8/storage/cliente/8xnHBA73nPkphA7zMLV6Y6qhSEcxzEwYzeN0X99n.png'),
                      ),
              ],
            ),
          );
  }
}

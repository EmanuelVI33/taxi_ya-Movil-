import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:provider/provider.dart';
import 'package:taxi_ya/models/user.dart';
import 'package:taxi_ya/providers/providers.dart';
import 'package:taxi_ya/services/services.dart';

class UserScreen extends StatelessWidget {
  const UserScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    final userService = Provider.of<UserService>(context, listen: false);
    const storage = FlutterSecureStorage();

    Future loadedUser() async {
      const storage = FlutterSecureStorage();
      userProvider.loading = true;
      dynamic userId = storage.read(key: 'userId');
      final response = await userService.show(userId);
      userProvider.loading = false;

      if (response.error == null) {
        final user = response.data as User;
        userProvider.id = user.id;
        userProvider.nombre = user.nombre;
        userProvider.apellido = user.apellido;
        userProvider.email = user.email;
        userProvider.telefono = user.telefono;
        userProvider.image = user.image;
      }
    }

    if (userProvider.existNull()) {
      loadedUser();
    }

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
                userProvider.image == null
                    ? Image.asset("no-image.png")
                    : Image.network(
                        userProvider.image,
                        fit: BoxFit.cover,
                      ),
              ],
            ),
          );
  }
}

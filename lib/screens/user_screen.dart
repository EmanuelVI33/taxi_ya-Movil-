import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:taxi_ya/providers/providers.dart';

class UserScreen extends StatelessWidget {
  const UserScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context, listen: false);

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
                // userProvider.image == ''
                //     ? Image.asset('no-image.png')
                //     : Image.network(
                //         userProvider.image,
                //         fit: BoxFit.cover,
                //       ),
              ],
            ),
          );
  }
}

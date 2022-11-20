import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:taxi_ya/providers/providers.dart';

class UserScreen extends StatelessWidget {
  const UserScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context, listen: false);

    return Container(
      child: Center(
        child: Column(
          children: [
            Text(userProvider.nombre),
            SizedBox(
              height: 10,
            ),
            Text(userProvider.apellido),
            SizedBox(
              height: 10,
            ),
            Text(userProvider.phone),
            SizedBox(
              height: 10,
            ),
            Text(userProvider.email),
            SizedBox(
              height: 10,
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:taxi_ya/models/api_response.dart';
import 'package:taxi_ya/screens/screens.dart';
import 'package:taxi_ya/services/user_service.dart';

import '../constant.dart';

class _loading extends StatefulWidget {
  const _loading({Key? key}) : super(key: key);

  @override
  State<_loading> createState() => _loadingState();
}

class _loadingState extends State<_loading> {
  int userID = 0;

  _getId() async {
    userID = await getUserId();
  }

  void _loadUserInfo() async {
    String token = await getToken();
    if (token == '') {
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) => const LoginScreen()),
          (route) => false);
    } else {
      ApiResponse response = await getUserDetail();
      if (response.error == null) {
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (context) => const HomeScreen()),
            (route) => false);
      } else if (response.error == unauthorized) {
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (context) => const LoginScreen()),
            (route) => false);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('${response.error}'),
        ));
      }
    }
  }

  @override
  void initState() {
    _loadUserInfo();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      color: Colors.indigo,
      child: const Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}

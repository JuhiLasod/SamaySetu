import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import './screens/login.dart';
import './screens/home.dart';

void main() => runApp(const SamaySetu());

class SamaySetu extends StatelessWidget {
  const SamaySetu({super.key});
  
  Future<String?> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('token');
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: FutureBuilder<String?>(
        future: getToken(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator()); // loading
          } else {
            final token = snapshot.data;
            return token == null ? const login() :  home();
          }
        },
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import './screens/login.dart';
import './screens/home.dart';
import './screens/editProfile.dart';

void main() {
  runApp(SamaySetu());
}

class SamaySetu extends StatelessWidget {
  const SamaySetu({super.key});

  Future<Widget> checkUserStatus() async {
    final prefs = await SharedPreferences.getInstance();
    final email = prefs.getString('email');

    if (email == null) {
      return login(); // Not logged in
    }

    try {
      final res = await http.post(
        Uri.parse('http://10.0.2.2:8000/api/isProfile'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'email': email}),
      );

      if (res.statusCode == 500) {
        return login(); // Server error
      }

      if (res.body == 'true') {
        return home(); // Profile exists
      } else {
        return editProfile(); // Profile missing
      }
    } catch (e) {
      return login(); // Network or parsing error
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: FutureBuilder<Widget>(
        future: checkUserStatus(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Scaffold(
              body: Center(child: CircularProgressIndicator()),
            );
          } else {
            return snapshot.data!;
          }
        },
      ),
    );
  }
}

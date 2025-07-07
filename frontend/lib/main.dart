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
    print(email);

    if (email == null) {
      return login(); 
    }

    try {
      print("inside try");
      final res = await http.post(
        Uri.parse('http://10.0.2.2:8000/profile/isprofile'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'email': email}),
      );
      print(res.body);
      if (res.statusCode == 500) {
        return login(); 
      }

      if (await res.body == 'true') {
        return home(); 
      } else {
        return editProfile(); 
      }
    } catch (e) {
      return login(); 
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

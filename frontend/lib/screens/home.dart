import 'package:flutter/material.dart';
import './login.dart';
import 'package:shared_preferences/shared_preferences.dart';
class home extends StatefulWidget
{
  @override
  State<home> createState()=> _homeState();
}

class _homeState extends State<home>
{
  void handleLogout ()async{
    final prefs=await SharedPreferences.getInstance();
    await prefs.clear();
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>const login()));
  }
  @override
  Widget build(BuildContext context)
  {
    return Scaffold(
      body: Padding( padding: EdgeInsets.all(50),child: ElevatedButton(onPressed: handleLogout, child: Text('logout')))
    );
  }
}
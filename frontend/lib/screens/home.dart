import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import './login.dart';
import './editProfile.dart';
import 'package:shared_preferences/shared_preferences.dart';
class home extends StatefulWidget
{
  @override
  State<home> createState()=> _homeState();
}

class _homeState extends State<home>
{
  bool existProfile=false;
  void handleLogout ()async{
    final prefs=await SharedPreferences.getInstance();
    await prefs.clear();
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>const login()));
  }
  void isProfile()async{
    final prefs=await SharedPreferences.getInstance();
    final email=await  prefs.getString('email');
    final res=await http.post(Uri.parse('http://10.0.2.2:8000/api/isProfile'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'email':email})
    );
    if(res.statusCode==500)
    {
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>login()));
    }
    else if(res.body=='true'){
      setState(() {
        existProfile=true;
      });
    }
    else
    {
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>editProfile()));
    }
  }
  @override
  void initState()
  {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      isProfile();
    });
    // if(!existProfile){
    //   Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>editProfile()));
    // }
  }
  Widget build(BuildContext context)
  {
    
    return Scaffold(
      body: Padding( padding: EdgeInsets.all(50),child: ElevatedButton(onPressed: handleLogout, child: Text('logout')))
    );
  }
}
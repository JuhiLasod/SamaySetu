import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import './login.dart';
import './editProfile.dart';
import "./myRequests.dart";
import './explore.dart';
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

  void handleMyReq ()async{
    final prefs=await SharedPreferences.getInstance();
    final from=await  prefs.getString('email');
    print("sending");
    final res=await http.post(Uri.parse('http://10.0.2.2:8000/req/my-req'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'from':from})
    );
  }

  void isProfile()async{
    final prefs=await SharedPreferences.getInstance();
    final email=await  prefs.getString('email');
    print(email);
    final res=await http.post(Uri.parse('http://10.0.2.2:8000/profile/isprofile'),
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
    print("inside init");
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
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(50),
            child:ElevatedButton(
              onPressed: (){Navigator.push(context, MaterialPageRoute(builder: (context)=>explore()));},  
              child: Text('explore')
            )
          ),

          Padding( 
            padding: EdgeInsets.all(50),
            child: ElevatedButton(
              onPressed: handleLogout, 
              child: Text('logout')
            )
          ),
          
          Padding( 
            padding: EdgeInsets.all(50),
            child: ElevatedButton(
              onPressed: handleMyReq,
              // onPressed: (){Navigator.push(context, MaterialPageRoute(builder: (context)=>myRequests()));}, 
              child: Text('My Requests')
            )
          ),

          ElevatedButton(
            onPressed: (){Navigator.push(context, MaterialPageRoute(builder: (context)=>editProfile()));}, 
            child: Text('edit profile')
          )
        ]
      )
    );
  }
}
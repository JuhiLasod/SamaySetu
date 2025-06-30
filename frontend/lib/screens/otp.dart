import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
class otp extends StatefulWidget{
  State<otp> createState()=> _otpState();
}

class _otpState extends State<otp>
{
  final TextEditingController _emailController=TextEditingController();
  String msg='';
  void _sendotp()async {
    final email=_emailController.text;
    final res=await http.post(Uri.parse('http://10.0.2.2:8000/api/send-otp'),
    headers: {'Content-Type': 'application/json'},
    body: jsonEncode({'email':email})
    );
    if(res.statusCode==500)
    {
      setState(() {
        msg="server error";
      });
    }
    else
    {
      setState(() {
        msg=res.body;
      });
    }
  }
  @override

  Widget build(BuildContext context)
  {
    return Scaffold(
      body: Column(
        children:[Padding(padding:EdgeInsets.all(50),child:TextField(controller: _emailController,  )),
          ElevatedButton(onPressed: _sendotp, child: Text('send OTP'))  ,
          Text(msg)
        ]
      )
    );
  }
}
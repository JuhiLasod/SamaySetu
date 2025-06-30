import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
class otp extends StatefulWidget{
  State<otp> createState()=> _otpState();
}

class _otpState extends State<otp>
{
  final TextEditingController _emailController=TextEditingController();
  final TextEditingController _otpController=TextEditingController();
  final TextEditingController _passController=TextEditingController();
  String msg='';
  String msg2='';
  String msg3='';
  bool otpSent=false;
  bool verify=false;
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
        otpSent=true;
      });
    }
  }
  void handleVerify()async{
    final email=_emailController.text;
    final otp=_otpController.text;
    final res=await http.post(Uri.parse('http://10.0.2.2:8000/api/verify-otp'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'email':email,'otp':otp})
    ); 
    if(res.statusCode==500)
    {
      setState(() {
        msg2='server error';
      });
    }
    else if(res.body=="success"){
      setState(() {
        msg2=res.body;
        verify=true;
      });
    }
    else
    {
      setState(() {
        msg2=res.body;
      });
    }
  }
  void resetPass()async{
    final email=_emailController.text;
    final pass=_passController.text;
    final res=await http.post(Uri.parse('http://10.0.2.2:8000/api/reset-pass'),
      headers: {'Content-Type':'application/json'},
      body: jsonEncode({'email':email,'pass': pass})
    );
    if(res.statusCode==500)
    {
      setState(() {
        msg3='server error';
      });
    }
    else{
      setState(() {
        msg3=res.body;
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
          Text(msg),
          if(otpSent)
          Column(children:[
            TextField(controller: _otpController,),
            ElevatedButton(onPressed: handleVerify, child: Text('verify')),
            Text(msg2),
            if(verify)
            Column(children:[
              TextField(controller: _passController,),
              ElevatedButton(onPressed: resetPass, child: Text('reset')),
              Text(msg3)
            ])
          ])
        ]
      )
    );
  }
}
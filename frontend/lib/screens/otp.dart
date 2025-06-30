import 'dart:convert';
import './login.dart';
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
  final TextEditingController _conpassController=TextEditingController();
  String msg='';
  String msg2='';
  String msg3='';
  bool otpSent=false;
  bool verify=false;
  void _sendotp()async {
    setState(() {
      otpSent=false;
    });
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
      if(msg=="Otp successfully sent. This otp will expire after 3 minutes.")
      {
        setState(() {
          otpSent=true;
        });
      }
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
    else if(res.body=="Otp verified successfully."){
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
    final conpass=_conpassController.text;
    if(conpass!=pass)
    {
      setState(() {
        msg3='Both the passwords do not match. Please try entering it again.';
      });
    }
    else if(pass==null || pass.isEmpty || pass.length<6 || !RegExp(r'^(?=.*[A-Z])(?=.*\d)(?=.*[!@#\$&*~]).{6,}$').hasMatch(pass))
    {
      setState(() {
        msg3='Password must contain atleat one uppercase letter, one special character, one digit and should be longer than 6 characters';
      });
    }
    else
    {
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
    else if(msg3 !=null){
      setState(() {
        msg3=res.body;
      });
    }
    }
  }
  @override

  Widget build(BuildContext context)
  {
    final screenHeight=MediaQuery.of(context).size.height;
    final screenWidth=MediaQuery.of(context).size.width;
    return Scaffold(
      body: SingleChildScrollView(
                child: Container(
        color: Color.fromARGB(255, 217, 217, 217),
        child: Column(
          children:[
              Container(
                color: Color.fromARGB(255, 0, 0, 0),
                width: screenWidth * 1,
                height: screenHeight * 0.1,
                child: Padding(
                  padding: EdgeInsets.fromLTRB(0, 15, 0, 0),
                  child: Row(
                    children: [
                      Image.asset("assets/images/logo.png", fit: BoxFit.cover,height: screenHeight * 0.05,),
                      Padding(padding: EdgeInsets.fromLTRB(20, 0, 0, 0),child: Text("SamaySetu",style: TextStyle(fontFamily: 'title',fontSize:38, color: Color.fromARGB(255, 255, 255, 255)),))
                    ],
                  ),
                ),
              ),
              Column(children:[
                Padding(
                  padding: EdgeInsets.all(30),
                  child: TextFormField(
                    controller: _emailController,
                    decoration: InputDecoration(
                      hintText: 'Enter your registered email id',
                      hintStyle: TextStyle(color: Color.fromARGB(100, 0, 0, 0)),
                      border: OutlineInputBorder(),
                                  
                    ),
                  ),
                ),
                SizedBox(
                  width: 200,
                  height: 50,
                  child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)
                    ),
                    backgroundColor: Color.fromARGB(255, 0, 0, 0)
                  ),
                  onPressed: _sendotp, 
                    child: Text('Send otp',
                      style: TextStyle(fontSize: 17, color: Color.fromARGB(255, 255, 255, 255)),
                    )
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(30),
                  child: Text(msg, 
                    style: TextStyle(
                      fontSize: 20, 
                      fontFamily: 'basic',
                      color: Color.fromARGB(255, 0, 0, 0)
                    ),
                  )
                ),
                if(otpSent)
                Column(children:[
                  Padding(
                  padding: EdgeInsets.fromLTRB(30,0,30,30),
                  child: TextFormField(
                    controller: _otpController,
                    decoration: InputDecoration(
                      hintText: 'Enter your registered email id',
                      hintStyle: TextStyle(color: Color.fromARGB(100, 0, 0, 0)),
                      border: OutlineInputBorder(),
                                  
                    ),
                  ),
                ),
                SizedBox(
                  width: 200,
                  height: 50,
                  child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)
                    ),
                    backgroundColor: Color.fromARGB(255, 0, 0, 0)
                  ),
                  onPressed: handleVerify, 
                    child: Text('Verify otp',
                      style: TextStyle(fontSize: 17, color: Color.fromARGB(255, 255, 255, 255)),
                    )
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(30),
                  child: Text(msg2 , 
                    style: TextStyle(
                      fontSize: 20, 
                      fontFamily: 'basic',
                      color: Color.fromARGB(255, 0, 0, 0)
                    ),
                  )
                ),
                  if(verify)
                  Column(children:[
                    // TextField(controller: _passController,),
                    Padding(
                  padding: EdgeInsets.fromLTRB(30,0,30,30),
                  child: TextFormField(
                    controller: _passController,
                    onChanged: (value) => setState(() {
                      msg3='';
                    }),
                    decoration: InputDecoration(
                      hintText: 'Enter your new password',
                      hintStyle: TextStyle(color: Color.fromARGB(100, 0, 0, 0)),
                      border: OutlineInputBorder(),
                                  
                    ),
                    
                  ),
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(30,0,30,30),
                  child: TextFormField(
                    controller: _conpassController,
                    decoration: InputDecoration(
                      hintText: 'Confirm your new password',
                      hintStyle: TextStyle(color: Color.fromARGB(100, 0, 0, 0)),
                      border: OutlineInputBorder(),
                                  
                    ),
                    
                    ),
                  ),
              
                    // ElevatedButton(onPressed: resetPass, child: Text('reset')),
                    SizedBox(
                  width: 200,
                  height: 50,
                  child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)
                    ),
                    backgroundColor: Color.fromARGB(255, 0, 0, 0)
                  ),
                  onPressed:(){ resetPass();
                  if(msg3=='Password reset successfull')
                  {
                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>const login()));
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(msg3),duration: Duration(seconds: 3),behavior: SnackBarBehavior.floating,));
                  }
                  },
                    child: Text('Reset password',
                      style: TextStyle(fontSize: 17, color: Color.fromARGB(255, 255, 255, 255)),
                    )
                  ),
                ),
                    Padding(
                  padding: EdgeInsets.all(30),
                  child: Text(msg3, 
                    style: TextStyle(
                      fontSize: 20, 
                      fontFamily: 'basic',
                      color: Color.fromARGB(255, 0, 0, 0)
                    ),
                  )
                ),
                
                // ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(msg3),duration: Duration(seconds: 2),behavior: SnackBarBehavior.floating,));
                    // Text(msg3)
                  ])
                            ])
                          ]),
              ])
          ),
      )
    );
  }
}
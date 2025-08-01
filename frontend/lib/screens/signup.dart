import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
// import 'package:shared_preferences/shared_preferences.dart';
import './login.dart';
import './otp.dart';


class signup extends StatefulWidget{
  const signup({super.key});
  @override
  State <signup> createState()=> _signupState(); 
}

class _signupState extends State<signup>
{
  final TextEditingController _emailController=TextEditingController();
  final TextEditingController _passController=TextEditingController();
  String msg='';
  String email='';
  String pass='';
  
  bool visible=false;

  void setVisible()
  {
    setState(() {
      visible=!visible;
    });
  }

  

  void _handleSignup () async{
    final email=_emailController.text;
    final pass=_passController.text;
    if( email.isEmpty || !RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w]{2,4}$').hasMatch(email))
    {
      setState(() {
        msg="Invalid email id.";
      });
    }
    else if(pass.isEmpty || pass.length<6 || !RegExp(r'^(?=.*[A-Z])(?=.*\d)(?=.*[!@#\$&*~]).{6,}$').hasMatch(pass))
    {
      setState(() {
        msg='Password must contain atleat one uppercase letter, one special character, one digit and should be longer than 6 characters';
      });
    }
    else{
    try{
    final res=await http.post(Uri.parse("https://samaysetu.onrender.com/api/signup"),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({'email': email,"pass": pass})
    );
    
    if(res.statusCode==200)
    {
      msg=res.body;
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(msg),duration: Duration(seconds: 3),behavior: SnackBarBehavior.floating,));
      Navigator.pushReplacement(context,MaterialPageRoute(builder: (context)=> login()));
    }
    else{
      setState(() {
        msg=res.body;
      });
    }
    }
    catch(err)
    {
      setState(() {
        msg="Error connecting to server. Try again later.";
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
      body: Stack(
          children:[ Column(children:[
            Container(
              height: screenHeight * 0.5,
              color: Color.fromARGB(255, 0, 0, 0),
            ),
            Container(
              height: screenHeight * 0.5,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors:[ Color.fromARGB(255, 111, 180, 253),Color.fromARGB(255, 0, 0, 0)],
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter
                )
              ),
            )
          ] ),
          
            Positioned(
              top: screenHeight *0.2,
              left: (screenWidth * 0.25),
              child: Image.asset('assets/images/logo.png',
                width: screenWidth * 0.5,
                // height: ,
                fit: BoxFit.cover,
              ),
            ),
          Positioned(
            top: screenHeight * 0.35,
            left: screenWidth * 0.22,
            child: Text('SamaySetu',style: TextStyle(fontFamily: 'title',fontSize: 50, color: Color.fromARGB(255, 255, 255, 255)),)
          ),
          Positioned(
              top: screenHeight *0.45,
              left: screenWidth *0.1,
              child: Container(
                width: screenWidth * 0.8,
                height: screenHeight * 0.5,
                decoration: BoxDecoration(
                  color: Color.fromARGB(255, 255, 255, 255),
                  borderRadius: BorderRadius.circular(25)
                ),
                child: Padding(
                  padding: EdgeInsets.all(20),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                    
                        Padding(
                          padding: EdgeInsets.fromLTRB(0,0,0,20),
                          child: TextFormField(
                            controller: _emailController,
                            onChanged: (value)=>{email=_emailController.text},
                            decoration: InputDecoration(
                              hintText: 'Enter your email id',
                              hintStyle: TextStyle(color: Color.fromARGB(100, 0, 0, 0)),
                              border: OutlineInputBorder(),
                              
                              ),
                            ),
                        ),
                        Padding(
                          padding: EdgeInsets.fromLTRB(0,0,0,20),
                          child: TextFormField(
                            controller: _passController,
                            obscureText: !visible,
                            onChanged: (value)=>{pass=_passController.text},
                            decoration: InputDecoration(
                              hintText: 'Enter password',
                              hintStyle: TextStyle(color: Color.fromARGB(100, 0, 0, 0)),
                              suffixIcon: IconButton(
                                onPressed: setVisible,
                                icon: Icon(
                                  visible? Icons.visibility_off : Icons.visibility
                                )
                              ),
                              border: OutlineInputBorder(),
                              
                              ),
                            ),
                        ),
                        ],
                    ),
                    Column(
                    children: [
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
                          onPressed:
                            _handleSignup,
                            
                          
                          child: Text('Sign up',
                            style: TextStyle(fontSize: 17, color: Color.fromARGB(255, 255, 255, 255)),
                          )
                        ),
                      ),
                      
                      Padding(
                        padding: EdgeInsetsGeometry.fromLTRB(0, 20,0, 0),
                        child: Text(msg,
                            style: TextStyle(color: Color.fromARGB(255, 255, 0, 0) , fontSize: 17 ),
                            ),
                      )
                    ]
                  )
                  ]),
                  
                ),
              )
          ),
              
        ] ),

    
    );
  }
}
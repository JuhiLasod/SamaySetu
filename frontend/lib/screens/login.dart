import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class login extends StatefulWidget{
  const login({super.key});
  @override
  State <login> createState()=> _loginState(); 
}

class _loginState extends State<login>
{
  final TextEditingController _emailController=TextEditingController();
  final TextEditingController _passController=TextEditingController();
  String msg='';
  void _handleLogin () async{
    final email=_emailController.text;
    final pass=_passController.text;
    try{
    final res=await http.post(Uri.parse("http://10.0.2.2:8000/api/login"),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({'email': email,"pass": pass})
    );
    
    if(res.statusCode==200)
    {
      setState(() {
        msg="success";
      });
    }
    else
    {
      setState(() {
        msg='invalid cred';
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
  // final secreenHeight=MediaQuery.of(context).size.height;
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
                height: screenHeight * 0.4,
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
                        // Padding(
                        //   padding: EdgeInsets.fromLTRB(0, 0, 0, 10),
                        //   child: Text('Email',style: 
                        //     TextStyle(
                        //       color: Color.fromARGB(255, 0, 0, 0),
                        //       fontSize: 20
                        //     ),
                        //   )
                        // ),
                        Padding(
                          padding: EdgeInsets.fromLTRB(0,0,0,20),
                          child: TextFormField(
                            controller: _emailController,
                            decoration: InputDecoration(
                              hintText: 'Enter your registered email id',
                              hintStyle: TextStyle(color: Color.fromARGB(100, 0, 0, 0)),
                              border: OutlineInputBorder(),
                              
                              ),
                            ),
                        ),
                        Padding(
                          padding: EdgeInsets.fromLTRB(0,0,0,20),
                          child: TextFormField(
                            controller: _passController,
                            decoration: InputDecoration(
                              hintText: 'Enter password',
                              hintStyle: TextStyle(color: Color.fromARGB(100, 0, 0, 0)),
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
                          onPressed: _handleLogin, 
                          child: Text('Sign in',
                            style: TextStyle(fontSize: 15, color: Color.fromARGB(255, 255, 255, 255)),
                          )
                        ),
                      ),
                      Padding(
                        padding: EdgeInsetsGeometry.fromLTRB(0, 20,0, 0),
                        child: GestureDetector(
                          child: Text('forgot password?',
                            style: TextStyle(decoration: TextDecoration.underline,fontSize: 15 ),
                            ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsetsGeometry.fromLTRB(0, 20,0, 0),
                        child: GestureDetector(
                          child: Text('New to SamaySetu? Sign up now.',
                            style: TextStyle(decoration: TextDecoration.underline,fontSize: 15 ),
                            ),
                        ),
                      ),
                      Text(msg),
                    ]
                  )
                  ]),
                  // Column(
                  //   children: [
                  //     ElevatedButton(
                  //       onPressed: (){}, 
                  //       child: Text('Sign in')
                  //     )
                  //   ]
                  // )
                ),
              )
          ),
              
        ] ),

    
    );
  }
}
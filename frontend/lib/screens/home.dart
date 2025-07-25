import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import './login.dart';
import './editProfile.dart';
import "./myRequests.dart";
import "./reqToMe.dart";
import './explore.dart';
import 'package:shared_preferences/shared_preferences.dart';


class home extends StatefulWidget
{
  const home({super.key});
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
  int balance=0;
  void loadContent()async{
  final prefs=await SharedPreferences.getInstance();
  final email=await prefs.getString('email');
  final res= await http.post(Uri.parse("http://10.0.2.2:8000/profile/loadprofile"),
  headers:{'Content-Type':'application/json'},
  body:jsonEncode({'email':email})
  );
  final data=jsonDecode( res.body);
  setState(() {
    // name=data['name'];
    balance=data['balance'];
    });
  }
  
  @override
  void initState()
  {
    super.initState();
    loadContent();
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
    final screenHeight= MediaQuery.of(context).size.height;
    final screenWidth= MediaQuery.of(context).size.width;
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [Container(
            // color: Colors.green,
            // width: screenWidth*2,
            height: screenHeight *1,
            decoration: BoxDecoration(image: DecorationImage(image: AssetImage("assets/images/clock.png", ),fit: BoxFit.cover)),
            child: Container(color: Colors.black.withAlpha(100),
              child: Column(
                  children: [
                    // Container(
                    //   color: Color.fromARGB(255, 0, 0, 0),
                    //   height: screenHeight * 0.12,
                      // width: screenWidth,
                    //   child: Padding(
                    //     padding: EdgeInsets.fromLTRB(0, 25, 0, 0),
                    //     child: Row(
                    //       children: [
                    //         Padding(padding: EdgeInsets.all(20),child: Image.asset('assets/images/logo.png',fit: BoxFit.contain, )),
                    //         Padding(padding: EdgeInsets.fromLTRB(20, 0, 0, 0),child: Text("SamaySetu",style: TextStyle(fontFamily: 'title',fontSize:42, color: Color.fromARGB(255, 255, 255, 255)),))
                    //       ],
                    //     ),
                    //   ),
                    // ),
                    Column(
                      children: [
                      //   Container(
                      //   color: Colors.black,
                      //   child: Padding(padding:EdgeInsets.fromLTRB(5, 10, 5, 10),
                      //     child: 
                      //       Text("Bank hours, not money!",textAlign: TextAlign.left,style:TextStyle(color: const Color.fromARGB(107, 255, 255, 255), fontFamily: 'title',fontSize: 40)),
                      //       // Spacer(),
                            
                          
                      //   ),
                      // ),
                    
                    Padding(padding:EdgeInsets.fromLTRB(10,50,10,0),
                      child: Container(
                        height: screenHeight * 0.15,
                        width:screenWidth *1,
                        decoration: BoxDecoration(color: const Color.fromARGB(255, 0, 0, 0).withAlpha(150),
                        borderRadius: BorderRadius.circular(25),),
                        
                        child: Row(
                          children:[
                            Column(mainAxisAlignment: MainAxisAlignment.start,crossAxisAlignment: CrossAxisAlignment.start,
                              children:[
                          Padding(padding:EdgeInsets.fromLTRB(20,20,0,0),child: Text("Your current balance is",style: TextStyle(fontFamily: 'basic',fontSize: 20, color: const Color.fromARGB(255, 127, 127, 127)))),
                          
                            Padding(padding: EdgeInsets.fromLTRB(20,0,0,0),child: Text(balance.toString(),style:TextStyle(fontWeight: FontWeight.bold,fontSize: 60, color: Colors.white))),
                            // Spacer(),
                            ]),
                            // Text("💰"),
                            Spacer(),
                            Padding(padding: EdgeInsets.fromLTRB(0, 0, 20, 0),
                              child: Container(
                                // decoration:BoxDecoration(shape: BoxShape.circle,border: Border.all(color: Color.fromARGB(107, 255, 255, 255),width: 2)),
                                child: GestureDetector(onTap: () {
                                  
                                },
                                child: CircleAvatar(radius: 65,backgroundColor: Colors.transparent,child: Padding(padding: EdgeInsets.all(5),child: ClipOval(child: Opacity( opacity: 0.7,child: Image.asset("assets/images/rupee.png",fit: BoxFit.contain)))),)),
                              ),
                            )
                          
                        ]),
                        
                      
                      ),
                    ),
                    // Padding(
                    //   padding: EdgeInsets.all(50),
                    //   child:ElevatedButton(
                    //     onPressed: (){Navigator.push(context, MaterialPageRoute(builder: (context)=>explore()));},  
                    //     child: Text('explore')
                    //   )
                    // ),
                            
                    // Padding( 
                    //   padding: EdgeInsets.all(50),
                    //   child: ElevatedButton(
                    //     onPressed: handleLogout, 
                    //     child: Text('logout')
                    //   )
                    // ),
                    
                    // Padding( 
                    //   padding: EdgeInsets.all(50),
                    //   child: ElevatedButton(
                    //     // onPressed: handleMyReq,
                    //     onPressed: (){Navigator.push(context, MaterialPageRoute(builder: (context)=>myRequests()));}, 
                    //     child: Text('My Requests')
                    //   )
                    // ),
                            
                    // Padding( 
                    //   padding: EdgeInsets.all(50),
                    //   child: ElevatedButton(
                    //     // onPressed: handleMyReq,
                    //     onPressed: (){Navigator.push(context, MaterialPageRoute(builder: (context)=>reqToMe()));}, 
                    //     child: Text('Requests to me')
                    //   )
                    // ),
                            
                    // ElevatedButton(
                    //   onPressed: (){Navigator.push(context, MaterialPageRoute(builder: (context)=>editProfile()));}, 
                    //   child: Text('edit profile')
                    // )
                              ]
                            ),
                            Padding(padding: EdgeInsets.fromLTRB(10, screenHeight * 0.4, screenWidth * 0.2, 0),child: Text("Bank hours, not money! blahhh blahhhh qwertyu sdfgh xcvbn dfghdfghj wertyui dfghjk",textAlign: TextAlign.left,style:TextStyle(fontWeight: FontWeight.bold , color:  Color.fromARGB(255, 255, 255, 255), fontFamily: 'title',fontSize: 40))),
                      //      
                      ]),
            ),
            ),
            Container(
              height: screenHeight * 1,
              color: Colors.black,
              width: screenWidth*1,
              child: Column(children:[ 
                Container(
                  height: screenHeight*0.4,
                  child: Stack(clipBehavior: Clip.none,children:[
                    //  GestureDetector(
                    //   onTap: (){
                    //     Navigator.push(context, MaterialPageRoute(builder: (context)=>editProfile()));
                    //   },
                    //     child: CircleAvatar(
                    //       radius: 65,
                    //       backgroundColor: Colors.transparent,
                    //       child: Padding(
                    //         padding: EdgeInsets.all(5),
                    //         child: ClipOval(
                    //           child: Opacity( 
                    //             opacity: 0.7,
                    //             child: Image.asset("assets/images/logo.png",
                    //             fit: BoxFit.contain)
                    //           )
                    //         )
                    //       )
                    //     )
                    //   ),
                      Center(
                        child: Container(
                          width: screenWidth*0.9,
                          height: screenHeight * 0.15,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(15)),
                            gradient: LinearGradient(colors:[const Color.fromARGB(255, 65, 176, 255), const Color.fromARGB(255, 0, 32, 76)],begin:Alignment.topCenter, end: Alignment.bottomCenter)
                          ),
                          child: GestureDetector(
                            onTap: (){Navigator.push(context, MaterialPageRoute(builder: (context)=>explore()));},  
                            child: Center(child: Padding(padding: EdgeInsets.fromLTRB(0, screenWidth*0.08, 0, 0),child: Text('Explore Services',style: TextStyle(fontFamily: 'title',fontSize: 40,color: Colors.white),)))
                          ),
                        ),
                      ),
                      Positioned(
                        top: screenHeight* 0.07,
                        left: screenWidth *0.4,
                        child: Container(
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(color: Colors.blue,width: 3)
                          ),
                          child: GestureDetector(
                          onTap: (){
                            Navigator.push(context, MaterialPageRoute(builder: (context)=>editProfile()));
                          },
                          
                            child: CircleAvatar(
                              
                              radius: screenWidth*0.1,
                              backgroundColor: Colors.black,
                              child: Padding(
                                padding: EdgeInsets.all(6),
                                child: Opacity( 
                                  opacity: 0.7,
                                  child: Image.asset("assets/images/logo.png",
                                  fit: BoxFit.contain)
                                )
                              )
                            )
                          ),
                        ),
                      ),
                  ]),
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
                      // onPressed: handleMyReq,
                      onPressed: (){Navigator.push(context, MaterialPageRoute(builder: (context)=>myRequests()));}, 
                      child: Text('My Requests')
                    )
                  ),
                          
                  Padding( 
                    padding: EdgeInsets.all(50),
                    child: ElevatedButton(
                      // onPressed: handleMyReq,
                      onPressed: (){Navigator.push(context, MaterialPageRoute(builder: (context)=>reqToMe()));}, 
                      child: Text('Requests to me')
                    )
                  ),
                          
                  // ElevatedButton(
                  //   onPressed: (){Navigator.push(context, MaterialPageRoute(builder: (context)=>editProfile()));}, 
                  //   child: Text('edit profile')
                  // )
              ])
            )
        ]),
      )
      
    );
  }
}
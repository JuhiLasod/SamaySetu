import 'dart:math';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class reqToMe extends StatefulWidget
{
  const reqToMe({super.key});
  @override
  State<reqToMe> createState()=> _reqToMeState();
}
class _reqToMeState extends State<reqToMe>
{
  List<dynamic> req=[];
  String status='pending';
  bool statusSet=false;
  String msg='';
  Future<void> handleMyReq ()async{
    final prefs=await SharedPreferences.getInstance();
    final from=await  prefs.getString('email');
    print(from);
    print("okkkkkayyyyyyyyyyyyyyyyy");
    final res=await http.post(Uri.parse('http://10.0.2.2:8000/req/req-to-me'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'from':from})
    );
    print("succ sent");
    final data= jsonDecode(res.body);
    
    setState(() {
      req=data;
    });

  }
  void handleStatus(String from, String to, String service, String datetime, String place, String status)async{
    print(from);
    print(to);
    print(service);
    print(datetime);
    print(place);
    print(status);
    final res = await http.post(Uri.parse("http://10.0.2.2:8000/req/set-status"),
      headers: {'Content-Type':'application/json'},
      body: jsonEncode({ 'from': from,  'to': to,  'service':service,  'datetime':datetime,  'place':place,  'status':status})
  );
  if(res.statusCode!=500)
  {
    setState((){
      statusSet=true;
      if(status!='declined')
      {
        msg="You have declined this request!";
      }
      else{
        msg="You have declined this request!";
      }
    });
  }
  else
  {
    setState(() {
      status='pending';
    });
  }
    // print(from);
    // print(from);
  }
  @override
  void initState()
  {
    super.initState();
     handleMyReq();
  }
  Widget build(BuildContext context)
  {
    final screenHeight=MediaQuery.of(context).size.height;
    final screenWidth=MediaQuery.of(context).size.width;
    return Scaffold(
      body:Column(
        
        children:[
          Container(
            color: Color.fromARGB(255, 0, 0, 0),
            height: screenHeight * 0.12,
            // width: screenWidth,
            child: Padding(
              padding: EdgeInsets.fromLTRB(0, 25, 0, 0),
              child: Row(
                children: [
                  Padding(padding: EdgeInsets.all(20),child: Image.asset('assets/images/logo.png',fit: BoxFit.contain, )),
                  Padding(padding: EdgeInsets.fromLTRB(20, 0, 0, 0),child: Text("SamaySetu",style: TextStyle(fontFamily: 'title',fontSize:42, color: Color.fromARGB(255, 255, 255, 255)),))
                ],
              ),
            ),
          ),
           Expanded(
             child:  ListView.builder(
                         itemCount: req.length,
                         itemBuilder: (context, index){
                final reqs= req[index];
                return Padding(
                  padding: EdgeInsets.all(screenWidth * 0.03),
                  child: Container(
                    height: screenHeight * 0.3,
                    margin: EdgeInsets.all(screenWidth *0.05),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular( 20),
                      border: Border.all(color: Colors.grey.shade400, width: 1),
                      boxShadow:[ BoxShadow(
                        color: Colors.grey.withOpacity(0.2),
        spreadRadius: 2,
        blurRadius: 4,
        offset: Offset(0, 3), )
                      ]
                      
                    ),
                    
                    child: ListTile(
                      title:Text(reqs['service'] ?? '',textAlign: TextAlign.center,style: TextStyle(fontSize: 28,fontFamily: 'title',color: Color.fromARGB(255, 15, 111, 196),fontWeight: FontWeight.bold)),
                      subtitle: Column(children: [
                        Padding(padding: EdgeInsets.all(10),child: Text("From: ${reqs['from'] ?? ''}" , style:TextStyle(fontFamily: 'basic',fontSize: 18))),
                        Padding(padding: EdgeInsets.all(10),child: Text("DateTime: ${reqs['datetime'] ?? ''}" , style:TextStyle(fontFamily: 'basic',fontSize: 18))),
                        Padding(padding: EdgeInsets.all(10),child: Text("Place: ${reqs['place'] ?? ''}" , style:TextStyle(fontFamily: 'basic',fontSize: 18))),
                        if(status=='pending')
                        ElevatedButton(
                          onPressed:(){
                            setState(()
                            {status='accept';});
                               handleStatus(reqs['from'] ?? '',reqs['to'] ?? '',reqs['service'] ?? '',reqs['datetime'] ?? '',reqs['place'] ?? '',status);
                          },
                          child:Text('Accept')
                        ),
                        if(status=='pending')
                        ElevatedButton(
                          onPressed:(){
                            setState(()
                            {status='decline';});
                               handleStatus(reqs['from'] ?? '',reqs['to'] ?? '',reqs['service'] ?? '',reqs['datetime'] ?? '',reqs['place'] ?? '',status,);
                          },
                          child:Text('Decline')
                        ),
                        // if(status!='pending')
                        Text(msg)
                      ],)
                      
                    ),
                  ),
                );
                         }
                       ),
             
           ),
        ]
      )
    );
  }
}
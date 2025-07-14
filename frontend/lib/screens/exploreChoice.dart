import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:path/path.dart';
import 'dart:convert';
import "./askForService.dart";

class exploreChoice extends StatefulWidget{
  final String selected;
  const exploreChoice({required this.selected , Key? key}): super(key : key);
 
  @override
  State<exploreChoice> createState()=> _exploreChoiceState();
}

class _exploreChoiceState extends State<exploreChoice>
{
  String msg='';
  List <Map<String,String>>users=[];
  void  loadUsers()async{
    try{
    final res= await http.post(Uri.parse("http://10.0.2.2:8000/explore/load-users"),
      headers:{'Content-Type':'application/json'},
      body:jsonEncode({'selected':widget.selected})
    );
    if(res.statusCode!=500)
    {
      List data=jsonDecode(res.body);
      setState((){
        // users=List<Map<String,String>>.from(data);
        users = data.map<Map<String, String>>((user) => {
        'name': user['name']?.toString() ?? '',
        'email': user['email']?.toString() ?? '',
        }).toList();
      });
      
    }
    else
    {
      setState((){
        msg='server error';
      });
    }
    }catch(e)
    {
      setState((){
        msg="could not load users";
      });
    }

  }
  @override
  void initState(){
    super.initState();
    loadUsers();
  }
  Widget build(BuildContext context )
  {
    final screenHeight=MediaQuery.of(context).size.height;
    final screenWidth=MediaQuery.of(context).size.width;

    return Scaffold(
      body: Column(
        children: [
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
          Text(msg),
          if(users.isEmpty)
          Padding(padding: EdgeInsets.all(40),child: Text("no service providers found yet for this service"))
          else
          Expanded(child: 
            ListView.builder(
                
                itemCount: users.length,
                itemBuilder: (context,index){
                  return Column(children:[ 
                    Padding(
                      padding: EdgeInsets.all(screenHeight * 0.03),
                      child: ListTile(title: Text(users[index]['name'] ?? 'no name'),)),
                    // Text(users[index]['email'] ?? 'no email'),
                    SizedBox(
                      height: screenHeight * 0.05,
                      width: screenWidth * 0.7,
                      child: ElevatedButton(
                        
                        style: ElevatedButton.styleFrom(
                          
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                          backgroundColor: Color.fromARGB(255, 15, 111, 196),
                          foregroundColor: Color.fromARGB(255, 255, 255, 255),
                          
                          
                        ),
                        onPressed: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context)=>askForService(email:users[index]['email'] ?? 'no email')));
                        }, 
                        child: Text('Ask for availaibility',style: TextStyle(fontFamily: 'basic',fontSize: 18),)
                      ),
                    )
                  ]);
                }
              ),
            
            
          )
          
        ],
      )
    );
  }
}
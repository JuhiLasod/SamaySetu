import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class exploreChoice extends StatefulWidget{
  final String selected;
  const exploreChoice({required this.selected , Key? key}): super(key : key);
 
  @override
  State<exploreChoice> createState()=> _exploreChoiceState();
}

class _exploreChoiceState extends State<exploreChoice>
{
  String msg='';
  List <String>users=[];
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
        users=data.map<String>((item)=>item['name'].toString()).toList();
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
    return Scaffold(
      body: Column(
        children: [
          Text('msg'),
          if(users.isEmpty)
          Padding(padding: EdgeInsets.all(40),child: Text("no service providers found yet for this service"))
          else
          Expanded(child: 
            ListView.builder(
              itemCount: users.length,
              itemBuilder: (context,index){
                return ListTile(title: Text(users[index]),);
              }
            )
            
          )
          
        ],
      )
    );
  }
}
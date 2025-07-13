import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class askForService extends StatefulWidget{
  // const askForService({super.key});
  final String email;
  const askForService({required this.email, Key? key}): super(key:key);
  @override
  State<askForService> createState()=> afsState();
}
class afsState extends State<askForService>
{
  String msg='';
  String date='';
  String time='';
  String place='';
  void afs ()async{
    // final res=await http.post(Uri.parse('http://10.0.2.2:8000/explore/ask-for-service'),
    // headers:{'Content;Type':'application/json'},
    // body: jsonEncode({'email':widget.email, 'date':date, 'time':time, 'place': place})
    // );
    // if(res.statusCode==200)
    // {
    //   setState(() {
    //     msg='your request is successfully sent. Wait until they accept your request';
    //   });
    // }
  }
  @override
  Widget build(BuildContext context)
  {
    return Scaffold(
      body:Text(widget.email)
    );
  }
}
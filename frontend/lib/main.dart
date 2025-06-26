import 'package:flutter/material.dart';
import './screens/login.dart';
void main()=>runApp( const samaySetu());

class samaySetu extends StatelessWidget{
  const samaySetu({super.key});
  @override
  Widget build(BuildContext context)
  {
    return MaterialApp(
      home:login()
      );
  }
}
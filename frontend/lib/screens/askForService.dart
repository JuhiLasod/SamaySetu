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
  DateTime? selectedDate;
  TimeOfDay? selectedTime;
  TextEditingController _placec= TextEditingController();
  

  Future<void> _selectDate(BuildContext context) async {
    print("inside func");
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate ?? DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2100),
    );
    if (picked != null) {
      setState(() {
        selectedDate = picked;
      });
    }
  }

  Future<void> _selectTime(BuildContext context) async {
  final TimeOfDay? picked = await showTimePicker(
    context: context,
    initialTime: TimeOfDay.now(),
  );
  if (picked != null) {
    setState(() {
      selectedTime = picked;
    });
  }
}

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
    final screenHeight=MediaQuery.of(context).size.height;
    final screenWidth=MediaQuery.of(context).size.width;

    return Scaffold(
      body:Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(padding: EdgeInsets.all(20),
            child: ElevatedButton(
            onPressed: () => _selectDate(context),
            child: Text(
              selectedDate == null
                  ? 'Pick a date'
                  : 'Date: ${selectedDate!.day}/${selectedDate!.month}/${selectedDate!.year}',
            ),
            ),
          ),
          ElevatedButton(
              onPressed: () => _selectTime(context),
              child: Text(selectedTime == null
                  ? 'Select Time'
                  : 'Selected Time: ${selectedTime!.format(context)}'),
          ),
          Padding(
            padding: EdgeInsets.all(screenWidth * 0.1),
            child: SizedBox(
              height: screenHeight * 0.08,
              width:screenWidth * 0.8,
              child: TextField(
                controller: _placec,
                decoration: InputDecoration(
                  hint: Text('Venue to recieve service?'),
                  border: OutlineInputBorder()
                )
              ),
            ),
          )
        ],
      )
    );
  }
}
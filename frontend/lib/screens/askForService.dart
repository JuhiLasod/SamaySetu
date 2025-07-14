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
       builder: (context, child) {
      return Theme(
        data: Theme.of(context).copyWith(
          colorScheme: ColorScheme.light(
            primary: Color.fromARGB(255, 15, 111, 196), 
            onPrimary: Colors.white,                
            onSurface: Colors.black,          
          ),
          textButtonTheme: TextButtonThemeData(
            style: TextButton.styleFrom(
              foregroundColor: Color.fromARGB(255, 15, 111, 196), 
            ),
          ),
        ),
        child: child!,
      );
    },
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
  builder: (context, child) {
      return Theme(
        data: Theme.of(context).copyWith(
          
          colorScheme: ColorScheme.light(
            primary: Color.fromARGB(255, 15, 111, 196), 
            onPrimary: Colors.white,                    
            onSurface: Colors.black,                  
          ),
          textButtonTheme: TextButtonThemeData(
            style: TextButton.styleFrom(
              foregroundColor: Color.fromARGB(255, 15, 111, 196), 
            ),
          ),
          timePickerTheme: TimePickerThemeData(
            backgroundColor: Colors.white, 
            hourMinuteTextColor: Colors.black,
            dialHandColor: Color.fromARGB(255, 15, 111, 196),
            dialBackgroundColor: Colors.blue.shade50,

            // 👇 AM/PM text colors
            dayPeriodTextColor: MaterialStateColor.resolveWith((states) {
              if (states.contains(MaterialState.selected)) {
                return Colors.white; 
              }
              return Colors.black;   
            }),
            dayPeriodColor: MaterialStateColor.resolveWith((states) {
              if (states.contains(MaterialState.selected)) {
                return Color.fromARGB(255, 15, 111, 196); 
              }
              return Colors.grey.shade300; 
            }),
          ),
        ),
        child: child!,
      );
    },
  );
  if (picked != null) {
    setState(() {
      selectedTime = picked;
    });
  }
}

  void afs ()async{
    
String place=_placec.text;
// print("sending");
// print(formattedDateTime);
if(selectedDate==null || selectedTime==null || place.isEmpty ){
  setState(() {
    msg="Fill the entries properly!";
  });
}
  else{
    DateTime combinedDateTime = DateTime(
  selectedDate!.year,
  selectedDate!.month,
  selectedDate!.day,
  selectedTime!.hour,
  selectedTime!.minute,
);
String formattedDateTime = combinedDateTime.toIso8601String();
    final res=await http.post(Uri.parse('http://10.0.2.2:8000/explore/ask-for-service'),
    headers:{'Content-Type':'application/json'},
    body: jsonEncode({'email':widget.email, 'datetime':formattedDateTime, 'place': place})
    );
    if(res.statusCode==200)
    {
      setState(() {
        msg='Your request is successfully sent. Wait until they accept your request.';
      });
    }
    else
    {
      setState(() {
        msg="server error";
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
      body:Column(
        children:[ Container(
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
        Padding(
          padding: EdgeInsets.fromLTRB(0, screenHeight * 0.1, 0, 0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                
                Padding(padding: EdgeInsets.all(20),
                  child: Container(
                    height: screenHeight * 0.07,
                    width: screenWidth * 0.7,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                        backgroundColor: Color.fromARGB(255, 15, 111, 196),
                        foregroundColor: Color.fromARGB(255, 255, 255, 255),
                      ),
                    onPressed: () => _selectDate(context),
                    child: Text(
                      style: TextStyle(fontFamily: 'basic', fontSize: 20),
                      selectedDate == null
                          ? 'Pick a Date'
                          : 'Date: ${selectedDate!.day}/${selectedDate!.month}/${selectedDate!.year}',
                    ),
                    ),
                  ),
                ),
                Container(
                  height: screenHeight * 0.07,
                    width: screenWidth * 0.7,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                          backgroundColor: Color.fromARGB(255, 15, 111, 196),
                          foregroundColor: Color.fromARGB(255, 255, 255, 255),
                        ),
                      onPressed: () => _selectTime(context),
                      child: Text(
                        style: TextStyle(fontFamily: 'basic', fontSize: 20),
                        selectedTime == null
                          ? 'Select Time'
                          : 'Selected Time: ${selectedTime!.format(context)}'),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(screenWidth * 0.1),
                  child: SizedBox(
                    height: screenHeight * 0.08,
                    width:screenWidth * 0.8,
                    child: TextField(
                      controller: _placec,
                      decoration: InputDecoration(
                        hintText: 'Venue to recieve service?',
                        hintStyle: TextStyle(fontFamily: 'basic',fontSize: 20,color: Color.fromARGB(100, 0, 0, 0)),
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)))
                      )
                    ),
                  ),
                
                Container(
                  height: screenHeight * 0.07,
                    width: screenWidth * 0.7,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                          backgroundColor: Color.fromARGB(255, 15, 111, 196),
                          foregroundColor: Color.fromARGB(255, 255, 255, 255),
                        ),
                      onPressed: afs,
                      child: Text(
                        style: TextStyle(fontFamily: 'basic', fontSize: 20),
                        'Send Request'
                      )
                  )
                ),
                Padding(padding: EdgeInsets.all(screenWidth * 0.1),child: 
                  Text(msg, style: TextStyle(fontSize: 20,fontFamily: 'basic')
                ))
              ],
            ),
          ),
        ),
      ])
    );
  }
}
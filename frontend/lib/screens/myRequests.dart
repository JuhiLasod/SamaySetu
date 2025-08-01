import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class myRequests extends StatefulWidget
{
  const myRequests({super.key});
  @override
  State<myRequests> createState()=> _myreqState();
}
class _myreqState extends State<myRequests>
{
  List<dynamic> req=[];
  Map <int,String> statusMap={};
  Map <int,String> msgMap={};

  Future<void> handleMyReq ()async{
    final prefs=await SharedPreferences.getInstance();
    final from=await  prefs.getString('email');
    print("sending");
    final res=await http.post(Uri.parse('https://samaysetu.onrender.com/req/my-req'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'from':from})
    );
    final data= jsonDecode(res.body);
    setState(() {
      req=data;
    

    statusMap.clear(); // reset
    msgMap.clear();    // reset

    for (int i = 0; i < data.length; i++) {
      final status = data[i]['status'] ?? 'pending';
      statusMap[i] = status;
      if((status=='accept' || status=='mad') && afterTime(data[i]['datetime']))
      {
        print("checking for status");
        complete(i,data[i]['from'], data[i]['to'],  data[i]['service'],  data[i]['datetime'],  data[i]['place'],  data[i]['status']);
      }
      else if (status == 'accept') {

        msgMap[i] = 'You have accepted this request!';
      } else if (status == 'decline') {
        msgMap[i] = 'You have declined this request!';
      }
    }});

  }
  bool afterTime(String given)
  {
    DateTime dt = DateTime.parse(given).toUtc();
    DateTime now = DateTime.now().toUtc();
    Duration diff = now.difference(dt);
    return diff.inHours > 48 && !dt.isAfter(now);
  }
  bool withinTime(String given)
  {
    DateTime dt = DateTime.parse(given).toUtc();
    DateTime now = DateTime.now().toUtc();
    Duration diff = now.difference(dt);
    return diff.inHours <= 48 && !dt.isAfter(now);
  }
  bool isBeforeNow(String given)
  {
    DateTime dt = DateTime.parse(given).toUtc();
    DateTime now = DateTime.now().toUtc();
    
    return !dt.isAfter(now);
  }
  void complete(int index, String from, String to, String service, String datetime, String place, String status)async{
    final prefs=await SharedPreferences.getInstance();
    final email=await  prefs.getString('email');
    print(email);
    print(to);
    print(service);
    print(datetime);
    print(place);
    print(status);
    final res=await http.post(Uri.parse('https://samaysetu.onrender.com/req/complete'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({ 'from': email,  'to': to,  'service':service,  'datetime':datetime,  'place':place,  'status':status})
    );
    if(res.statusCode==200)
    {
      setState(() {
        statusMap[index]='complete';
        msgMap[index] = 'Transaction completed!';
      });
    }
  }

  void handleDispute(int index, String from, String to, String service, String datetime, String place, String status)async{
    final prefs=await SharedPreferences.getInstance();
    final email=await  prefs.getString('email');
    print(email);
    print(to);
    print(service);
    print(datetime);
    print(place);
    print(status);
    final res=await http.post(Uri.parse('https://samaysetu.onrender.com/req/dispute'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({ 'from': email,  'to': to,  'service':service,  'datetime':datetime,  'place':place,  'status':status})
    );
    if(res.statusCode==200)
    {
      setState(() {
        statusMap[index]='dispute';
        msgMap[index] = 'Disputed service';
      });
    }
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
          Container(
            height: screenHeight * 0.08,
            width: screenWidth*1,
            color: Color.fromARGB(255, 0, 94, 176),
            child: Padding(padding: EdgeInsets.fromLTRB(0, 0, 0, 0),child: Center(child: Text("Services requested by you",style: TextStyle(fontFamily: 'basic',fontSize: 25,color: Color.fromARGB(255,255, 255, 255)))))),
           
           Expanded(
             child:  ListView.builder(
                         itemCount: req.length,
                         itemBuilder: (context, index){
                final reqs= req[index];
                return Padding(
                  padding: EdgeInsets.all(screenWidth * 0.03),
                  child: Container(
                    height: screenHeight * 0.28,
                    margin: EdgeInsets.fromLTRB(screenWidth * 0.05,0,screenWidth * 0.05,0,),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular( 20),
                      border: Border.all(color: Colors.grey.shade400, width: 1),
                      boxShadow:[ BoxShadow(
                        color: Color.fromARGB(255, 225, 236, 245),
                        spreadRadius: 2,
                        blurRadius: 4,
                        offset: Offset(0, 3), )// shadow direction: bottom
                      ]
                      
                    ),
                    
                    child: ListTile(
                      title:Text(reqs['service'] ?? '',textAlign: TextAlign.center,style: TextStyle(fontSize: 30,fontFamily: 'title',color: Color.fromARGB(255, 15, 111, 196),fontWeight: FontWeight.bold)),
                      subtitle: Column(children: [
                        Padding(padding: EdgeInsets.all(10),child: Text("To: ${reqs['to'] ?? ''}" , style:TextStyle(fontFamily: 'basic',fontSize: 18))),
                        Padding(padding: EdgeInsets.all(10),child: Text("DateTime: ${reqs['datetime'] ?? ''}" , style:TextStyle(fontFamily: 'basic',fontSize: 18))),
                        Padding(padding: EdgeInsets.all(10),child: Text("Place: ${reqs['place'] ?? ''}" , style:TextStyle(fontFamily: 'basic',fontSize: 18))),
                        if(statusMap[index]=='dispute')
                          Center(child: Padding(padding: EdgeInsets.fromLTRB(0, 8, 0, 10),child: Text("We are looking after the dispute. Sorry for the inconvinience.",textAlign: TextAlign.center,style: TextStyle(fontFamily: 'basic',fontSize: 18,color:  Colors.red),)))
                        else if(statusMap[index]=='complete')
                          Padding(padding: EdgeInsets.fromLTRB(0, 15, 0, 15),child: Text("Transaction completed",style: TextStyle(fontFamily: 'basic',fontSize: 20,color:  Colors.green),))
                        else if(statusMap[index]=='accept'|| statusMap[index]=='mad')
                          if(isBeforeNow(reqs['datetime']))
                            if(withinTime(reqs['datetime']))
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children:[

                                  Padding(padding:EdgeInsets.fromLTRB(10, 0, 10, 0),child: ElevatedButton(
                                    style:ElevatedButton.styleFrom(
                                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                                      backgroundColor: Colors.red
                                    ),
                                    onPressed: (){handleDispute(index, reqs['from'] ?? '', reqs['to'] ?? '', reqs['service'] ?? '', reqs['datetime'] ?? '', reqs['place'] ?? '', reqs['status'] ?? '');}, 
                                    child: Text('Dispute',style: TextStyle(fontFamily: 'basic',color: Colors.white,fontSize: 18)))
                                  ),
                                  Padding(padding:EdgeInsets.fromLTRB(10, 0, 10, 0), child: ElevatedButton(
                                    style:ElevatedButton.styleFrom(
                                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                                      backgroundColor: Colors.green
                                      
                                    ),
                                    onPressed: (){
                                      complete(index, reqs['from'] ?? '', reqs['to'] ?? '', reqs['service'] ?? '', reqs['datetime'] ?? '', reqs['place'] ?? '', reqs['status'] ?? '');
                                    }, 
                                    child: Text('confirm' ,style: TextStyle(fontFamily: 'basic',color: Colors.white,fontSize: 18)))),
                              ])
                            else
                            Padding(padding: EdgeInsets.all(10),child: Text("Status: Accepted" , style:TextStyle(fontFamily: 'basic',fontSize: 18,color: Colors.green)))
                        
                          else
                            Padding(padding: EdgeInsets.all(10),child: Text("Status: Accepted" , style:TextStyle(fontFamily: 'basic',fontSize: 18,color: Colors.green)))
                        else if(statusMap[index]=='decline')
                          Padding(padding: EdgeInsets.all(10),child: Text("Status: Declined" , style:TextStyle(fontFamily: 'basic',fontSize: 18,color: Colors.red)))
                        else 
                          Padding(padding: EdgeInsets.all(10),child: Text("Status: Pending" , style:TextStyle(fontFamily: 'basic',fontSize: 18,color: Colors.amber))),
                        
                         
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
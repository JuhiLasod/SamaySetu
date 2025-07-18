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
    final res=await http.post(Uri.parse('http://10.0.2.2:8000/req/my-req'),
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
      
      if (status == 'accept') {
        msgMap[i] = 'You have accepted this request!';
      } else if (status == 'decline') {
        msgMap[i] = 'You have declined this request!';
      }
    }});

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
    final res=await http.post(Uri.parse('http://10.0.2.2:8000/req/complete'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({ 'from': email,  'to': to,  'service':service,  'datetime':datetime,  'place':place,  'status':status})
    );
    if(res.statusCode==200)
    {
      setState(() {
        statusMap[index]='complete';
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
           Expanded(
             child:  ListView.builder(
                         itemCount: req.length,
                         itemBuilder: (context, index){
                final reqs= req[index];
                return Padding(
                  padding: EdgeInsets.all(screenWidth * 0.03),
                  child: Container(
                    height: screenHeight * 0.28,
                    margin: EdgeInsets.all(screenWidth *0.05),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular( 20),
                      border: Border.all(color: Colors.grey.shade400, width: 1),
                      boxShadow:[ BoxShadow(
                        color: Colors.grey.withOpacity(0.2),
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
                        if(statusMap[index]=='complete')
                          Text("transaction completed")
                        else if(statusMap[index]=='accept'|| statusMap[index]=='mad')
                          if(isBeforeNow(reqs['datetime']))
                            if(withinTime(reqs['datetime']))
                              Row(children:[
                                  ElevatedButton(onPressed: (){}, child: Text('dispute')),
                                  ElevatedButton(onPressed: (){complete(index, reqs['from'] ?? '', reqs['to'] ?? '', reqs['service'] ?? '', reqs['datetime'] ?? '', reqs['place'] ?? '', reqs['status'] ?? '');}, child: Text('confirm')),
                              ])
                            else
                              Text("since you didnt inform us the status of recieving this service we assumed that you did recieve it and you balace was successfully updated")
                          else
                            Padding(padding: EdgeInsets.all(10),child: Text("Status: Accepted" , style:TextStyle(fontFamily: 'basic',fontSize: 18,color: Colors.green)))
                        else if(statusMap[index]=='decline')
                          Padding(padding: EdgeInsets.all(10),child: Text("Status: Declined" , style:TextStyle(fontFamily: 'basic',fontSize: 18,color: Colors.red)))
                        else 
                          Padding(padding: EdgeInsets.all(10),child: Text("Status: Pending" , style:TextStyle(fontFamily: 'basic',fontSize: 18,color: Colors.amber)))
                         
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
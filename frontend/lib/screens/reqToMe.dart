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
  DateTime now = DateTime.now().toUtc();
  // String status='pending';
  Map<int, String> statusMap = {};  
  Map<int, String> msgMap = {};
  Map<int, bool> showMAD = {};
  // DateTime now = DateTime.now().toUtc();

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
    req = data;

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
      print(msgMap[i]);
      DateTime dt = DateTime.parse(data[i]['datetime']).toUtc();
      
      if(statusMap[i] =='accept' )
      {
        print("accept wale if k andr");
        if ( dt .isAtSameMomentAs(now) || dt .isBefore(now)) {
        setState(() {
          showMAD[i]=true;
        });
        }
      }
      else{
        setState(() {
          showMAD[i]=false;
        });
      }
      
    }
  });



  }
  void handleStatus(int index, String from, String to, String service, String datetime, String place, String status)async{
    // final prefs=await SharedPreferences.getInstance();
    // final to=await  prefs.getString('email');
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
    setState(() {
  statusMap[index] = status;
  msgMap[index] = (status == 'accept')
      ? "You have accepted this request!"
      : "You have declined this request!";
});

  }
  else
  {
    setState(() {
  statusMap[index] = 'pending';
});

  }
    // print(from);
    // print(from);
  }
  void handleMAD(int index, String from, String to, String service, String datetime, String place)async
  {
    print("inside handleMAD");
    final res = await http.post(Uri.parse("http://10.0.2.2:8000/req/set-mad"),
      headers: {'Content-Type':'application/json'},
      body: jsonEncode({ 'from': from,  'to': to,  'service':service,  'datetime':datetime,  'place':place,  'status':'accept'})
    );
    print("Response status: ${res.statusCode}");
    if(res.statusCode==200)
    {
      setState(() {
        statusMap[index]='mad';
        print("mad set");
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
                    height: screenHeight * 0.32,
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
                      title:Text(reqs['service'] ?? '',textAlign: TextAlign.center,style: TextStyle(fontSize: 30,fontFamily: 'title',color: Color.fromARGB(255, 15, 111, 196),fontWeight: FontWeight.bold)),
                      subtitle: Column(children: [
                        Padding(padding: EdgeInsets.all(10),child: Text("From: ${reqs['from'] ?? ''}" , style:TextStyle(fontFamily: 'basic',fontSize: 18))),
                        Padding(padding: EdgeInsets.all(10),child: Text("DateTime: ${reqs['datetime'] ?? ''}" , style:TextStyle(fontFamily: 'basic',fontSize: 18))),
                        Padding(padding: EdgeInsets.all(10),child: Text("Place: ${reqs['place'] ?? ''}" , style:TextStyle(fontFamily: 'basic',fontSize: 18))),
                        if(statusMap[index]=='complete')
                          Padding(padding: EdgeInsets.fromLTRB(0, 20, 0, 20),child: Text("Transaction completed",style: TextStyle(fontFamily: 'basic',fontSize: 20,color:  Colors.green),))
                        else if(statusMap[index]=='mad')
                          Padding(padding:EdgeInsets.fromLTRB(0, 20, 0, 20),child: Text("Waiting for recievers confirmation...",style:TextStyle(fontSize: 20,fontFamily: 'basic',color:Colors.amber)))
                        else if(statusMap[index]=='accept' && showMAD[index]==true)
                          Padding(padding: EdgeInsets.all(10),
                            child: Column(children:[ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                                
                              ),
                              onPressed: (){handleMAD(index, reqs['from'] ?? '', reqs['to'] ?? '', reqs['service'] ?? '', reqs['datetime'] ?? '', reqs['place'] ?? '');}, 
                              child: Text('Mark as done',
                                style:TextStyle(
                                  fontFamily: 'basic',
                                  fontSize: 20, 
                                  color: Colors.green
                                )
                              )
                            ), 
                            Text('Mark as done within 48 hrs after delivering the service to gain your reward',textAlign: TextAlign.center,style:TextStyle(color: Color.fromARGB(255, 15, 111, 196)))]))
                      
                        else
                        if ((statusMap[index] ?? 'pending') == 'pending') ...[
  Center(
    child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children:[
    Padding(padding:EdgeInsets.fromLTRB(10, 0, 10, 0),
      child: ElevatedButton(
        onPressed: () {
          handleStatus(index, reqs['from'] ?? '', reqs['to'] ?? '', reqs['service'] ?? '', reqs['datetime'] ?? '', reqs['place'] ?? '', 'accept');
        },
        child: Text('Accept'),
      ),
    ),
    Padding(padding:EdgeInsets.fromLTRB(10, 10, 10, 10),
    child:
    ElevatedButton(
      onPressed: () {
        handleStatus(index, reqs['from'] ?? '', reqs['to'] ?? '', reqs['service'] ?? '', reqs['datetime'] ?? '', reqs['place'] ?? '', 'decline');
      },
      child: Text('Decline'),
    ),)]),
  )
] else ...[
  if(statusMap[index]=='accept'&& msgMap[index]=='You have accepted this request!')
  Padding(
    padding:EdgeInsets.fromLTRB(10, 10, 10, 10),
    child: 
    
    Text(
      msgMap[index] ?? '',
      style: TextStyle(fontSize: 22, fontFamily: 'basic',color: Colors.green),
    ),
  )
  else if(statusMap[index]=='decline')
  Padding(
    padding:EdgeInsets.fromLTRB(10, 10, 10, 10),
    child: 
    
    Text(
      msgMap[index] ?? '',
      style: TextStyle(fontSize: 22, fontFamily: 'basic',color: Colors.red),
    ),
  )
]


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
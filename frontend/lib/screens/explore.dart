import 'package:flutter/material.dart';
import './exploreChoice.dart';
import 'package:shared_preferences/shared_preferences.dart';
import "package:http/http.dart" as http;
import "dart:convert";

class explore extends StatefulWidget{

  @override
  State<explore> createState()=>_exploreState();
}

class _exploreState extends State<explore>{

  String selected='';

  bool is1=false;
  bool is11=false;
  bool is12=false;
  bool is13=false;
  bool is14=false;

  bool is2=false;
  bool is21=false;
  bool is22=false;
  bool is23=false;
  bool is24=false;

  bool is3=false;
  bool is31=false;
  bool is32=false;
  bool is33=false;
  bool is34=false;

  bool is4=false;
  bool is41=false;
  bool is42=false;
  bool is43=false;
  bool is44=false;

  bool is5=false;
  bool is51=false;
  bool is52=false;
  bool is53=false;
  bool is54=false;

  bool is6=false;
  bool is61=false;
  bool is62=false;
  bool is63=false;
  bool is64=false;

  bool is7=false;
  bool is71=false;
  bool is72=false;
  bool is73=false;
  bool is74=false;

  bool balance=true;

  Future<void> checkBalance()async
  {
    print("inside check balance fn");
    final prefs=await SharedPreferences.getInstance();
    final email=prefs.getString('email');
    print(email);
    // setState(() {
    //   balance=false;
    // });
    final res= await http.post(Uri.parse("http://10.0.2.2:8000/req/check-balance"),
      headers:{'Content-Type':'application/json'},
      body: jsonEncode({'email':email})
    );
    print("Response status: ${res.statusCode}");
    print("Response body: ${res.body}");
    if(res.statusCode==200)
      {
        
        setState(() {
          balance=true;
        });
        print("balane ka setstate k baad");
        print(balance);
      }
      else
      {
        setState(() {
          balance=false;
        });
      }
    }
    
      

  void chosen(String selected){
    
    Navigator.push(context, MaterialPageRoute(builder: (context)=> exploreChoice(selected: selected)));
  }

  @override

  void initState()
  {
    super.initState();
    print("checking balance");
    checkBalance();
  }
  Widget build(BuildContext context){
    final screenHeight= MediaQuery.of(context).size.height;
    final screenWidth=MediaQuery.of(context).size.width;
    return Scaffold(
      body: 
        Column(
          // mainAxisAlignment: MainAxisAlignment.center,
          // crossAxisAlignment: CrossAxisAlignment.center,
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
          if(!balance)
            Expanded(
              child: Center(
                child: Padding(padding:EdgeInsets.fromLTRB(20, 0, 20, 0),child: Text("Oops! You're out of balance. Start helping others to earn more and make the most of SamaySetu.", 
                  textAlign: TextAlign.center,
                  style: TextStyle(fontFamily: 'basic',fontSize: 20,color: Colors.red))
                ),
              ),
            )
          else
          Expanded(
            child: SingleChildScrollView(
              child: Column(children: [
                Padding(
                            padding: EdgeInsets.fromLTRB(0,screenHeight * 0.02,0,screenHeight * 0.02),
                            child: GestureDetector(
                              onTap: (){setState(() {
                                is1=!is1;
                              });},
                              child: Container(
                                height: is1? screenHeight * 0.5 : screenHeight * 0.15,
                                width:  screenWidth * 0.8,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(30),
                                  color: Color.fromARGB(255, 15, 111, 196),
                                  
                                ),
                                // BorderRadius(border: RoundedRectangleBorder(),)
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                  Text('Education and Learning',style: TextStyle(fontFamily: 'title',fontWeight: FontWeight.bold ,fontSize: 35),),
                                  
                                  if(is1)
                                    GestureDetector(
                                        onTap: (){
                                              setState(() {
                                                selected='Tutoring';
                                                chosen(selected);
                                              });
                                            },
                                       
                                        child: Padding(
                                          padding: EdgeInsets.all(10),
                                          child: Container(
                                            alignment: Alignment.center,
                                        decoration:  BoxDecoration(color:  Color.fromARGB(255, 1, 54, 98)  ,borderRadius: BorderRadius.circular(20)),
                                        height: screenHeight * 0.07,
                                        width: screenWidth * 0.7,
                                            child: Text('Tutoring' ,style: TextStyle(
                                              fontFamily: 'basic',
                                              fontSize: 20,
                                              
                                              color: Color.fromARGB(255, 15, 111, 196) 
                                            ),)
                                          )
                                        ),
                                      ),
                                  
                            
                                  //service no 2
                                  if(is1)
                                  GestureDetector(
                                        onTap: (){
                                              setState(() {
                                                selected='Career Guidance';
                                                chosen(selected);
                                              });
                                            },
                                       
                                        child: Padding(
                                          padding: EdgeInsets.all(10),
                                          child: Container(
                                            alignment: Alignment.center,
                                        decoration:  BoxDecoration(color:  Color.fromARGB(255, 1, 54, 98)  ,borderRadius: BorderRadius.circular(20)),
                                        height: screenHeight * 0.07,
                                        width: screenWidth * 0.7,
                                            child: Text('Career Guidance' ,style: TextStyle(
                                              fontFamily: 'basic',
                                              fontSize: 20,
                                              
                                              color:  Color.fromARGB(255, 15, 111, 196) 
                                            ),)
                                          )
                                        ),
                                      ),
                            
                                  //service no 3
                                  if(is1)
                                  GestureDetector(
                                        onTap: (){
                                              setState(() {
                                                selected='Teaching Digital Literacy';
                                                chosen(selected);
                                              });
                                            },
                                       
                                        child: Padding(
                                          padding: EdgeInsets.all(10),
                                          child: Container(
                                            alignment: Alignment.center,
                                        decoration:  BoxDecoration(color:  Color.fromARGB(255, 1, 54, 98) ,borderRadius: BorderRadius.circular(20)),
                                        height: screenHeight * 0.07,
                                        width: screenWidth * 0.7,
                                            child: Text('Teaching Digital Literacy' ,style: TextStyle(
                                              fontFamily: 'basic',
                                              fontSize: 20,
                                              
                                              color:  Color.fromARGB(255, 15, 111, 196) 
                                            ),)
                                          )
                                        ),
                                      ),
                            
                                      //service 4
                                  if(is1)
                                  GestureDetector(
                                        onTap: (){
                                              setState(() {
                                                selected='Homework Help';
                                                chosen(selected);
                                              });
                                            },
                                       
                                        child: Padding(
                                          padding: EdgeInsets.all(10),
                                          child: Container(
                                            alignment: Alignment.center,
                                        decoration:  BoxDecoration(color: Color.fromARGB(255, 1, 54, 98)  ,borderRadius: BorderRadius.circular(20)),
                                        height: screenHeight * 0.07,
                                        width: screenWidth * 0.7,
                                            child: Text('Homework Help' ,style: TextStyle(
                                              fontFamily: 'basic',
                                              fontSize: 20,
                                              
                                              color:  Color.fromARGB(255, 15, 111, 196) 
                                            ),)
                                          )
                                        ),
                                      ),
                                ],)
                              ),
                            ),
                          ),
                      
                      
                      // health and wellness
                        Padding(
                          padding: EdgeInsets.fromLTRB(0,screenHeight * 0.02,0,screenHeight * 0.02),
                          child: GestureDetector(
                            onTap: (){setState(() {
                              is2=!is2;
                            });},
                            child: Container(
                              height: is2? screenHeight * 0.5 : screenHeight * 0.15,
                              width:  screenWidth * 0.8,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(30),
                                color: Color.fromARGB(255, 15, 111, 196),
                                
                              ),
                              // BorderRadius(border: RoundedRectangleBorder(),)
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                Text('Health and Wellness',style: TextStyle(fontFamily: 'title',fontWeight: FontWeight.bold ,fontSize: 35),),
                                
                                if(is2)
                                  GestureDetector(
                                      onTap: (){
                                            setState(() {
                                              selected='Mental Health Support';
                                              chosen(selected);
                                            });
                                          },
                                     
                                      child: Padding(
                                        padding: EdgeInsets.all(10),
                                        child: Container(
                                          alignment: Alignment.center,
                                      decoration:  BoxDecoration(color:  Color.fromARGB(255, 1, 54, 98)  ,borderRadius: BorderRadius.circular(20)),
                                      height: screenHeight * 0.07,
                                      width: screenWidth * 0.7,
                                          child: Text('Mental Health Support' ,style: TextStyle(
                                            fontFamily: 'basic',
                                            fontSize: 20,
                                            
                                            color:  Color.fromARGB(255, 15, 111, 196)
                                          ),)
                                        )
                                      ),
                                    ),
                                
                          
                                //service no 2
                                if(is2)
                                GestureDetector(
                                      onTap: (){
                                            setState(() {
                                              selected='Yoga or Fitness';
                                              chosen(selected);
                                            });
                                          },
                                     
                                      child: Padding(
                                        padding: EdgeInsets.all(10),
                                        child: Container(
                                          alignment: Alignment.center,
                                      decoration:  BoxDecoration(color:  Color.fromARGB(255, 1, 54, 98) ,borderRadius: BorderRadius.circular(20)),
                                      height: screenHeight * 0.07,
                                      width: screenWidth * 0.7,
                                          child: Text('Yoga or Fitness' ,style: TextStyle(
                                            fontFamily: 'basic',
                                            fontSize: 20,
                                            
                                            color: Color.fromARGB(255, 15, 111, 196) 
                                          ),)
                                        )
                                      ),
                                    ),
                          
                                //service no 3
                                if(is2)
                                GestureDetector(
                                      onTap: (){
                                            setState(() {
                                              selected='Nutrition Guidance';
                                              chosen(selected);
                                            });
                                          },
                                     
                                      child: Padding(
                                        padding: EdgeInsets.all(10),
                                        child: Container(
                                          alignment: Alignment.center,
                                      decoration:  BoxDecoration(color: Color.fromARGB(255, 1, 54, 98)  ,borderRadius: BorderRadius.circular(20)),
                                      height: screenHeight * 0.07,
                                      width: screenWidth * 0.7,
                                          child: Text('Nutrition Guidance' ,style: TextStyle(
                                            fontFamily: 'basic',
                                            fontSize: 20,
                                            
                                            color:  Color.fromARGB(255, 15, 111, 196) 
                                          ),)
                                        )
                                      ),
                                    ),
                          
                                    //service 4
                                if(is2)
                                GestureDetector(
                                      onTap: (){
                                            setState(() {
                                              selected='Basic First Aid Knowledge';
                                              chosen(selected);
                                            });
                                          },
                                     
                                      child: Padding(
                                        padding: EdgeInsets.all(10),
                                        child: Container(
                                          alignment: Alignment.center,
                                      decoration:  BoxDecoration(color:  Color.fromARGB(255, 1, 54, 98)  ,borderRadius: BorderRadius.circular(20)),
                                      height: screenHeight * 0.07,
                                      width: screenWidth * 0.7,
                                          child: Text('Basic First Aid Knowledge' ,style: TextStyle(
                                            fontFamily: 'basic',
                                            fontSize: 20,
                                            
                                            color:  Color.fromARGB(255, 15, 111, 196)
                                          ),)
                                        )
                                      ),
                                    ),
                              ],)
                            ),
                          ),
                        ),
                      
                      //technical help
                        Padding(
                          padding: EdgeInsets.fromLTRB(0,screenHeight * 0.02,0,screenHeight * 0.02),
                          child: GestureDetector(
                            onTap: (){setState(() {
                              is3=!is3;
                            });},
                            child: Container(
                              height: is3? screenHeight * 0.5 : screenHeight * 0.15,
                              width:  screenWidth * 0.8,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(30),
                                color: Color.fromARGB(255, 15, 111, 196),
                                
                              ),
                              // BorderRadius(border: RoundedRectangleBorder(),)
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                Text('Technical Help',style: TextStyle(fontFamily: 'title',fontWeight: FontWeight.bold ,fontSize: 35),),
                                
                                if(is3)
                                  GestureDetector(
                                      onTap: (){
                                            setState(() {
                                              selected='App/Website Development';
                                              chosen(selected);
                                            });
                                          },
                                     
                                      child: Padding(
                                        padding: EdgeInsets.all(10),
                                        child: Container(
                                          alignment: Alignment.center,
                                      decoration:  BoxDecoration(color: Color.fromARGB(255, 1, 54, 98) ,borderRadius: BorderRadius.circular(20)),
                                      height: screenHeight * 0.07,
                                      width: screenWidth * 0.7,
                                          child: Text('App/Website Development' ,style: TextStyle(
                                            fontFamily: 'basic',
                                            fontSize: 20,
                                            
                                            color:  Color.fromARGB(255, 15, 111, 196) 
                                          ),)
                                        )
                                      ),
                                    ),
                                
                          
                                //service no 2
                                if(is3)
                                GestureDetector(
                                      onTap: (){
                                            setState(() {
                                              selected='Career Guidance';
                                              chosen(selected);
                                            });
                                          },
                                     
                                      child: Padding(
                                        padding: EdgeInsets.all(10),
                                        child: Container(
                                          alignment: Alignment.center,
                                      decoration:  BoxDecoration(color:  Color.fromARGB(255, 1, 54, 98) ,borderRadius: BorderRadius.circular(20)),
                                      height: screenHeight * 0.07,
                                      width: screenWidth * 0.7,
                                          child: Text('Career Guidance' ,style: TextStyle(
                                            fontFamily: 'basic',
                                            fontSize: 20,
                                            
                                            color:  Color.fromARGB(255, 15, 111, 196) 
                                          ),)
                                        )
                                      ),
                                    ),
                          
                                //service no 3
                                if(is3)
                                GestureDetector(
                                      onTap: (){
                                            setState(() {
                                              selected='Setting Up Devices For Elders';
                                              chosen(selected);
                                            });
                                          },
                                     
                                      child: Padding(
                                        padding: EdgeInsets.all(10),
                                        child: Container(
                                          alignment: Alignment.center,
                                      decoration:  BoxDecoration(color: Color.fromARGB(255, 1, 54, 98) ,borderRadius: BorderRadius.circular(20)),
                                      height: screenHeight * 0.07,
                                      width: screenWidth * 0.7,
                                          child: Text('Setting Up Devices For Elders' ,style: TextStyle(
                                            fontFamily: 'basic',
                                            fontSize: 20,
                                            
                                            color: Color.fromARGB(255, 15, 111, 196) 
                                          ),)
                                        )
                                      ),
                                    ),
                          
                                    //service 4
                                if(is3)
                                GestureDetector(
                                      onTap: (){
                                            setState(() {
                                              selected='Graphic Design/ UI Help';
                                              chosen(selected);
                                            });
                                          },
                                     
                                      child: Padding(
                                        padding: EdgeInsets.all(10),
                                        child: Container(
                                          alignment: Alignment.center,
                                      decoration:  BoxDecoration(color: Color.fromARGB(255, 1, 54, 98)  ,borderRadius: BorderRadius.circular(20)),
                                      height: screenHeight * 0.07,
                                      width: screenWidth * 0.7,
                                          child: Text('Graphic Design/ UI Help' ,style: TextStyle(
                                            fontFamily: 'basic',
                                            fontSize: 20,
                                            
                                            color: Color.fromARGB(255, 15, 111, 196) 
                                          ),)
                                        )
                                      ),
                                    ),
                              ],)
                            ),
                          ),
                        ),
                      
                      //elder support
                        Padding(
                          padding: EdgeInsets.fromLTRB(0,screenHeight * 0.02,0,screenHeight * 0.02),
                          child: GestureDetector(
                            onTap: (){setState(() {
                              is4=!is4;
                            });},
                            child: Container(
                              height: is4? screenHeight * 0.5 : screenHeight * 0.15,
                              width:  screenWidth * 0.8,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(30),
                                color: Color.fromARGB(255, 15, 111, 196),
                                
                              ),
                              // BorderRadius(border: RoundedRectangleBorder(),)
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                Text('Elder Support',style: TextStyle(fontFamily: 'title',fontWeight: FontWeight.bold ,fontSize: 35),),
                                
                                if(is4)
                                  GestureDetector(
                                      onTap: (){
                                            setState(() {
                                              selected='Reading To Elderly';
                                              chosen(selected);
                                            });
                                          },
                                     
                                      child: Padding(
                                        padding: EdgeInsets.all(10),
                                        child: Container(
                                          alignment: Alignment.center,
                                      decoration:  BoxDecoration(color: Color.fromARGB(255, 1, 54, 98),borderRadius: BorderRadius.circular(20)),
                                      height: screenHeight * 0.07,
                                      width: screenWidth * 0.7,
                                          child: Text('Reading To Elderly' ,style: TextStyle(
                                            fontFamily: 'basic',
                                            fontSize: 20,
                                            
                                            color:  Color.fromARGB(255, 15, 111, 196) 
                                          ),)
                                        )
                                      ),
                                    ),
                                
                          
                                //service no 2
                                if(is4)
                                GestureDetector(
                                      onTap: (){
                                            setState(() {
                                              selected='Grocery Ordering Help';
                                              chosen(selected);
                                            });
                                          },
                                     
                                      child: Padding(
                                        padding: EdgeInsets.all(10),
                                        child: Container(
                                          alignment: Alignment.center,
                                      decoration:  BoxDecoration(color:  Color.fromARGB(255, 1, 54, 98) ,borderRadius: BorderRadius.circular(20)),
                                      height: screenHeight * 0.07,
                                      width: screenWidth * 0.7,
                                          child: Text('Grocery Ordering Help' ,style: TextStyle(
                                            fontFamily: 'basic',
                                            fontSize: 20,
                                            
                                            color: Color.fromARGB(255, 15, 111, 196) 
                                          ),)
                                        )
                                      ),
                                    ),
                          
                                //service no 3
                                if(is4)
                                GestureDetector(
                                      onTap: (){
                                            setState(() {
                                              selected='Making Calls/Check-Ins';
                                              chosen(selected);
                                            });
                                          },
                                     
                                      child: Padding(
                                        padding: EdgeInsets.all(10),
                                        child: Container(
                                          alignment: Alignment.center,
                                      decoration:  BoxDecoration(color: Color.fromARGB(255, 1, 54, 98)  ,borderRadius: BorderRadius.circular(20)),
                                      height: screenHeight * 0.07,
                                      width: screenWidth * 0.7,
                                          child: Text('Making Calls/Check-Ins' ,style: TextStyle(
                                            fontFamily: 'basic',
                                            fontSize: 20,
                                            
                                            color: Color.fromARGB(255, 15, 111, 196) 
                                          ),)
                                        )
                                      ),
                                    ),
                          
                                    //service 4
                                if(is4)
                                GestureDetector(
                                      onTap: (){
                                            setState(() {
                                              selected='Teaching Phone Apps';
                                              chosen(selected);
                                            });
                                          },
                                     
                                      child: Padding(
                                        padding: EdgeInsets.all(10),
                                        child: Container(
                                          alignment: Alignment.center,
                                      decoration:  BoxDecoration(color:  Color.fromARGB(255, 1, 54, 98)  ,borderRadius: BorderRadius.circular(20)),
                                      height: screenHeight * 0.07,
                                      width: screenWidth * 0.7,
                                          child: Text('Teaching Phone Apps' ,style: TextStyle(
                                            fontFamily: 'basic',
                                            fontSize: 20,
                                            
                                            color:  Color.fromARGB(255, 15, 111, 196) 
                                          ),)
                                        )
                                      ),
                                    ),
                          
                          
                              ],)
                            ),
                          ),
                        ),
                      
                      //Communication
                        Padding(
                          padding: EdgeInsets.fromLTRB(0,screenHeight * 0.02,0,screenHeight * 0.02),
                          child: GestureDetector(
                            onTap: (){setState(() {
                              is5=!is5;
                            });},
                            child: Container(
                              height: is5? screenHeight * 0.5 : screenHeight * 0.15,
                              width:  screenWidth * 0.8,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(30),
                                color: Color.fromARGB(255, 15, 111, 196),
                                
                              ),
                              // BorderRadius(border: RoundedRectangleBorder(),)
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                Text('Communication',style: TextStyle(fontFamily: 'title',fontWeight: FontWeight.bold ,fontSize: 35),),
                                
                                if(is5)
                                  GestureDetector(
                                      onTap: (){
                                            setState(() {
                                              selected='Translation';
                                              chosen(selected);
                                            });
                                          },
                                     
                                      child: Padding(
                                        padding: EdgeInsets.all(10),
                                        child: Container(
                                          alignment: Alignment.center,
                                      decoration:  BoxDecoration(color:  Color.fromARGB(255, 1, 54, 98) ,borderRadius: BorderRadius.circular(20)),
                                      height: screenHeight * 0.07,
                                      width: screenWidth * 0.7,
                                          child: Text('Translation' ,style: TextStyle(
                                            fontFamily: 'basic',
                                            fontSize: 20,
                                            
                                            color:  Color.fromARGB(255, 15, 111, 196)
                                          ),)
                                        )
                                      ),
                                    ),
                                
                          
                                //service no 2
                                if(is5)
                                GestureDetector(
                                      onTap: (){
                                            setState(() {
                                              selected='Resume Writing/SOP Help';
                                              chosen(selected);
                                            });
                                          },
                                     
                                      child: Padding(
                                        padding: EdgeInsets.all(10),
                                        child: Container(
                                          alignment: Alignment.center,
                                      decoration:  BoxDecoration(color: Color.fromARGB(255, 1, 54, 98) ,borderRadius: BorderRadius.circular(20)),
                                      height: screenHeight * 0.07,
                                      width: screenWidth * 0.7,
                                          child: Text('Resume Writing/SOP Help' ,style: TextStyle(
                                            fontFamily: 'basic',
                                            fontSize: 20,
                                            
                                            color:  Color.fromARGB(255, 15, 111, 196) 
                                          ),)
                                        )
                                      ),
                                    ),
                          
                                //service no 3
                                if(is5)
                                GestureDetector(
                                      onTap: (){
                                            setState(() {
                                              selected='Public Speaking Practice';
                                              chosen(selected);
                                            });
                                          },
                                     
                                      child: Padding(
                                        padding: EdgeInsets.all(10),
                                        child: Container(
                                          alignment: Alignment.center,
                                      decoration:  BoxDecoration(color: Color.fromARGB(255, 1, 54, 98)  ,borderRadius: BorderRadius.circular(20)),
                                      height: screenHeight * 0.07,
                                      width: screenWidth * 0.7,
                                          child: Text('Public Speaking Practice' ,style: TextStyle(
                                            fontFamily: 'basic',
                                            fontSize: 20,
                                            
                                            color:  Color.fromARGB(255, 15, 111, 196) 
                                          ),)
                                        )
                                      ),
                                    ),
                          
                                    //service 4
                                if(is5)
                                GestureDetector(
                                      onTap: (){
                                            setState(() {
                                              selected='Language Conversation Partner';
                                              chosen(selected);
                                            });
                                          },
                                     
                                      child: Padding(
                                        padding: EdgeInsets.all(10),
                                        child: Container(
                                          alignment: Alignment.center,
                                      decoration:  BoxDecoration(color: Color.fromARGB(255, 1, 54, 98)  ,borderRadius: BorderRadius.circular(20)),
                                      height: screenHeight * 0.07,
                                      width: screenWidth * 0.7,
                                          child: Text('Language Conversation Partner' ,style: TextStyle(
                                            fontFamily: 'basic',
                                            fontSize: 20,
                                            
                                            color: Color.fromARGB(255, 15, 111, 196) 
                                          ),)
                                        )
                                      ),
                                    ),
                          
                                    
                              ],)
                            ),
                          ),
                        ),
                      
                      //creative services
                        Padding(
                          padding: EdgeInsets.fromLTRB(0,screenHeight * 0.02,0,screenHeight * 0.02),
                          child: GestureDetector(
                            onTap: (){setState(() {
                              is6=!is6;
                            });},
                            child: Container(
                              height: is6? screenHeight * 0.5 : screenHeight * 0.15,
                              width:  screenWidth * 0.8,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(30),
                                color: Color.fromARGB(255, 15, 111, 196),
                                
                              ),
                              // BorderRadius(border: RoundedRectangleBorder(),)
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                Text('Creative Services',style: TextStyle(fontFamily: 'title',fontWeight: FontWeight.bold ,fontSize: 35),),
                                
                                if(is6)
                                  GestureDetector(
                                      onTap: (){
                                            setState(() {
                                              selected='Art and Craft Sessions';
                                              chosen(selected);
                                            });
                                          },
                                     
                                      child: Padding(
                                        padding: EdgeInsets.all(10),
                                        child: Container(
                                          alignment: Alignment.center,
                                      decoration:  BoxDecoration(color:  Color.fromARGB(255, 1, 54, 98)  ,borderRadius: BorderRadius.circular(20)),
                                      height: screenHeight * 0.07,
                                      width: screenWidth * 0.7,
                                          child: Text('Art and Craft Sessions' ,style: TextStyle(
                                            fontFamily: 'basic',
                                            fontSize: 20,
                                            
                                            color: Color.fromARGB(255, 15, 111, 196) 
                                          ),)
                                        )
                                      ),
                                    ),
                                
                          
                                //service no 2
                                if(is6)
                                GestureDetector(
                                      onTap: (){
                                            setState(() {
                                              selected='Photography';
                                              chosen(selected);
                                            });
                                          },
                                     
                                      child: Padding(
                                        padding: EdgeInsets.all(10),
                                        child: Container(
                                          alignment: Alignment.center,
                                      decoration:  BoxDecoration(color:  Color.fromARGB(255, 1, 54, 98)  ,borderRadius: BorderRadius.circular(20)),
                                      height: screenHeight * 0.07,
                                      width: screenWidth * 0.7,
                                          child: Text('Photography' ,style: TextStyle(
                                            fontFamily: 'basic',
                                            fontSize: 20,
                                            
                                            color: Color.fromARGB(255, 15, 111, 196) 
                                          ),)
                                        )
                                      ),
                                    ),
                          
                                //service no 3
                                if(is6)
                                GestureDetector(
                                      onTap: (){
                                            setState(() {
                                              selected='Music';
                                              chosen(selected);
                                            });
                                          },
                                     
                                      child: Padding(
                                        padding: EdgeInsets.all(10),
                                        child: Container(
                                          alignment: Alignment.center,
                                      decoration:  BoxDecoration(color:  Color.fromARGB(255, 1, 54, 98)  ,borderRadius: BorderRadius.circular(20)),
                                      height: screenHeight * 0.07,
                                      width: screenWidth * 0.7,
                                          child: Text('Music' ,style: TextStyle(
                                            fontFamily: 'basic',
                                            fontSize: 20,
                                            
                                            color: Color.fromARGB(255, 15, 111, 196)
                                          ),)
                                        )
                                      ),
                                    ),
                          
                                    //service 4
                                if(is6)
                                GestureDetector(
                                      onTap: (){
                                            setState(() {
                                              selected='Knitting';
                                              chosen(selected);
                                            });
                                          },
                                     
                                      child: Padding(
                                        padding: EdgeInsets.all(10),
                                        child: Container(
                                          alignment: Alignment.center,
                                      decoration:  BoxDecoration(color: Color.fromARGB(255, 1, 54, 98)  ,borderRadius: BorderRadius.circular(20)),
                                      height: screenHeight * 0.07,
                                      width: screenWidth * 0.7,
                                          child: Text('Knitting' ,style: TextStyle(
                                            fontFamily: 'basic',
                                            fontSize: 20,
                                            
                                            color:  Color.fromARGB(255, 15, 111, 196) 
                                          ),)
                                        )
                                      ),
                                    ),
                          
                                    
                              ],)
                            ),
                          ),
                        ),
                      
                      //community sertvices
                        Padding(
                          padding: EdgeInsets.fromLTRB(0,screenHeight * 0.02,0,screenHeight * 0.02),
                          child: GestureDetector(
                            onTap: (){setState(() {
                              is7=!is7;
                            });},
                            child: Container(
                              height: is7? screenHeight * 0.5 : screenHeight * 0.15,
                              width:  screenWidth * 0.8,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(30),
                                color: Color.fromARGB(255, 15, 111, 196),
                                
                              ),
                              // BorderRadius(border: RoundedRectangleBorder(),)
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                Text('Community Services',style: TextStyle(fontFamily: 'title',fontWeight: FontWeight.bold ,fontSize: 35),),
                                
                                if(is7)
                                  GestureDetector(
                                      onTap: (){
                                            setState(() {
                                              selected='Event Organising';
                                              chosen(selected);
                                            });
                                          },
                                     
                                      child: Padding(
                                        padding: EdgeInsets.all(10),
                                        child: Container(
                                          alignment: Alignment.center,
                                      decoration:  BoxDecoration(color: Color.fromARGB(255, 1, 54, 98) ,borderRadius: BorderRadius.circular(20)),
                                      height: screenHeight * 0.07,
                                      width: screenWidth * 0.7,
                                          child: Text('Event Organising' ,style: TextStyle(
                                            fontFamily: 'basic',
                                            fontSize: 20,
                                            
                                            color: Color.fromARGB(255, 15, 111, 196) 
                                          ),)
                                        )
                                      ),
                                    ),
                                
                          
                                //service no 2
                                if(is7)
                                GestureDetector(
                                      onTap: (){
                                            setState(() {
                                              selected='Crowd Management Volunteering';
                                              chosen(selected);
                                            });
                                          },
                                     
                                      child: Padding(
                                        padding: EdgeInsets.all(10),
                                        child: Container(
                                          alignment: Alignment.center,
                                      decoration:  BoxDecoration(color: Color.fromARGB(255, 1, 54, 98)  ,borderRadius: BorderRadius.circular(20)),
                                      height: screenHeight * 0.07,
                                      width: screenWidth * 0.7,
                                          child: Text('Crowd Management Volunteering' ,style: TextStyle(
                                            fontFamily: 'basic',
                                            fontSize: 20,
                                            
                                            color:  Color.fromARGB(255, 15, 111, 196) 
                                          ),)
                                        )
                                      ),
                                    ),
                          
                                //service no 3
                                if(is7)
                                GestureDetector(
                                      onTap: (){
                                            setState(() {
                                              selected='Waste Segregation Training';
                                              chosen(selected);
                                            });
                                          },
                                     
                                      child: Padding(
                                        padding: EdgeInsets.all(10),
                                        child: Container(
                                          alignment: Alignment.center,
                                      decoration:  BoxDecoration(color:  Color.fromARGB(255, 1, 54, 98)  ,borderRadius: BorderRadius.circular(20)),
                                      height: screenHeight * 0.07,
                                      width: screenWidth * 0.7,
                                          child: Text('Waste Segregation Training' ,style: TextStyle(
                                            fontFamily: 'basic',
                                            fontSize: 20,
                                            
                                            color:  Color.fromARGB(255, 15, 111, 196)
                                          ),)
                                        )
                                      ),
                                    ),
                          
                                    //service 4
                                if(is7)
                                GestureDetector(
                                      onTap: (){
                                            setState(() {
                                              selected='Awareness Campaign';
                                              chosen(selected);
                                            });
                                          },
                                     
                                      child: Padding(
                                        padding: EdgeInsets.all(10),
                                        child: Container(
                                          alignment: Alignment.center,
                                      decoration:  BoxDecoration(color: is74? Color.fromARGB(255, 1, 54, 98) : Color.fromARGB(255, 67, 153, 227) ,borderRadius: BorderRadius.circular(20)),
                                      height: screenHeight * 0.07,
                                      width: screenWidth * 0.7,
                                          child: Text('Awareness Campaign' ,style: TextStyle(
                                            fontFamily: 'basic',
                                            fontSize: 20,
                                            
                                            color: Color.fromARGB(255, 15, 111, 196) 
                                          ),)
                                        )
                                      ),
                                    ),
                          
                                    
                              ],)
                            ),
                          ),
                        ),
              ]),
            ),
          )
          ]),
      
    );
  }
}
import 'dart:io';
// import 'package:permission_handler/permission_handler.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
// import '.../assets/images/logo.png';
// import 'D:\JUHI\SamaySetu\frontend\assets\images\logo.png'
import 'package:path/path.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import './home.dart';
class editProfile extends StatefulWidget
{
  const editProfile({super.key});
  State<editProfile> createState()=> _editProfileState();
}
class _editProfileState extends State<editProfile>
{

  final TextEditingController _namec=TextEditingController();
  final TextEditingController _bioc=TextEditingController();
  String? _selectedGender;
  final TextEditingController _noc=TextEditingController();
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
  List<String> myServices=[];
  // final TextEditingController _namec=TextEditingController();
  
  File? _profileImage;
  final ImagePicker _picker = ImagePicker(); 

  String msg='';
  String name='';
  String bio='';
  String? dpBase64;
  Future<void> _pickImage(ImageSource source) async {
  
    final pickedFile = await _picker.pickImage(source: source);

    if (pickedFile != null) {
    setState(() {
      _profileImage = File(pickedFile.path);
    });
  }
}
void loadContent()async{
  final prefs=await SharedPreferences.getInstance();
  final email=await prefs.getString('email');
  final res= await http.post(Uri.parse("http://10.0.2.2:8000/profile/loadprofile"),
  headers:{'Content-Type':'application/json'},
  body:jsonEncode({'email':email})
  );
  final data=jsonDecode( res.body);
  setState(() {
    // name=data['name'];
    _namec.text=data['name'];
    _selectedGender=data['gender'];
    _bioc.text= data['bio'];
    _noc.text=data['no'];
    dpBase64=data['dp'];
    // myServices=data['myServices'];
    if(data['myServices'].contains('Tutoring'))
    {
      myServices.add('Tutoring');
      setState(() {
        is11=true;
      });
    }
    if(data['myServices'].contains('Career Guidance'))
    {
      myServices.add('Career Guidance');
      setState(() {
        is12=true;
      });
    }
    if(data['myServices'].contains('Teaching Digital Literacy'))
    {
      myServices.add('Teaching Digital Literacy');
      setState(() {
        is13=true;
      });
    }
    if(data['myServices'].contains('Homework Help'))
    {
      myServices.add('Tutoring');
      setState(() {
        is14=true;
      });
    }
    //for secnd service
    if(data['myServices'].contains('Mental Health Support'))
    {
      myServices.add('Tutoring');
      setState(() {
        is21=true;
      });
    }
    if(data['myServices'].contains('Yoga or Fitness'))
    {
      myServices.add('Tutoring');
      setState(() {
        is22=true;
      });
    }
    if(data['myServices'].contains('Nutrition Guidance'))
    {
      myServices.add('Tutoring');
      setState(() {
        is23=true;
      });
    }

    if(data['myServices'].contains('Basic First Aid Knowledge'))
    {
      myServices.add('Tutoring');
      setState(() {
        is24=true;
      });
    }

    //for third service
    if(data['myServices'].contains('App/Website Development'))
    {
      myServices.add('Tutoring');
      setState(() {
        is31=true;
      });
    }
    if(data['myServices'].contains('Career Guidance'))
    {
      myServices.add('Tutoring');
      setState(() {
        is32=true;
      });
    }
    if(data['myServices'].contains('Setting Up Devices For Elders'))
    {
      myServices.add('Tutoring');
      setState(() {
        is33=true;
      });
    }
    if(data['myServices'].contains('Graphic Design/ UI Help'))
    {
      myServices.add('Tutoring');
      setState(() {
        is34=true;
      });
    }

    //forth service
    if(data['myServices'].contains('Reading To Elderly'))
    {
      myServices.add('Tutoring');
      setState(() {
        is41=true;
      });
    }
    if(data['myServices'].contains('Grocery Ordering Help'))
    {
      myServices.add('Tutoring');
      setState(() {
        is42=true;
      });
    }
    if(data['myServices'].contains('Making Calls/Check-Ins'))
    {
      myServices.add('Tutoring');
      setState(() {
        is43=true;
      });
    }
    if(data['myServices'].contains('Teaching Phone Apps'))
    {
      myServices.add('Tutoring');
      setState(() {
        is44=true;
      });
    }

    //fifth service
    if(data['myServices'].contains('Translation'))
    {
      myServices.add('Tutoring');
      setState(() {
        is51=true;
      });
    }
    if(data['myServices'].contains('Resume Writing/SOP Help'))
    {
      myServices.add('Tutoring');
      setState(() {
        is52=true;
      });
    }
    if(data['myServices'].contains('Public Speaking Practice'))
    {
      myServices.add('Tutoring');
      setState(() {
        is53=true;
      });
    }
    if(data['myServices'].contains('Language Conversation Partner'))
    {
      myServices.add('Tutoring');
      setState(() {
        is54=true;
      });
    }

    //sixth service
    if(data['myServices'].contains('Art and Craft Sessions'))
    {
      myServices.add('Art and Craft Sessions');
      setState(() {
        is61=true;
      });
    }
    if(data['myServices'].contains('Photography'))
    {
      myServices.add('Photography');
      setState(() {
        is62=true;
      });
    }
    if(data['myServices'].contains('Music'))
    {
      myServices.add('Music');
      setState(() {
        is63=true;
      });
    }
    if(data['myServices'].contains('Knitting'))
    {
      myServices.add('Knitting');
      setState(() {
        is64=true;
      });
    }

    //seventh service
    if(data['myServices'].contains('Event Organising'))
    {
      myServices.add('Event Organising');
      setState(() {
        is71 =true;
      });
    }
    if(data['myServices'].contains('Crowd Management Volunteering'))
    {
      myServices.add('Crowd Management Volunteering');
      setState(() {
        is72=true;
      });
    }
    if(data['myServices'].contains('Waste Segregation Training'))
    {
      myServices.add('Waste Segregation Traning');
      setState(() {
        is73=true;
      });
    }
    if(data['myServices'].contains('Awareness Campaign'))
    {
      myServices.add('Awareness Campaign');
      setState(() {
        is74=true;
      });
    }


    
  });
 
}
  void setProfile(BuildContext context)async{
   
    final prefs=await SharedPreferences.getInstance();
    final email=await prefs.getString('email');
   
    String name=_namec.text;
    String bio=_bioc.text;
    String no=_noc.text;
    if(name=='' || bio=='' || no=='' || _selectedGender=='' || myServices.isEmpty)
    {
      print('somthng is empty');
      setState(() {
        msg='fill the entries properly';
      });
      return;
    }
    else{
    var uri= Uri.parse('http://10.0.2.2:8000/profile/set-profile');
    var req=http.MultipartRequest('POST',uri);
    req.fields['email']=email !;
   
    req.fields['name'] =name;
    req.fields['no'] =no;
    req.fields['_selectedGender']= _selectedGender !;
    req.fields['bio'] =bio;
    
    req.fields['myServices'] =jsonEncode(myServices);
    if(_profileImage !=null)
    {
      var stream= http.ByteStream(_profileImage! .openRead());
      var length=await _profileImage! .length();
      var multiPartFile=http.MultipartFile('dp', stream, length, filename: basename(_profileImage! .path));

      req.files.add(multiPartFile);

    }
    var res=await req.send();
    if(res.statusCode!=500)
    {
      ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text('Profile set successfully!'),
      backgroundColor: Colors.green,
    ),
    
  );
      Navigator.push(context, MaterialPageRoute(builder: (context)=> home()));
      
    }
    else
    {
      setState(() {
        msg='server error';
      });
    }
  }
  }
  @override
  void initState(){
    super.initState();
      print('yes coming inside init');
      loadContent();
    }
  @override
  Widget build(BuildContext context)
  {
    
    final screenHeight=MediaQuery.of(context).size.height ;
    final screenWidth=MediaQuery.of(context).size.width ;
    return Scaffold(
      resizeToAvoidBottomInset: true,
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
                    Image.asset('assets/images/logo.png',fit: BoxFit.contain, ),
                    Padding(padding: EdgeInsets.fromLTRB(20, 0, 0, 0),child: Text("SamaySetu",style: TextStyle(fontFamily: 'title',fontSize:42, color: Color.fromARGB(255, 255, 255, 255)),))
                  ],
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(20),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(25),
                  color: Color.fromARGB(255, 15, 111, 196),
                  boxShadow:[ BoxShadow(
                    color: Colors.black.withAlpha(100), 
                    spreadRadius: 4,
                    blurRadius: 10,
                    offset: Offset(0, 4)
                  )]
                ),
                // width: screenWidth * 0.8,
                height: screenHeight * 0.25,
                child: Padding(
                  padding: EdgeInsets.all(20),
                  child: Column(
                    children: [
                      Padding(padding: EdgeInsets.fromLTRB(0, 20, 0, 20),child: Text(' Time . Trust . Together ',style: TextStyle(fontFamily: 'title',fontSize: 35,fontWeight: FontWeight.bold),)),
                      Text('Your time and skills matter.To make the most of what SamaySetu has to offer, take a moment to complete your profile.',
                      style: TextStyle(fontFamily: 'basic',fontSize: 20)
                    )],
                  ),
                ),
              ),
            ),
            Expanded(
              
              child: SingleChildScrollView(
                padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom + 20, 
          ),
                child: Column(
                  children: [
                    GestureDetector(
  onTap: () {
    showModalBottomSheet(
      context: context,
      builder: (ctx) => _bottomSheet(ctx),
    );
  },
  child: CircleAvatar(
  radius: 60,
  backgroundImage: _profileImage != null
      ? FileImage(_profileImage!)
      : (dpBase64 != null
          ? MemoryImage(base64Decode(dpBase64!.split(',').last)) // Base64 decode
          : const AssetImage('assets/images/logo.png') as ImageProvider),
  child: (_profileImage == null && dpBase64 == null)
      ? const Icon(Icons.camera_alt, size: 30, color: Colors.white)
      : null,
),
                    ),


                    Padding(
                    padding: EdgeInsets.all(20),
                    child: SizedBox(
                      height: screenHeight * 0.08,
                      child: TextField(
                        controller: _namec,
                        // decoration:BoxDecoration(),
                        decoration: InputDecoration(
                          hintText: 'Your good name?*',
                          hintStyle: TextStyle(fontFamily: 'basic',fontSize: 20,color: Color.fromARGB(100, 0, 0, 0)),
                          border: OutlineInputBorder(),
                          ),
                        )
                    ),
                  ),
                    ListTile(
                      title: Text('Male',style: TextStyle(fontFamily: 'basic',fontSize: 20,color: Color.fromARGB(150, 0, 0, 0)),),
                      leading: Radio<String>(
                        value:"Male",
                        activeColor: Color.fromARGB(255, 15, 111, 196),
                        groupValue: _selectedGender,
                        onChanged: (value){
                          setState((){
                            _selectedGender=value;
                          });
                        },
                      ),
                    ),
                    ListTile(
                      title: Text('Female',style: TextStyle(fontFamily: 'basic',fontSize: 20,color: Color.fromARGB(150, 0, 0, 0)),),
                      leading: Radio<String>(
                        value:"Female",
                        activeColor: Color.fromARGB(255, 15, 111, 196),
                        groupValue: _selectedGender,
                        onChanged: (value){
                          setState((){
                            _selectedGender=value;
                          });
                        },
                      ),
                    ),
                    ListTile(
                      title: Text('Other',style: TextStyle(fontFamily: 'basic',fontSize: 20, color: Color.fromARGB(150, 0, 0, 0)),),
                      leading: Radio<String>(
                        value:"Other",
                        activeColor: Color.fromARGB(255, 15, 111, 196),
                        
                        groupValue: _selectedGender,
                        onChanged: (value){
                          setState((){
                            _selectedGender=value;
                          });
                        },
                      ),
                    ),
                    Padding(
                    padding: EdgeInsets.all(20),
                    child: SizedBox(
                      height: screenHeight * 0.08,
                      child: TextField(
                        controller: _bioc,
                        // decoration:BoxDecoration(),
                        decoration: InputDecoration(
                          hintText: 'Bio - One line about yourself',
                          hintStyle: TextStyle(fontFamily: 'basic',fontSize: 20,color: Color.fromARGB(100, 0, 0, 0)),
                          border: OutlineInputBorder(),
                          ),
                        )
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(20),
                    child: SizedBox(
                      height: screenHeight * 0.08,
                      child: TextField(
                        controller: _noc,
                        // decoration:BoxDecoration(),
                        decoration: InputDecoration(
                          hintText: '10 digits to reach you?*',
                          hintStyle: TextStyle(fontFamily: 'basic',fontSize: 20,color: Color.fromARGB(100, 0, 0, 0)),
                          border: OutlineInputBorder(),
                          ),
                        )
                    ),
                  ),

//education and learning
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
                                        is11=!is11;
                                        if(is11)
                                        {
                                          myServices.add('Tutoring');
                                        }
                                        if(!is11 && myServices.contains('Tutoring'))
                                        {
                                          myServices.remove('Tutoring');
                                        }
                                      });
                                    },
                               
                                child: Padding(
                                  padding: EdgeInsets.all(10),
                                  child: Container(
                                    alignment: Alignment.center,
                                decoration:  BoxDecoration(color: is11? Color.fromARGB(255, 1, 54, 98) : Color.fromARGB(255, 67, 153, 227) ,borderRadius: BorderRadius.circular(20)),
                                height: screenHeight * 0.07,
                                width: screenWidth * 0.7,
                                    child: Text('Tutoring' ,style: TextStyle(
                                      fontFamily: 'basic',
                                      fontSize: 20,
                                      
                                      color: is11? Color.fromARGB(255, 15, 111, 196) :Color.fromARGB(255, 0, 0, 0)
                                    ),)
                                  )
                                ),
                              ),
                          
                    
                          //service no 2
                          if(is1)
                          GestureDetector(
                                onTap: (){
                                      setState(() {
                                        is12=!is12;
                                        if(is12)
                                        {
                                          myServices.add('Career Guidance');
                                        }
                                        if(!is12 && myServices.contains('Career Guidance'))
                                        {
                                          myServices.remove('Career Guidance');
                                        }
                                      });
                                    },
                               
                                child: Padding(
                                  padding: EdgeInsets.all(10),
                                  child: Container(
                                    alignment: Alignment.center,
                                decoration:  BoxDecoration(color: is12? Color.fromARGB(255, 1, 54, 98) : Color.fromARGB(255, 67, 153, 227) ,borderRadius: BorderRadius.circular(20)),
                                height: screenHeight * 0.07,
                                width: screenWidth * 0.7,
                                    child: Text('Career Guidance' ,style: TextStyle(
                                      fontFamily: 'basic',
                                      fontSize: 20,
                                      
                                      color: is12? Color.fromARGB(255, 15, 111, 196) :Color.fromARGB(255, 0, 0, 0)
                                    ),)
                                  )
                                ),
                              ),
                    
                          //service no 3
                          if(is1)
                          GestureDetector(
                                onTap: (){
                                      setState(() {
                                        is13=!is13;
                                        if(is13)
                                        {
                                          myServices.add('Teaching Digital Literacy');
                                        }
                                        if(!is13 && myServices.contains('Teaching Digital Literacy'))
                                        {
                                          myServices.remove('Teaching Digital Literacy');
                                        }
                                      });
                                    },
                               
                                child: Padding(
                                  padding: EdgeInsets.all(10),
                                  child: Container(
                                    alignment: Alignment.center,
                                decoration:  BoxDecoration(color: is13? Color.fromARGB(255, 1, 54, 98) : Color.fromARGB(255, 67, 153, 227) ,borderRadius: BorderRadius.circular(20)),
                                height: screenHeight * 0.07,
                                width: screenWidth * 0.7,
                                    child: Text('Teaching Digital Literacy' ,style: TextStyle(
                                      fontFamily: 'basic',
                                      fontSize: 20,
                                      
                                      color: is13? Color.fromARGB(255, 15, 111, 196) :Color.fromARGB(255, 0, 0, 0)
                                    ),)
                                  )
                                ),
                              ),
                    
                              //service 4
                          if(is1)
                          GestureDetector(
                                onTap: (){
                                      setState(() {
                                        is14=!is14;
                                        if(is14)
                                        {
                                          myServices.add('Homework Help');
                                        }
                                        if(!is14 && myServices.contains('Homework Help'))
                                        {
                                          myServices.remove('Homework Help');
                                        }
                                      });
                                    },
                               
                                child: Padding(
                                  padding: EdgeInsets.all(10),
                                  child: Container(
                                    alignment: Alignment.center,
                                decoration:  BoxDecoration(color: is14? Color.fromARGB(255, 1, 54, 98) : Color.fromARGB(255, 67, 153, 227) ,borderRadius: BorderRadius.circular(20)),
                                height: screenHeight * 0.07,
                                width: screenWidth * 0.7,
                                    child: Text('Homework Help' ,style: TextStyle(
                                      fontFamily: 'basic',
                                      fontSize: 20,
                                      
                                      color: is14? Color.fromARGB(255, 15, 111, 196) :Color.fromARGB(255, 0, 0, 0)
                                    ),)
                                  )
                                ),
                              ),
                        ],)
                      ),
                    ),
                  ),

//health and wellness
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
                                        is21=!is21;
                                        if(is21)
                                        {
                                          myServices.add('Mental Health Support');
                                        }
                                        if(!is21 && myServices.contains('Mental Health Support'))
                                        {
                                          myServices.remove('Mental Health Support');
                                        }
                                      });
                                    },
                               
                                child: Padding(
                                  padding: EdgeInsets.all(10),
                                  child: Container(
                                    alignment: Alignment.center,
                                decoration:  BoxDecoration(color: is21? Color.fromARGB(255, 1, 54, 98) : Color.fromARGB(255, 67, 153, 227) ,borderRadius: BorderRadius.circular(20)),
                                height: screenHeight * 0.07,
                                width: screenWidth * 0.7,
                                    child: Text('Mental Health Support' ,style: TextStyle(
                                      fontFamily: 'basic',
                                      fontSize: 20,
                                      
                                      color: is21? Color.fromARGB(255, 15, 111, 196) :Color.fromARGB(255, 0, 0, 0)
                                    ),)
                                  )
                                ),
                              ),
                          
                    
                          //service no 2
                          if(is2)
                          GestureDetector(
                                onTap: (){
                                      setState(() {
                                        is22=!is22;
                                        if(is22)
                                        {
                                          myServices.add('Yoga or Fitness');
                                        }
                                        if(!is22 && myServices.contains('Yoga or Fitness'))
                                        {
                                          myServices.remove('Yoga or Fitness');
                                        }
                                      });
                                    },
                               
                                child: Padding(
                                  padding: EdgeInsets.all(10),
                                  child: Container(
                                    alignment: Alignment.center,
                                decoration:  BoxDecoration(color: is22? Color.fromARGB(255, 1, 54, 98) : Color.fromARGB(255, 67, 153, 227) ,borderRadius: BorderRadius.circular(20)),
                                height: screenHeight * 0.07,
                                width: screenWidth * 0.7,
                                    child: Text('Yoga or Fitness' ,style: TextStyle(
                                      fontFamily: 'basic',
                                      fontSize: 20,
                                      
                                      color: is22? Color.fromARGB(255, 15, 111, 196) :Color.fromARGB(255, 0, 0, 0)
                                    ),)
                                  )
                                ),
                              ),
                    
                          //service no 3
                          if(is2)
                          GestureDetector(
                                onTap: (){
                                      setState(() {
                                        is23=!is23;
                                        if(is23)
                                        {
                                          myServices.add('Nutrition Guidance');
                                        }
                                        if(!is23 && myServices.contains('Nutrition Guidance'))
                                        {
                                          myServices.remove('Nutrition Guidance');
                                        }
                                      });
                                    },
                               
                                child: Padding(
                                  padding: EdgeInsets.all(10),
                                  child: Container(
                                    alignment: Alignment.center,
                                decoration:  BoxDecoration(color: is23? Color.fromARGB(255, 1, 54, 98) : Color.fromARGB(255, 67, 153, 227) ,borderRadius: BorderRadius.circular(20)),
                                height: screenHeight * 0.07,
                                width: screenWidth * 0.7,
                                    child: Text('Nutrition Guidance' ,style: TextStyle(
                                      fontFamily: 'basic',
                                      fontSize: 20,
                                      
                                      color: is23? Color.fromARGB(255, 15, 111, 196) :Color.fromARGB(255, 0, 0, 0)
                                    ),)
                                  )
                                ),
                              ),
                    
                              //service 4
                          if(is2)
                          GestureDetector(
                                onTap: (){
                                      setState(() {
                                        is24=!is24;
                                        if(is24)
                                        {
                                          myServices.add('Basic First Aid Knowledge');
                                        }
                                        if(!is24 && myServices.contains('Basic First Aid Knowledge'))
                                        {
                                          myServices.remove('Basic First Aid Knowledge');
                                        }
                                      });
                                    },
                               
                                child: Padding(
                                  padding: EdgeInsets.all(10),
                                  child: Container(
                                    alignment: Alignment.center,
                                decoration:  BoxDecoration(color: is24? Color.fromARGB(255, 1, 54, 98) : Color.fromARGB(255, 67, 153, 227) ,borderRadius: BorderRadius.circular(20)),
                                height: screenHeight * 0.07,
                                width: screenWidth * 0.7,
                                    child: Text('Basic First Aid Knowledge' ,style: TextStyle(
                                      fontFamily: 'basic',
                                      fontSize: 20,
                                      
                                      color: is24? Color.fromARGB(255, 15, 111, 196) :Color.fromARGB(255, 0, 0, 0)
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
                                        is31=!is31;
                                        if(is31)
                                        {
                                          myServices.add('App/Website Development');
                                        }
                                        if(!is31 && myServices.contains('App/Website Development'))
                                        {
                                          myServices.remove('App/Website Development');
                                        }
                                      });
                                    },
                               
                                child: Padding(
                                  padding: EdgeInsets.all(10),
                                  child: Container(
                                    alignment: Alignment.center,
                                decoration:  BoxDecoration(color: is31? Color.fromARGB(255, 1, 54, 98) : Color.fromARGB(255, 67, 153, 227) ,borderRadius: BorderRadius.circular(20)),
                                height: screenHeight * 0.07,
                                width: screenWidth * 0.7,
                                    child: Text('App/Website Development' ,style: TextStyle(
                                      fontFamily: 'basic',
                                      fontSize: 20,
                                      
                                      color: is31? Color.fromARGB(255, 15, 111, 196) :Color.fromARGB(255, 0, 0, 0)
                                    ),)
                                  )
                                ),
                              ),
                          
                    
                          //service no 2
                          if(is3)
                          GestureDetector(
                                onTap: (){
                                      setState(() {
                                        is32=!is32;
                                        if(is32)
                                        {
                                          myServices.add('Mobile Phone/Computer Troubleshooting');
                                        }
                                        if(!is32 && myServices.contains('Mobile Phone/Computer Troubleshooting'))
                                        {
                                          myServices.remove('Mobile Phone/Computer Troubleshooting');
                                        }
                                      });
                                    },
                               
                                child: Padding(
                                  padding: EdgeInsets.all(10),
                                  child: Container(
                                    alignment: Alignment.center,
                                decoration:  BoxDecoration(color: is32? Color.fromARGB(255, 1, 54, 98) : Color.fromARGB(255, 67, 153, 227) ,borderRadius: BorderRadius.circular(20)),
                                height: screenHeight * 0.07,
                                width: screenWidth * 0.7,
                                    child: Text('Career Guidance' ,style: TextStyle(
                                      fontFamily: 'basic',
                                      fontSize: 20,
                                      
                                      color: is32? Color.fromARGB(255, 15, 111, 196) :Color.fromARGB(255, 0, 0, 0)
                                    ),)
                                  )
                                ),
                              ),
                    
                          //service no 3
                          if(is3)
                          GestureDetector(
                                onTap: (){
                                      setState(() {
                                        is33=!is33;
                                        if(is33)
                                        {
                                          myServices.add('Setting Up Devices For Elders');
                                        }
                                        if(!is33 && myServices.contains('Setting Up Devices For Elders'))
                                        {
                                          myServices.remove('Setting Up Devices For Elders');
                                        }
                                      });
                                    },
                               
                                child: Padding(
                                  padding: EdgeInsets.all(10),
                                  child: Container(
                                    alignment: Alignment.center,
                                decoration:  BoxDecoration(color: is33? Color.fromARGB(255, 1, 54, 98) : Color.fromARGB(255, 67, 153, 227) ,borderRadius: BorderRadius.circular(20)),
                                height: screenHeight * 0.07,
                                width: screenWidth * 0.7,
                                    child: Text('Setting Up Devices For Elders' ,style: TextStyle(
                                      fontFamily: 'basic',
                                      fontSize: 20,
                                      
                                      color: is33? Color.fromARGB(255, 15, 111, 196) :Color.fromARGB(255, 0, 0, 0)
                                    ),)
                                  )
                                ),
                              ),
                    
                              //service 4
                          if(is3)
                          GestureDetector(
                                onTap: (){
                                      setState(() {
                                        is34=!is34;
                                        if(is34)
                                        {
                                          myServices.add('Graphic Design/ UI Help');
                                        }
                                        if(!is34 && myServices.contains('Graphic Design/ UI Help'))
                                        {
                                          myServices.remove('Graphic Design/ UI Help');
                                        }
                                      });
                                    },
                               
                                child: Padding(
                                  padding: EdgeInsets.all(10),
                                  child: Container(
                                    alignment: Alignment.center,
                                decoration:  BoxDecoration(color: is34? Color.fromARGB(255, 1, 54, 98) : Color.fromARGB(255, 67, 153, 227) ,borderRadius: BorderRadius.circular(20)),
                                height: screenHeight * 0.07,
                                width: screenWidth * 0.7,
                                    child: Text('Graphic Design/ UI Help' ,style: TextStyle(
                                      fontFamily: 'basic',
                                      fontSize: 20,
                                      
                                      color: is34? Color.fromARGB(255, 15, 111, 196) :Color.fromARGB(255, 0, 0, 0)
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
                                        is41=!is41;
                                        if(is41)
                                        {
                                          myServices.add('Reading To Elderly');
                                        }
                                        if(!is41 && myServices.contains('Reading To Elderly'))
                                        {
                                          myServices.remove('Reading To Elderly');
                                        }
                                      });
                                    },
                               
                                child: Padding(
                                  padding: EdgeInsets.all(10),
                                  child: Container(
                                    alignment: Alignment.center,
                                decoration:  BoxDecoration(color: is41? Color.fromARGB(255, 1, 54, 98) : Color.fromARGB(255, 67, 153, 227) ,borderRadius: BorderRadius.circular(20)),
                                height: screenHeight * 0.07,
                                width: screenWidth * 0.7,
                                    child: Text('Reading To Elderly' ,style: TextStyle(
                                      fontFamily: 'basic',
                                      fontSize: 20,
                                      
                                      color: is41? Color.fromARGB(255, 15, 111, 196) :Color.fromARGB(255, 0, 0, 0)
                                    ),)
                                  )
                                ),
                              ),
                          
                    
                          //service no 2
                          if(is4)
                          GestureDetector(
                                onTap: (){
                                      setState(() {
                                        is42=!is42;
                                        if(is42)
                                        {
                                          myServices.add('Grocery Ordering Help');
                                        }
                                        if(!is42 && myServices.contains('Grocery Ordering Help'))
                                        {
                                          myServices.remove('Grocery Ordering Help');
                                        }
                                      });
                                    },
                               
                                child: Padding(
                                  padding: EdgeInsets.all(10),
                                  child: Container(
                                    alignment: Alignment.center,
                                decoration:  BoxDecoration(color: is42? Color.fromARGB(255, 1, 54, 98) : Color.fromARGB(255, 67, 153, 227) ,borderRadius: BorderRadius.circular(20)),
                                height: screenHeight * 0.07,
                                width: screenWidth * 0.7,
                                    child: Text('Grocery Ordering Help' ,style: TextStyle(
                                      fontFamily: 'basic',
                                      fontSize: 20,
                                      
                                      color: is42? Color.fromARGB(255, 15, 111, 196) :Color.fromARGB(255, 0, 0, 0)
                                    ),)
                                  )
                                ),
                              ),
                    
                          //service no 3
                          if(is4)
                          GestureDetector(
                                onTap: (){
                                      setState(() {
                                        is43=!is43;
                                        if(is43)
                                        {
                                          myServices.add('Making Calls/Check-Ins');
                                        }
                                        if(!is43 && myServices.contains('Making Calls/Check-Ins'))
                                        {
                                          myServices.remove('Making Calls/Check-Ins');
                                        }
                                      });
                                    },
                               
                                child: Padding(
                                  padding: EdgeInsets.all(10),
                                  child: Container(
                                    alignment: Alignment.center,
                                decoration:  BoxDecoration(color: is43? Color.fromARGB(255, 1, 54, 98) : Color.fromARGB(255, 67, 153, 227) ,borderRadius: BorderRadius.circular(20)),
                                height: screenHeight * 0.07,
                                width: screenWidth * 0.7,
                                    child: Text('Making Calls/Check-Ins' ,style: TextStyle(
                                      fontFamily: 'basic',
                                      fontSize: 20,
                                      
                                      color: is43? Color.fromARGB(255, 15, 111, 196) :Color.fromARGB(255, 0, 0, 0)
                                    ),)
                                  )
                                ),
                              ),
                    
                              //service 4
                          if(is4)
                          GestureDetector(
                                onTap: (){
                                      setState(() {
                                        is44=!is44;
                                        if(is44)
                                        {
                                          myServices.add('Teaching Phone Apps');
                                        }
                                        if(!is44 && myServices.contains('Teaching Phone Apps'))
                                        {
                                          myServices.remove('Teaching Phone Apps');
                                        }
                                      });
                                    },
                               
                                child: Padding(
                                  padding: EdgeInsets.all(10),
                                  child: Container(
                                    alignment: Alignment.center,
                                decoration:  BoxDecoration(color: is44? Color.fromARGB(255, 1, 54, 98) : Color.fromARGB(255, 67, 153, 227) ,borderRadius: BorderRadius.circular(20)),
                                height: screenHeight * 0.07,
                                width: screenWidth * 0.7,
                                    child: Text('Teaching Phone Apps' ,style: TextStyle(
                                      fontFamily: 'basic',
                                      fontSize: 20,
                                      
                                      color: is44? Color.fromARGB(255, 15, 111, 196) :Color.fromARGB(255, 0, 0, 0)
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
                                        is51=!is51;
                                        if(is51)
                                        {
                                          myServices.add('Translation');
                                        }
                                        if(!is51 && myServices.contains('Translation'))
                                        {
                                          myServices.remove('Translation');
                                        }
                                      });
                                    },
                               
                                child: Padding(
                                  padding: EdgeInsets.all(10),
                                  child: Container(
                                    alignment: Alignment.center,
                                decoration:  BoxDecoration(color: is51? Color.fromARGB(255, 1, 54, 98) : Color.fromARGB(255, 67, 153, 227) ,borderRadius: BorderRadius.circular(20)),
                                height: screenHeight * 0.07,
                                width: screenWidth * 0.7,
                                    child: Text('Translation' ,style: TextStyle(
                                      fontFamily: 'basic',
                                      fontSize: 20,
                                      
                                      color: is51? Color.fromARGB(255, 15, 111, 196) :Color.fromARGB(255, 0, 0, 0)
                                    ),)
                                  )
                                ),
                              ),
                          
                    
                          //service no 2
                          if(is5)
                          GestureDetector(
                                onTap: (){
                                      setState(() {
                                        is52=!is52;
                                        if(is52)
                                        {
                                          myServices.add('Resume Writing/SOP Help');
                                        }
                                        if(!is52 && myServices.contains('Resume Writing/SOP Help'))
                                        {
                                          myServices.remove('Resume Writing/SOP Help');
                                        }
                                      });
                                    },
                               
                                child: Padding(
                                  padding: EdgeInsets.all(10),
                                  child: Container(
                                    alignment: Alignment.center,
                                decoration:  BoxDecoration(color: is52? Color.fromARGB(255, 1, 54, 98) : Color.fromARGB(255, 67, 153, 227) ,borderRadius: BorderRadius.circular(20)),
                                height: screenHeight * 0.07,
                                width: screenWidth * 0.7,
                                    child: Text('Resume Writing/SOP Help' ,style: TextStyle(
                                      fontFamily: 'basic',
                                      fontSize: 20,
                                      
                                      color: is52? Color.fromARGB(255, 15, 111, 196) :Color.fromARGB(255, 0, 0, 0)
                                    ),)
                                  )
                                ),
                              ),
                    
                          //service no 3
                          if(is5)
                          GestureDetector(
                                onTap: (){
                                      setState(() {
                                        is53=!is53;
                                        if(is53)
                                        {
                                          myServices.add('Public Speaking Practice');
                                        }
                                        if(!is53 && myServices.contains('Public Speaking Practice'))
                                        {
                                          myServices.remove('Public Speaking Practice');
                                        }
                                      });
                                    },
                               
                                child: Padding(
                                  padding: EdgeInsets.all(10),
                                  child: Container(
                                    alignment: Alignment.center,
                                decoration:  BoxDecoration(color: is53? Color.fromARGB(255, 1, 54, 98) : Color.fromARGB(255, 67, 153, 227) ,borderRadius: BorderRadius.circular(20)),
                                height: screenHeight * 0.07,
                                width: screenWidth * 0.7,
                                    child: Text('Public Speaking Practice' ,style: TextStyle(
                                      fontFamily: 'basic',
                                      fontSize: 20,
                                      
                                      color: is53? Color.fromARGB(255, 15, 111, 196) :Color.fromARGB(255, 0, 0, 0)
                                    ),)
                                  )
                                ),
                              ),
                    
                              //service 4
                          if(is5)
                          GestureDetector(
                                onTap: (){
                                      setState(() {
                                        is54=!is54;
                                        if(is54)
                                        {
                                          myServices.add('Language Conversation Partner');
                                        }
                                        if(!is54 && myServices.contains('Language Conversation Partner'))
                                        {
                                          myServices.remove('Language Conversation Partner');
                                        }
                                      });
                                    },
                               
                                child: Padding(
                                  padding: EdgeInsets.all(10),
                                  child: Container(
                                    alignment: Alignment.center,
                                decoration:  BoxDecoration(color: is54? Color.fromARGB(255, 1, 54, 98) : Color.fromARGB(255, 67, 153, 227) ,borderRadius: BorderRadius.circular(20)),
                                height: screenHeight * 0.07,
                                width: screenWidth * 0.7,
                                    child: Text('Language Conversation Partner' ,style: TextStyle(
                                      fontFamily: 'basic',
                                      fontSize: 20,
                                      
                                      color: is54? Color.fromARGB(255, 15, 111, 196) :Color.fromARGB(255, 0, 0, 0)
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
                                        is61=!is61;
                                        if(is61)
                                        {
                                          myServices.add('Art and Craft Sessions');
                                        }
                                        if(!is61 && myServices.contains('Art and Craft Sessions'))
                                        {
                                          myServices.remove('Art and Craft Sessions');
                                        }
                                      });
                                    },
                               
                                child: Padding(
                                  padding: EdgeInsets.all(10),
                                  child: Container(
                                    alignment: Alignment.center,
                                decoration:  BoxDecoration(color: is61? Color.fromARGB(255, 1, 54, 98) : Color.fromARGB(255, 67, 153, 227) ,borderRadius: BorderRadius.circular(20)),
                                height: screenHeight * 0.07,
                                width: screenWidth * 0.7,
                                    child: Text('Art and Craft Sessions' ,style: TextStyle(
                                      fontFamily: 'basic',
                                      fontSize: 20,
                                      
                                      color: is61? Color.fromARGB(255, 15, 111, 196) :Color.fromARGB(255, 0, 0, 0)
                                    ),)
                                  )
                                ),
                              ),
                          
                    
                          //service no 2
                          if(is6)
                          GestureDetector(
                                onTap: (){
                                      setState(() {
                                        is62=!is62;
                                        if(is62)
                                        {
                                          myServices.add('Photography');
                                        }
                                        if(!is62 && myServices.contains('Photography'))
                                        {
                                          myServices.remove('Photography');
                                        }
                                      });
                                    },
                               
                                child: Padding(
                                  padding: EdgeInsets.all(10),
                                  child: Container(
                                    alignment: Alignment.center,
                                decoration:  BoxDecoration(color: is62? Color.fromARGB(255, 1, 54, 98) : Color.fromARGB(255, 67, 153, 227) ,borderRadius: BorderRadius.circular(20)),
                                height: screenHeight * 0.07,
                                width: screenWidth * 0.7,
                                    child: Text('Photography' ,style: TextStyle(
                                      fontFamily: 'basic',
                                      fontSize: 20,
                                      
                                      color: is62? Color.fromARGB(255, 15, 111, 196) :Color.fromARGB(255, 0, 0, 0)
                                    ),)
                                  )
                                ),
                              ),
                    
                          //service no 3
                          if(is6)
                          GestureDetector(
                                onTap: (){
                                      setState(() {
                                        is63=!is63;
                                        if(is63)
                                        {
                                          myServices.add('Music');
                                        }
                                        if(!is63 && myServices.contains('Music'))
                                        {
                                          myServices.remove('Music');
                                        }
                                      });
                                    },
                               
                                child: Padding(
                                  padding: EdgeInsets.all(10),
                                  child: Container(
                                    alignment: Alignment.center,
                                decoration:  BoxDecoration(color: is63? Color.fromARGB(255, 1, 54, 98) : Color.fromARGB(255, 67, 153, 227) ,borderRadius: BorderRadius.circular(20)),
                                height: screenHeight * 0.07,
                                width: screenWidth * 0.7,
                                    child: Text('Music' ,style: TextStyle(
                                      fontFamily: 'basic',
                                      fontSize: 20,
                                      
                                      color: is63? Color.fromARGB(255, 15, 111, 196) :Color.fromARGB(255, 0, 0, 0)
                                    ),)
                                  )
                                ),
                              ),
                    
                              //service 4
                          if(is6)
                          GestureDetector(
                                onTap: (){
                                      setState(() {
                                        is64=!is64;
                                        if(is64)
                                        {
                                          myServices.add('Knitting');
                                        }
                                        if(!is64 && myServices.contains('Knitting'))
                                        {
                                          myServices.remove('Knitting');
                                        }
                                      });
                                    },
                               
                                child: Padding(
                                  padding: EdgeInsets.all(10),
                                  child: Container(
                                    alignment: Alignment.center,
                                decoration:  BoxDecoration(color: is64? Color.fromARGB(255, 1, 54, 98) : Color.fromARGB(255, 67, 153, 227) ,borderRadius: BorderRadius.circular(20)),
                                height: screenHeight * 0.07,
                                width: screenWidth * 0.7,
                                    child: Text('Knitting' ,style: TextStyle(
                                      fontFamily: 'basic',
                                      fontSize: 20,
                                      
                                      color: is64? Color.fromARGB(255, 15, 111, 196) :Color.fromARGB(255, 0, 0, 0)
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
                                        is71=!is71;
                                        if(is71)
                                        {
                                          myServices.add('Event Organising');
                                        }
                                        if(!is71 && myServices.contains('Event Organising'))
                                        {
                                          myServices.remove('Event Organising');
                                        }
                                      });
                                    },
                               
                                child: Padding(
                                  padding: EdgeInsets.all(10),
                                  child: Container(
                                    alignment: Alignment.center,
                                decoration:  BoxDecoration(color: is71? Color.fromARGB(255, 1, 54, 98) : Color.fromARGB(255, 67, 153, 227) ,borderRadius: BorderRadius.circular(20)),
                                height: screenHeight * 0.07,
                                width: screenWidth * 0.7,
                                    child: Text('Event Organising' ,style: TextStyle(
                                      fontFamily: 'basic',
                                      fontSize: 20,
                                      
                                      color: is71? Color.fromARGB(255, 15, 111, 196) :Color.fromARGB(255, 0, 0, 0)
                                    ),)
                                  )
                                ),
                              ),
                          
                    
                          //service no 2
                          if(is7)
                          GestureDetector(
                                onTap: (){
                                      setState(() {
                                        is72=!is72;
                                        if(is72)
                                        {
                                          myServices.add('Crowd Management Volunteering');
                                        }
                                        if(!is72 && myServices.contains('Crowd Management Volunteering'))
                                        {
                                          myServices.remove('Crowd Management Volunteering');
                                        }
                                      });
                                    },
                               
                                child: Padding(
                                  padding: EdgeInsets.all(10),
                                  child: Container(
                                    alignment: Alignment.center,
                                decoration:  BoxDecoration(color: is72? Color.fromARGB(255, 1, 54, 98) : Color.fromARGB(255, 67, 153, 227) ,borderRadius: BorderRadius.circular(20)),
                                height: screenHeight * 0.07,
                                width: screenWidth * 0.7,
                                    child: Text('Crowd Management Volunteering' ,style: TextStyle(
                                      fontFamily: 'basic',
                                      fontSize: 20,
                                      
                                      color: is72? Color.fromARGB(255, 15, 111, 196) :Color.fromARGB(255, 0, 0, 0)
                                    ),)
                                  )
                                ),
                              ),
                    
                          //service no 3
                          if(is7)
                          GestureDetector(
                                onTap: (){
                                      setState(() {
                                        is73=!is73;
                                        if(is73)
                                        {
                                          myServices.add('Waste Segregation Training');
                                        }
                                        if(!is73 && myServices.contains('Waste Segregation Training'))
                                        {
                                          myServices.remove('Waste Segregation Training');
                                        }
                                      });
                                    },
                               
                                child: Padding(
                                  padding: EdgeInsets.all(10),
                                  child: Container(
                                    alignment: Alignment.center,
                                decoration:  BoxDecoration(color: is73? Color.fromARGB(255, 1, 54, 98) : Color.fromARGB(255, 67, 153, 227) ,borderRadius: BorderRadius.circular(20)),
                                height: screenHeight * 0.07,
                                width: screenWidth * 0.7,
                                    child: Text('Waste Segregation Training' ,style: TextStyle(
                                      fontFamily: 'basic',
                                      fontSize: 20,
                                      
                                      color: is73? Color.fromARGB(255, 15, 111, 196) :Color.fromARGB(255, 0, 0, 0)
                                    ),)
                                  )
                                ),
                              ),
                    
                              //service 4
                          if(is7)
                          GestureDetector(
                                onTap: (){
                                      setState(() {
                                        is74=!is74;
                                        if(is74)
                                        {
                                          myServices.add('Awareness Campaign');
                                        }
                                        if(!is74 && myServices.contains('Awareness Campaign'))
                                        {
                                          myServices.remove('Awareness Campaign');
                                        }
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
                                      
                                      color: is74? Color.fromARGB(255, 15, 111, 196) :Color.fromARGB(255, 0, 0, 0)
                                    ),)
                                  )
                                ),
                              ),
                    
                              
                        ],)
                      ),
                    ),
                  ),

                  ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)
                            ),
                            backgroundColor: Color.fromARGB(255, 15, 111, 196)
                          ),
                          onPressed: ()=> setProfile(context), 
                          child: Text('Done',
                            style: TextStyle(fontSize: 17, color: Color.fromARGB(255, 255, 255, 255)),
                          )
                        ),
                        // if(msg=='success')
                        // ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: content));
                  Padding(padding:EdgeInsets.all(screenHeight * 0.02) ,child: Text(msg, style: TextStyle(fontFamily: 'basic', fontSize: 20 , color: Color.fromARGB(255, 255, 0, 0))))

                ]),
              ),
            )
          ])
        );
        
  
  }
  Widget _bottomSheet(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      height: 150,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text("Choose profile picture", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          const SizedBox(height: 10),
          Row(
            children: [
              TextButton.icon(
                onPressed: () {
                  Navigator.pop(context);
                  _pickImage(ImageSource.camera);
                },
                icon: const Icon(Icons.camera_alt),
                label: const Text("Camera"),
              ),
              const SizedBox(width: 20),
              TextButton.icon(
                onPressed: () {
                  Navigator.pop(context);
                  _pickImage(ImageSource.gallery);
                },
                icon: const Icon(Icons.photo_library),
                label: const Text("Gallery"),
              ),
            ],
          )
        ],
      ),
    );
  }
}
import 'dart:io';
import 'package:permission_handler/permission_handler.dart';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
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
  List<String> myServices=[];
  // final TextEditingController _namec=TextEditingController();
  
  File? _profileImage;
  final ImagePicker _picker = ImagePicker(); 

  Future<void> _pickImage(ImageSource source) async {
  // 🔐 Ask for permission
  // if (source == ImageSource.camera) {
  //   await Permission.camera.request();
  // } else {
  //   await Permission.photos.request(); // or Permission.storage for older versions
  // }

  // 📸 Pick the image
  final pickedFile = await _picker.pickImage(source: source);

  if (pickedFile != null) {
    setState(() {
      _profileImage = File(pickedFile.path);
    });
  }
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
              child: Padding(
                padding: EdgeInsets.fromLTRB(0, 25, 0, 0),
                child: Row(
                  children: [
                    Image.asset("assets/images/logo.png",fit: BoxFit.cover,height: screenHeight * 0.07,),
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
      builder: (_) => _bottomSheet(),
    );
  },
  child: CircleAvatar(
    radius: 60,
    backgroundImage: _profileImage != null
        ? FileImage(_profileImage!)
        : const AssetImage('assets/images/logo.png') as ImageProvider,
    child: _profileImage == null
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
                  GestureDetector(
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

//health and wellness
                  GestureDetector(
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


                  GestureDetector(
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


                  GestureDetector(
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
                  )
                ]),
              ),
            )
          ])
        );
        
  
  }
  Widget _bottomSheet() {
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
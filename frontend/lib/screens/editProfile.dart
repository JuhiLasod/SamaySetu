import 'package:flutter/material.dart';

class editProfile extends StatefulWidget
{
  const editProfile({super.key});
  State<editProfile> createState()=> _editProfileState();
}
class _editProfileState extends State<editProfile>
{
  
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
              padding: EdgeInsets.all(30),
              child: Container(
                // width: screenWidth * 0.8,
                height: screenHeight * 0.5,
                color: Color.fromARGB(255, 15, 0, 0)
              ),
            )
          ],
        ),
        
    );
  }
}
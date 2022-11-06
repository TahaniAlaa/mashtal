import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:plantation/AppColors.dart';
import 'package:plantation/home.dart';
import 'package:plantation/login.dart';

import 'bottom_nav_controller.dart';


class SplashScreen extends StatefulWidget{
  @override
  State<StatefulWidget> createState() =>_splashScreen();
}
class _splashScreen extends State<SplashScreen>{
var islogin;
 @override
  void initState() {
   var use=FirebaseAuth.instance.currentUser;
   if(use == null){
     islogin=false;
   }else{
     islogin=true;
   }
    Timer(Duration(seconds: 2), () => Navigator.push(context, CupertinoDialogRoute(builder: (_)=>islogin?BottomNavController():Login(), context: context)));
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.deep_green,
      body: SafeArea(child:
      Container(
        child: Center(child:
            Column(mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Icon(Icons.eco_rounded,color:Color(-63374080),size:33,),
                    SizedBox(width: 2,),
                    Text("مشتل ارض السواد",
                    style: TextStyle(color: Colors.white,
                        fontWeight: FontWeight.bold,fontSize:33),),

                  ],
                ),
                SizedBox(height: 10,),
                CircularProgressIndicator(color: Colors.white,)
              ],
            )),
      )
   ),

    );
  }

}
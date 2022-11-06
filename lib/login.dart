import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:plantation/AppColors.dart';
import 'package:plantation/signup.dart';

import 'bottom_nav_controller.dart';

class Login extends StatefulWidget{
  @override
  State<StatefulWidget> createState() =>_Login();

}
class _Login extends State<Login>{
  GlobalKey<FormState>statekey=new GlobalKey<FormState>();
  var email,pass;

  Singin()async{
    var formdata=statekey.currentState;
    if(formdata!.validate()){
      formdata.save();
      try{
        showDialog( builder: (context){
          return AlertDialog(title: Text('الرجاء الانتظار',style: TextStyle(color: AppColors.deep_green,fontSize: 25,fontWeight: FontWeight.normal)),
            content: Container(height: 50,child:
            Center(child: CircularProgressIndicator(),),),);
        }, context: context);
        UserCredential user = await FirebaseAuth.instance.
        signInWithEmailAndPassword(email: email, password: pass);
        return user;
      }on FirebaseAuthException catch (e){
        if(e.code =='user-not-found'){
          Navigator.of(context).pop();
          AwesomeDialog(context: context,title:'Erorr',
              body: Text('لا يوجد حساب'),
              dialogBackgroundColor: Colors.white
          )..show();

        }else if(e.code=='wrong-password'){
          Navigator.of(context).pop();
          AwesomeDialog(context: context,title:'Erorr',
              body: Text('كلمت المرور غير صحيحه'),
              dialogBackgroundColor: Colors.white
          )..show();
        }
      }catch(e){
        print(e);
      }

    }else{
      print("N0T Validater");
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(children: [
        SizedBox(
          child: Container(decoration:BoxDecoration(color: AppColors.deep_green,borderRadius:
          BorderRadius.only(bottomRight:Radius.circular(150) )),height:200,),   ),
        ListView(children: [
          Padding(
            padding: const EdgeInsets.only(top: 100,right: 10,left: 10),
            child: Container(
              decoration: BoxDecoration(borderRadius:
              BorderRadius.circular(30),color: Colors.white,),padding: EdgeInsets.all(15),
               child: Form(
                key: statekey,
                child: Column(
                    children: [
                      Container(margin: EdgeInsets.only(left: 200),padding: EdgeInsets.all(10),
                          child: Text("دخول",style: TextStyle(color: AppColors.deep_green,fontSize: 25,fontWeight: FontWeight.w800),)),
                      Padding(
                        padding: const EdgeInsets.all(10),
                        child: TextFormField(
                            validator: (val){
                              if(val!= null){
                              setState(() {
                                email=val;
                              });
                            };},
                            textInputAction: TextInputAction.next,
                            keyboardType: TextInputType.emailAddress,
                            decoration:InputDecoration(

                                hintStyle: TextStyle(color: AppColors.deep_green,fontWeight: FontWeight.bold,fontSize: 20),
                               // icon: Icon(Icons.phone_android,color: AppColors.deep_green,size: 30),
                               prefixIcon: Icon(Icons.email,color: AppColors.deep_green,size: 30) ,
                                hintText: 'الايميل',
                                border:OutlineInputBorder(borderRadius: BorderRadius.circular(20),borderSide: BorderSide(color: AppColors.deep_green,width:2,)))
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10),
                        child: TextFormField(
                            validator:(val){
                            if(val!= null){
                             setState(() {
                             pass=val;
                        });
                        };},
                            textInputAction: TextInputAction.next,
                            obscureText: true,
                            decoration:InputDecoration(
                                hintStyle: TextStyle(color: AppColors.deep_green,fontWeight: FontWeight.bold,fontSize: 20),
                                // icon: Icon(Icons.phone_android,color: AppColors.deep_green,size: 30),
                                prefixIcon: Icon(Icons.lock,color: AppColors.deep_green,size: 30) ,
                                hintText: 'كلمه المرور',
                                border:OutlineInputBorder(borderRadius: BorderRadius.circular(20),borderSide: BorderSide(color: AppColors.deep_green,width: 2)))
                        ),
                      ),
                  InkWell(onTap:()async{
                        UserCredential resp=await Singin();
                        if(resp != null){
                          Navigator.push(context, MaterialPageRoute(builder: (_)=>BottomNavController()));
                        }
                        else
                        {
                          AwesomeDialog(context: context,title:'Erorr',
                              body: Text('لا يوجد حساب'),
                              dialogBackgroundColor: Colors.white
                          )..show();
                        }},

                          child: Container(height: 30,width: double.infinity,
                            decoration: BoxDecoration(color: AppColors.deep_green,borderRadius: BorderRadius.circular(30)),child: Center(child: Text("دخول",style: TextStyle(color:Colors.white,fontSize:20,fontWeight: FontWeight.bold,))),),
                        )
                    ]),
              ),
            ),

          ),
          Row(mainAxisAlignment: MainAxisAlignment.center,
            children: [
              InkWell(child: Text('التسجيل',
                style: TextStyle(color:AppColors.deep_green,fontSize:20,fontWeight: FontWeight.bold),),
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (_)=>SignUp()));
                  }),
            Text('ليس لديك حساب ',style: TextStyle(fontSize:20,fontWeight: FontWeight.bold,),

            )],),

        ]),

        ],),
    );

  }

}
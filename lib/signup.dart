import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:plantation/login.dart';
import 'AppColors.dart';
import 'bottom_nav_controller.dart';

class SignUp extends StatefulWidget{
  @override
  State<StatefulWidget> createState() =>_signup();
}
class _signup extends State<SignUp>{
 GlobalKey<FormState>formstate=new GlobalKey<FormState>();
 var username,password,email,phonenumber;

 SingUp()async{
  var formdata=formstate.currentState;
  if(formdata!.validate()){
   formdata.save();
   try{
    showDialog( builder: (context){
     return AlertDialog(title: Text("الرجاء الانتظار",style: TextStyle(color: AppColors.deep_green,fontSize: 25,fontWeight: FontWeight.normal)),
      content: Container(height: 50,child:
      Center(child: CircularProgressIndicator(),),),);
    }, context: context);
    UserCredential user = await FirebaseAuth.instance.
    createUserWithEmailAndPassword(email: email, password: password);
    return user;
   }on FirebaseAuthException catch (e){
    if(e.code =='weak-password'){
     Navigator.of(context).pop();

     AwesomeDialog(context: context,title:'Erorr',
         body: Text('كلمة المرور ضعيف جدًا'),
         dialogBackgroundColor: Colors.white
     )..show();

    }else if(e.code=='email-already-in-use'){
     Navigator.of(context).pop();
     AwesomeDialog(context: context,title:'Erorr',
         body: Text('الحساب موجود بالفعل لهذا البريد الإلكتروني'),
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
   return Scaffold(body: Stack(children: [
   SizedBox(
     child: Container(decoration:BoxDecoration(color: AppColors.deep_green,borderRadius:
     BorderRadius.only(bottomRight:Radius.circular(150) )),height:200,),  ),

    ListView(
      children: [
       Padding(
        padding: const EdgeInsets.only(top: 100,right: 10,left: 10),
        child: Container(decoration: BoxDecoration(borderRadius: BorderRadius.circular(30),color: Colors.white),padding:EdgeInsets.all(15),
         child: Form(key: formstate,
          child: Column(
              children: [
               Container(margin: EdgeInsets.only(left: 200),padding: EdgeInsets.all(10),
                   child: Text("تسجيل",style: TextStyle(color: AppColors.deep_green,fontSize: 25,fontWeight: FontWeight.w800),)),

               Padding(
                padding: const EdgeInsets.all(10),
                child: TextFormField(
                    textInputAction: TextInputAction.next,
                    onSaved: (val){
                     username=val;
                    },
                    validator: (val){
                     if(val!.length>100){
                      return" لا يمكن ان يكون اسم المستخدم اكبر من 100 حرف";
                     }
                     if(val.length<3){
                      return"لا يمكن ان يكون اسم المستخدم اقل من 3 حرف";
                     }return null;
                    },
                    decoration:InputDecoration(
                        hintStyle: TextStyle(color: AppColors.deep_green,fontWeight: FontWeight.bold,fontSize: 20),
                        prefixIcon: Icon(Icons.person,color: AppColors.deep_green,size: 25),
                        hintText: 'اسم المستخدم',
                        border:OutlineInputBorder(borderSide: BorderSide(color:AppColors.deep_green,width: 2),borderRadius: BorderRadius.circular(20),))
                ),
               ),
               Padding(
                padding: const EdgeInsets.all(10),
                child: TextFormField(textInputAction: TextInputAction.next,
                    onSaved: (val){
                     email=val;
                    },
                    validator: (val){
                     if(val!.length>100){
                      return"لا يمكن ان يكون الايميل اكبر من 100 حرف";
                     }
                     if(val.length<3){
                      return" لا يمكن ان يكون الايميل اقل من 3 حرف";
                     }return null;
                    },
                    decoration:InputDecoration(
                        hintStyle: TextStyle(color: AppColors.deep_green,fontWeight: FontWeight.bold,fontSize: 20),
                        prefixIcon: Icon(Icons.email,color: AppColors.deep_green,size: 25),
                        hintText:"الايميل",
                        border:OutlineInputBorder(borderSide: BorderSide(color:AppColors.deep_green,width: 2),borderRadius: BorderRadius.circular(20),))
                ),
               ),
               Padding(
                padding: const EdgeInsets.all(10),
                child: TextFormField(textInputAction: TextInputAction.next,
                    onSaved: (val){
                     phonenumber=val;
                    },
                    validator: (val){
                     if(val!.length>11){
                      return"لا يمكن ان يكون رقم الهاتف اكبر من 11 حرف";
                     }
                     if(val.length<11){
                      return" لا يمكن ان يكون رقم الهاتف اقل من 11 حرف";
                     }return null;
                    },
                    decoration:InputDecoration(
                        hintStyle: TextStyle(color: AppColors.deep_green,fontWeight: FontWeight.bold,fontSize: 20),
                        prefixIcon: Icon(Icons.phone,color: AppColors.deep_green,size: 25),
                        hintText: 'رقم الهاتف ',
                        border:OutlineInputBorder(borderSide: BorderSide(color:AppColors.deep_green,width: 2),borderRadius: BorderRadius.circular(20),))
                ),
               ),
               Padding(
                padding: const EdgeInsets.all(10),
                child: TextFormField(
                    textInputAction: TextInputAction.next,
                    onSaved: (val){
                     password=val;
                    },
                    validator: (val){
                     if(val!.length>100){
                      return" لا يمكن ان يكون الياسورد اكبر من 100 حرف";
                     }
                     if(val.length<4){
                      return" لا يمكن ان يكون االباسورد اقل من 4 حرف";
                     }return null;
                    },
                    obscureText: true,
                    decoration:InputDecoration(
                     hintStyle: TextStyle(color: AppColors.deep_green,fontWeight: FontWeight.bold,fontSize: 20),
                     prefixIcon: Icon(Icons.lock,color: AppColors.deep_green,size: 25),
                     hintText: 'كلمه المرور',
                     border:OutlineInputBorder(borderRadius: BorderRadius.circular(20),),)
                ),
               ),
              InkWell(onTap:()async{
                UserCredential response=await SingUp();
                if(response != null){
                await FirebaseFirestore.instance.collection('users').add({
                 "username":username,
                  "email":email,
                  "phone":phonenumber,
                  "pasword":password
               });
                Navigator.push(context, MaterialPageRoute(builder: (_)=>BottomNavController()));
               }else{
               AwesomeDialog(context: context,title:'Erorr',
                body: Text('can not access account '),
                dialogBackgroundColor: Colors.black26
               )..show();
    }
    },
                child: Container(height: 30,width: double.infinity,
                  decoration: BoxDecoration(color: AppColors.deep_green,borderRadius: BorderRadius.circular(30)),child: Center(child: Text("تسجيل",style: TextStyle(color:Colors.white,fontSize:20,fontWeight: FontWeight.bold,))),),
              )
              ]),
         ),
        ),),
       Row(mainAxisAlignment: MainAxisAlignment.center,children: [
        InkWell(child: Text('دخول',
         style: TextStyle(color:AppColors.deep_green,fontSize:20,fontWeight: FontWeight.bold),),onTap: (){
          Navigator.push(context, MaterialPageRoute(builder: (_)=>Login()));
        }),
        Text(' لديك حساب بالفعل',style: TextStyle(fontSize:20,fontWeight: FontWeight.bold),)
       ],),

      ],
    ),
   ]) );
  }

}

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'AppColors.dart';


class Profile extends StatefulWidget {

  @override
  State<StatefulWidget> createState() => _Profile();
}

class _Profile extends State<Profile>{
 String? _nameController ;
String?  _phoneController;
String? _emailController;
String? _paswordController;

Future<void>  _info()async{
 await FirebaseFirestore.instance.collection('users').where("email",isEqualTo: FirebaseAuth.instance.currentUser!.email).get()
      .then((QuerySnapshot querySnapshot) {
    querySnapshot.docs.forEach((doc) {
      setState(() {
        _nameController=doc["username"];
      _paswordController=doc["pasword"];
        _phoneController=doc["phone"];
      _emailController=(doc["email"]);
      });

    });
  }).then((value) => print("get data"))
      .catchError((error) => print("Failed to data user: $error"));
}




 Future resetEmail() async {
   var message;
   var firebaseUser = await FirebaseAuth.instance.currentUser;
   firebaseUser!
       .updateEmail(_emailController.toString());
   firebaseUser.updatePassword(_paswordController.toString())
       .then(
         (value) => message = 'Success',
   )
       .catchError((onError) => message = 'error');
   return message;
 }
 // CollectionReference users = FirebaseFirestore.instance.collection('users');
 // var _uther=FirebaseAuth.instance.currentUser;
 //  Future<void> updateUser() {
 //    return users.doc("hvTvmhC8KWQkIqvp3YbW").update({
 //      "username":_nameController,
 //        "email":_emailController,
 //        "phone":_phoneController,
 //        "pasword":_paswordController
 //
 //    })
 //        .then((value) => print("${users.doc(_uther!.email)}"),
 //
 //    )
 //        .catchError((error) => print("Failed to update user: $error"));
 //
 //  }

  up()async{
    var user=FirebaseAuth.instance.currentUser;
    QuerySnapshot querySnap = await FirebaseFirestore.instance.collection('users').where('email', isEqualTo: user!.email).get();
    QueryDocumentSnapshot doc = querySnap.docs[0];  // Assumption: the query returns only one document, THE doc you are looking for.
    DocumentReference docRef = doc.reference;
    await docRef.update({
      "username":_nameController,
      "email":_emailController,
      "phone":_phoneController,
      "pasword":_paswordController

    })  .then((value) => print("update"),

    )
        .catchError((error) => print("Failed to update user: $error"));
  }





@override
  void initState() {
   _info();
    super.initState();
  }


    @override
  Widget build(BuildContext context) {


    return Scaffold(
      body: Stack(children: [
      SizedBox(
      child: Container(decoration:BoxDecoration(color: AppColors.deep_green,borderRadius:
      BorderRadius.only(bottomRight:Radius.circular(150) )),height:100,),   ),SafeArea(child: Padding(
        padding: const EdgeInsets.only(top: 105,left: 20,right: 20),
       child:Container(decoration: BoxDecoration(color: Colors.transparent,borderRadius: BorderRadius.circular(50)),
       child: Padding(padding: EdgeInsets.all(20),child:
       Form(child: ListView(scrollDirection: Axis.vertical,children: [

         TextFormField(
           decoration: InputDecoration(prefixText: "الاسم ",border: OutlineInputBorder(borderRadius: BorderRadius.circular(20),borderSide: BorderSide(color: AppColors.deep_green,width:2,),)),
           textInputAction: TextInputAction.next,
           keyboardType: TextInputType.text,
           onChanged: (value) => setState(() {
             _nameController=value;
           }),textDirection: TextDirection.rtl,

           controller:TextEditingController(text:  _nameController,),
           style: TextStyle(fontWeight: FontWeight.normal,fontSize: 20,),

         ),
         SizedBox(height: 10,),
         TextFormField(
           decoration: InputDecoration(prefixText: "رقم الهاتف ",border: OutlineInputBorder(borderRadius: BorderRadius.circular(20),borderSide: BorderSide(color: AppColors.deep_green,width:2,),)),

           textInputAction: TextInputAction.next,
           onChanged: (value) => setState(() {
             _phoneController=value;
           }),textDirection: TextDirection.rtl,
           controller:TextEditingController(text:_phoneController),
           style: TextStyle(fontWeight: FontWeight.normal,fontSize: 20,),

         ),
         SizedBox(height: 10,),
         TextFormField(
           decoration: InputDecoration(prefixText: "الايميل ",border: OutlineInputBorder(borderRadius: BorderRadius.circular(20),borderSide: BorderSide(color: AppColors.deep_green,width:2,),)),

           textInputAction: TextInputAction.next,
          onChanged: (value) => setState(() {
             _emailController=value;
           }),textDirection: TextDirection.rtl,
           controller:TextEditingController(text: _emailController),
           style: TextStyle(fontWeight: FontWeight.normal,fontSize: 20,),

         ),
         SizedBox(height: 10,),
         TextFormField(
           decoration: InputDecoration(prefixText: "الباسورد ",border: OutlineInputBorder(borderRadius: BorderRadius.circular(20),borderSide: BorderSide(color: AppColors.deep_green,width:2,),)),

           textInputAction: TextInputAction.next,
           onChanged: (value) => setState(() {
             _paswordController=value;
           }),textDirection: TextDirection.rtl,
           controller:TextEditingController(text: _paswordController),
           style: TextStyle(fontWeight: FontWeight.normal,fontSize: 20,),

         ),
         SizedBox(height: 20,),
         ElevatedButton(onPressed: ()=> {
           up(),
           resetEmail(),
           print("${FirebaseAuth.instance.currentUser}"),



         },style: ButtonStyle(
           elevation: MaterialStateProperty.all(5),
           backgroundColor: MaterialStatePropertyAll(AppColors.deep_green)
         ),
             child: Row(children: [
               Icon(Icons.edit,color: Colors.white,),
               SizedBox(width: 100,),
               Center(child: Text("تحديث ",style: TextStyle(color: Colors.white,fontSize: 20,fontWeight: FontWeight.bold)),)
             ],))
       ],)),)
       )


      ))
     ]) );
  }
}

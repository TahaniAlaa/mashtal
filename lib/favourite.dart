import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:plantation/viewprodect.dart';

import 'AppColors.dart';

class Favourite extends StatefulWidget {

  @override
  State<StatefulWidget> createState() => _Favourite();
}

class _Favourite extends State<Favourite>{
GlobalKey valukey=new GlobalKey();
  @override
  Widget build(BuildContext context) {

    return Scaffold(
        body:Stack(children: [
          SizedBox(
            child: Container(decoration:BoxDecoration(color: AppColors.deep_green,borderRadius:
            BorderRadius.only(bottomRight:Radius.circular(150) )),height:100,width: double.infinity,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 100,right: 20,left: 20,bottom: 30),
            child: StreamBuilder(stream: FirebaseFirestore.instance.collection("user_favorat_item").doc(FirebaseAuth.instance.currentUser!.email).collection("item").snapshots(),
              builder: (BuildContext contex,AsyncSnapshot<QuerySnapshot>snapshot){
                if(snapshot.connectionState==ConnectionState.waiting){
                  return Center(child: CircularProgressIndicator(),);
                }
                if(snapshot.hasError){
                  return Center(child: Text("Somthing is wrong"),);
                }
                return ListView.builder(itemBuilder: (_,index){

                  DocumentSnapshot  _documentSnapshot=snapshot.data!.docs[index];
                 
                  return InkWell(onTap: () {
                    setState(() {
                      index = index;
                      Navigator.push(context, MaterialPageRoute(
                          builder: (_) => Viewprodect(_documentSnapshot)));
                    },);
                  },
                    child: Container(
                      child:Dismissible(background: Container(color: Colors.red,child: Center(child:
                        Text(" حذف ",style: TextStyle(fontSize: 30,fontWeight: FontWeight.w600)),)), key:Key("$valukey"),
                        onDismissed: (direction) =>
                            FirebaseFirestore.instance.collection("user_favorat_item").doc(FirebaseAuth.instance.currentUser!.email).collection("item").doc(_documentSnapshot.id).delete(),
                      child:  Card(elevation: 3,
                        child: ListTile(trailing : Text("${_documentSnapshot["name"]}",style: TextStyle(fontWeight: FontWeight.bold,color:Colors.black,fontSize: 20)),
                            leading: Text("${_documentSnapshot["price"]}"+"دع ",style: TextStyle(fontWeight: FontWeight.bold,color:AppColors.deep_green,fontSize: 20)),
                            //subtitle  :Text("${_documentSnapshot["dec"]}",style: TextStyle(fontWeight: FontWeight.bold,color:Colors.black,)),
                            title :Container(width:double.infinity,child: Image.network(_documentSnapshot["image"],fit: BoxFit.fitWidth,),)
                        ),
                      ),)
                    ),
                  );
                },itemCount: snapshot.data!.docs.length,);
              },),
          )
        ]) );
  }
}

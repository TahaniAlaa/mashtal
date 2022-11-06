import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'AppColors.dart';

class Cart extends StatefulWidget {

  @override
  State<StatefulWidget> createState() => _cart();
}


class _cart extends State<Cart>{
int pricetotol=0;
int sum=0;
List total=[];

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
           padding: const EdgeInsets.only(top: 100,right: 20,left: 20,bottom: 90),
           child: StreamBuilder(stream: FirebaseFirestore.instance.collection("user_cart_item").doc(FirebaseAuth.instance.currentUser!.email).collection("item").snapshots(),
           builder: (BuildContext contex,AsyncSnapshot<QuerySnapshot>snapshot){
             if(snapshot.connectionState==ConnectionState.waiting){
               return Center(child: CircularProgressIndicator(),);
             }
             if(snapshot.hasError){
               return Center(child: Text("Somthing is wrong"),);
             }
             return ListView.builder(itemBuilder: (_,index){
               DocumentSnapshot  _documentSnapshot=snapshot.data!.docs[index];
               var  price=_documentSnapshot["price"]*_documentSnapshot["number"];

                total.add(price);
                sum+=total[index] as int;


               return   Card(elevation: 3,
                 child: ListTile( title: Text("${_documentSnapshot["name"]}",style: TextStyle(fontWeight: FontWeight.bold,color:Colors.black,fontSize: 20)),
                   leading: Text("${price}"+"دع ",style: TextStyle(fontWeight: FontWeight.bold,color:AppColors.deep_green,fontSize: 20)),
                   trailing:InkWell(child: CircleAvatar(child: Icon(Icons.remove_circle),),
                     onTap: (){

                       FirebaseFirestore.instance.collection("user_cart_item").doc(FirebaseAuth.instance.currentUser!.email).collection("item").doc(_documentSnapshot.id).delete();
                     },),


                 ),
               );


             },itemCount: snapshot.data!.docs.length,);

           },),

         ),
          Padding(padding: EdgeInsets.only(top: 520),
          child: Container(width: double.infinity,height: 200,color: AppColors.deep_green,
          child: Row(mainAxisAlignment: MainAxisAlignment.center,children: [
            Center(child:Text("السعر الكلي "+"$sum",style: TextStyle(fontSize: 30,color: Colors.white),)),
            SizedBox(width: 5,),
            IconButton(onPressed: (){

            }, icon:Icon( Icons.shopping_bag,color: Colors.white,size: 30,shadows: [Shadow(color: Colors.black,blurRadius: 5)],))
          ],),
          ),
    ),




        ]),

    );
  }
}

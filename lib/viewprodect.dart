import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:plantation/AppColors.dart';

import 'package:provider/provider.dart';

import 'badge.dart';

class Viewprodect extends StatefulWidget{
var _prodect;
Viewprodect(this._prodect);

  @override
  State<StatefulWidget> createState() =>_viewpreodect();


}
class _viewpreodect extends State<Viewprodect>{
List _fav=[];


  Future addTofavorat()async {

    final FirebaseAuth _auther = FirebaseAuth.instance;
    var currentUser = _auther.currentUser;
    CollectionReference _collectionRef = FirebaseFirestore.instance.collection(
        "user_favorat_item");

       return _collectionRef.doc(currentUser!.email).collection("item").doc().set(
         {

           "name": widget._prodect["name"],
           "price": widget._prodect["price"],
           "image": widget._prodect["image"],
           "dec": widget._prodect["dec"],

         }).then((value) => print("added favorate "),
     );


  }

Future addToCart()async {

    final FirebaseAuth _auther = FirebaseAuth.instance;
    var currentUser = _auther.currentUser;
    CollectionReference _collectionRef = FirebaseFirestore.instance.collection(
        "user_cart_item");
    return _collectionRef.doc(currentUser!.email).collection("item").doc().set({
      "name": widget._prodect["name"],
      "price": widget._prodect["price"]*num,
      "image": widget._prodect["image"],
      "number":num,
    }).then((value) => print("added prodect to cart"),);

  }

var num=1;
var itemcount;

val()async{
 var number=await FirebaseFirestore.instance.collection("user_cart_item").doc(FirebaseAuth.instance.currentUser!.email).collection("item").get();
     setState(() {
       itemcount=number.docs.length;

     });
}
validet()async{
  var count=0;
  var name=await FirebaseFirestore.instance.collection("user_favorat_item").doc(FirebaseAuth.instance.currentUser!.email).collection("item").get();
  setState(() {
    for(int i=0;i<name.docs.length;i++){
      _fav.add({
       "name": name.docs[i]["name"]
      });

    }
    for(int i=0;i<_fav.length;i++){
       if(_fav[i]["name"] == widget._prodect["name"]){
          count++;

       }}
        if(count>=1){

         print("موجود");
         //delet();
       }
      else
        {

          print("اضافه");
          addTofavorat();
        }
  });
}





@override
  void initState() {
    val();

    super.initState();
  }
  @override
  Widget build(BuildContext context) {
   return Scaffold(
     appBar: AppBar(centerTitle: true,backgroundColor: Colors.white,elevation: 0,
         actions:[
           Badge(child:IconButton(icon: Icon(Icons.shopping_cart,color: Colors.black)
            ,onPressed: (){
             Navigator.of(context).pushNamed("cart");
           }),value:itemcount.toString(),
       ),
     ],title:Text(widget._prodect["name"],textAlign: TextAlign.center),
         leading: IconButton(icon: Icon(Icons.arrow_back),onPressed: (){
           Navigator.pop(context);
         })
         ),
     body: SingleChildScrollView(
       child: Column(crossAxisAlignment: CrossAxisAlignment.center,children: [
         SizedBox(height: 5,),
         Container(height: 300,width: 500,child: Card(elevation: 5,child: Image.network(widget._prodect["image"],fit: BoxFit.fill),)),
         Text("${widget._prodect["name"]}",textAlign: TextAlign.end,style: TextStyle(fontStyle: FontStyle.normal,fontSize: 20,fontWeight: FontWeight.normal)),
        Text("${widget._prodect["dec"]}",style: TextStyle(decorationStyle: TextDecorationStyle.double,fontSize: 20,fontStyle: FontStyle.normal,fontWeight: FontWeight.bold)),
         SizedBox(height: 10,),
         Container(width:400,height: 40,
           child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,children: [
             StreamBuilder(
               stream: FirebaseFirestore.instance.collection("user_favorat_item").doc(FirebaseAuth.instance.currentUser!.email).collection("item").where("name",isEqualTo:widget._prodect["name"]).snapshots(),
               builder: (BuildContext context,AsyncSnapshot snapshot) {
                 return Expanded(flex:1,child:IconButton(icon: Icon(Icons.favorite,size: 30,color:Colors.black26, ),
                  onPressed: (){
                    validet();

                   },));
               }
             ),
             SizedBox(width: 250,),
             Expanded(flex:1,child: Text("${widget._prodect["price"]}"+" دع ",style: TextStyle(fontSize:25)),)
           ],),
         ),
         SizedBox(height: 5,),
         Container(height: 100,width: 300,
           child: Row(crossAxisAlignment: CrossAxisAlignment.center,mainAxisAlignment: MainAxisAlignment.center,children: [
             Expanded(flex:2,child: InkWell(child: CircleAvatar(child: Text("+",style: (TextStyle(fontSize: 25))),backgroundColor: AppColors.deep_green),onTap: (){
               setState((){
                 num++;
               });
             })),
             Text("$num",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold)),
             Expanded(flex: 2,child: InkWell(child: CircleAvatar(child: Text("-",style: (TextStyle(fontSize: 30))),backgroundColor: AppColors.deep_green),onTap: (){
               setState((){
                 num--;
                 if(num<= 1){
                   num=1;
                 }
                                });
             })),

           ],),
         ),
         ElevatedButton(onPressed: (){
           addToCart();

           Navigator.of(context).pop();

         },
           child: Text("اضافه الى السله",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 20)),style: ButtonStyle(backgroundColor:MaterialStateColor.resolveWith((states) => AppColors.deep_green, )),)
         


       ]),
     ),
   );
  }

}
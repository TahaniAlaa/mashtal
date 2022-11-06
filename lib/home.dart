import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:plantation/viewprodect.dart';

import 'AppColors.dart';

class Home extends StatefulWidget {

  @override
  State<StatefulWidget> createState() => _Home();
}

class _Home extends State<Home> {
  List _fav=[];
  List _carouesImage = [];
  List _prodect = [];
  List pro1 = [];
  List pro2 = [];
  List pro3 = [];
  List pro4 = [];
  List pro5 = [];
  List pro6 = [];
  var _firebaseInsstance = FirebaseFirestore.instance;

 // validet(_prodect)async{
 //   var count=0;
 //   var name=await FirebaseFirestore.instance.collection("user_favorat_item").doc(FirebaseAuth.instance.currentUser!.email).collection("item").get();
 //   setState(() {
 //     for(int i=0;i<name.docs.length;i++){
 //       _fav.add({
 //         "name": name.docs[i]["name"]
 //       });
 //
 //     }
 //     for(int i=0;i<_fav.length;i++){
 //       if(_fav[i]["name"] == _prodect["name"]){
 //         count++;
 //
 //       }}
 //     if(count>=1){
 //       print("موجود");
 //
 //     }
 //     else
 //     {
 //       print("اضافه");
 //       addTofavorat(_prodect);
 //     }
 //   });
 // }
 //
 //
 //  Future addTofavorat(_prodect)async {
 //
 //    final FirebaseAuth _auther = FirebaseAuth.instance;
 //    var currentUser = _auther.currentUser;
 //    CollectionReference _collectionRef = FirebaseFirestore.instance.collection(
 //        "user_favorat_item");
 //
 //
 //    return _collectionRef.doc(currentUser!.email).collection("item").doc().set(
 //        {
 //          "name":_prodect["name"],
 //          "price":_prodect["price"],
 //          "image":_prodect["image"],
 //          "dec": _prodect["dec"],
 //
 //        }).then((value) => print("added favorate "),
 //    );
 //  }




  addprodect() async {
    QuerySnapshot pn = await _firebaseInsstance.collection(
        "varieties of plants").get();
    setState(() {
      for (int i = 0; i < pn.docs.length; i++) {
        _carouesImage.add(
            {
              "image": pn.docs[i]["image"],
              "name": pn.docs[i]["name"],
            }
        );
      }
      });
  }

    fetchprodect() async {
      QuerySnapshot pn = await _firebaseInsstance.collection("prodects").get();
      setState(() {
        for (int i = 0; i < pn.docs.length; i++) {
          _prodect.add(
              {
                "image": pn.docs[i]["image"],
                "name": pn.docs[i]["name"],
                "price": pn.docs[i]["price"],
                "varities": pn.docs[i]["varities"],
                "dec": pn.docs[i]["dec"],
              }

          );
          if (_prodect[i]["varities"] == "wY5j5lf3aEVzXXCgtAiX") {
            pro1.add(
                {
                  "image": _prodect[i]["image"],
                  "name": _prodect[i]["name"],
                  "price": _prodect[i]["price"],
                  "varities": _prodect[i]["varities"],
                  "dec": _prodect[i]["dec"],
                }
            );
          }
          if (_prodect[i]["varities"] == "rfymQYKftiDT2BDTsoXW") {
            pro2.add(
                {
                  "image": _prodect[i]["image"],
                  "name": _prodect[i]["name"],
                  "price": _prodect[i]["price"],
                  "varities": _prodect[i]["varities"],
                  "dec": _prodect[i]["dec"],
                }
            );
          }
          if (_prodect[i]["varities"] == "VFgsTU32nlN5uov0bNIt") {
            pro3.add(
                {
                  "image": _prodect[i]["image"],
                  "name": _prodect[i]["name"],
                  "price": _prodect[i]["price"],
                  "varities": _prodect[i]["varities"],
                  "dec": _prodect[i]["dec"],
                }
            );
          }
          if (_prodect[i]["varities"] == "NKsmImDoQ1tgdQQzA0Pc") {
            pro4.add(
                {
                  "image": _prodect[i]["image"],
                  "name": _prodect[i]["name"],
                  "price": _prodect[i]["price"],
                  "varities": _prodect[i]["varities"],
                  "dec": _prodect[i]["dec"],
                }
            );
          }
          if (_prodect[i]["varities"] == "IaJ3b3qF2CRMlKh3Y8ix") {
            pro5.add(
                {
                  "image": _prodect[i]["image"],
                  "name": _prodect[i]["name"],
                  "price": _prodect[i]["price"],
                  "varities": _prodect[i]["varities"],
                  "dec": _prodect[i]["dec"],
                }
            );
          }
          if (_prodect[i]["varities"] == "BqLkQWfLgOSzdpT0QZ7a") {
            pro6.add(
                {
                  "image": _prodect[i]["image"],
                  "name": _prodect[i]["name"],
                  "price": _prodect[i]["price"],
                  "varities": _prodect[i]["varities"],
                  "dec": _prodect[i]["dec"],
                }
            );
          }
        }
      });
    }
    @override
    void initState() {


      addprodect();
      fetchprodect();



      super.initState();
    }
    @override
    Widget build(BuildContext context) {
      return Scaffold(
        body: Stack(children: [
          Container(
            decoration: BoxDecoration(color: AppColors.deep_green, borderRadius:
            BorderRadius.only(bottomRight: Radius.circular(150))),
            height: 80,
            width: double.infinity,
          ),
          ListView(
              children: [
                Container(width: double.infinity, height: 200,
                  child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      padding: EdgeInsets.only(top: 50),
                      itemCount: _carouesImage.length,
                      itemBuilder: (_, index) {
                        return Container(
                          width: 110, height: 110,
                          child: InkWell(
                          onTap: () =>
                              setState(() {
                                index = index;
                                print("${_carouesImage[index]["name"]}");
                                if(_carouesImage[index]["name"]=="اشجار ظل"){
                                  _prodect=pro1;
                                }
                                if(_carouesImage[index]["name"]=="صباريات"){
                                  _prodect=pro2;
                                }
                                if(_carouesImage[index]["name"]=="نباتات ظليه"){
                                  _prodect=pro3;
                                }
                                if(_carouesImage[index]["name"]=="اشجار مثمره"){
                                  _prodect=pro4;
                                }
                                if(_carouesImage[index]["name"]=="نباتات شميه حوليه"){
                                  _prodect=pro5;
                                }
                                if(_carouesImage[index]["name"]=="نباتات شمسيه دائمه"){
                                  _prodect=pro6;
                                }


                              }),
                          child: Card(
                            elevation: 3,
                            child: Column(children: [
                              Container(height: 100,
                                  child: Image.network(
                                      _carouesImage[index]["image"],
                                      fit: BoxFit.cover)),
                              SizedBox(child: Text(
                                  "${_carouesImage[index]["name"]}"))
                            ]),),
                        ),
                        );
                      }),
                 ),
                SizedBox(height: 5,),
                Container(width: 400, height: 400,
                  child: GridView.builder(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,), itemCount: _prodect.length,
                      itemBuilder: (_, index) {
                        return  InkWell(onTap: () =>
                            setState(() {
                              index = index;
                              Navigator.push(context, MaterialPageRoute(
                                  builder: (_) =>
                                      Viewprodect(_prodect[index])));
                            }),
                          child:Container(

                              width: 300,height: 250,
                              child:
                          Card(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                            elevation: 4,
                            margin: EdgeInsets.all(5),
                            child:
                            Stack(
                            children: <Widget>[
                            ClipRRect(
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(15),
                            topRight: Radius.circular(15),
                          ),
                          child: Image.network(
                            "${_prodect[index]["image"]}",
                            height: 250,
                            width: double.infinity,
                            fit: BoxFit.cover,
                          ),
                        ),
                          Positioned(
                            bottom: 1,
                            right: 1,
                            child: Container(
                              width: 200,
                              color: Colors.black54,

                              child: Center(child:Text(
                                "${_prodect[index]["name"]}",
                                style: TextStyle(
                                  fontSize: 20,
                                  color: Colors.white,
                                ),
                                softWrap: true,
                                overflow: TextOverflow.fade,
                              ),)
                            ),
                          )
                          ],
                        ),
                          // Card(
                          //   elevation: 3,
                          //   child: Column(children: [
                          //     Container(height: 100,
                          //         width: double.infinity,
                          //         child: Image.network(
                          //           "${_prodect[index]["image"]}",
                          //           fit: BoxFit.cover,)),
                          //
                          //     SizedBox(
                          //         child: Text("${_prodect[index]["name"]}")),
                          //     Row(crossAxisAlignment: CrossAxisAlignment.center,
                          //       mainAxisAlignment: MainAxisAlignment.center,
                          //       children: [
                          //         Text("${_prodect[index]["price"]}" + " دع  "),
                          //         IconButton(onPressed: () {
                          //
                          //         },
                          //             icon: Icon(Icons.shopping_cart,
                          //               color: Colors.blueGrey,)),
                          //         IconButton(onPressed: () {
                          //           validet(_prodect[index]);
                          //
                          //         },
                          //             icon: Icon(Icons.favorite,size: 25,
                          //             ))
                          //       ],)
                          //   ]),),

                        )));
                      }),
                ),

              ]),
        ]),

      );
    }
  }




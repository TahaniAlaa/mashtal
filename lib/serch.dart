import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:plantation/viewprodect.dart';

import 'AppColors.dart';

class Serch extends StatefulWidget {

  @override
  State<StatefulWidget> createState() => _serch();
}

class _serch extends State<Serch>{

Widget shoe(){
  return Center(child:CircularProgressIndicator());
}

  @override
  Widget build(BuildContext context) {
    var isbool=true;
    var inputText ;
   //TextEditingController _serchController=TextEditingController();
    return Scaffold(
        body:
        Stack(children: [
          SizedBox(
            child: Container(decoration:BoxDecoration(color: AppColors.deep_green,borderRadius:
            BorderRadius.only(bottomRight:Radius.circular(150) )),height:150,width: double.infinity,
            ),
          ),
          Container(
              child:Column(children: [
                Padding(
                    padding: const EdgeInsets.only(left: 20,right: 20),
                    child: Container(decoration: BoxDecoration(
                        color: Colors.white54,borderRadius: BorderRadius.circular(10)
                    ),
                      child: Row(children: [
                        Expanded(child: Container(
                            height: 60,
                           child: Center(
                                  child: TextFormField(
                                    decoration: InputDecoration(
                                      fillColor: Colors.white,
                                      focusedBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.all(Radius.circular(0)),
                                          borderSide: BorderSide(color: Colors.blue)),
                                      enabledBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.all(Radius.circular(0)),
                                          borderSide: BorderSide(color: Colors.grey)),
                                      hintText: "البحث من هنا ",
                                      hintStyle: TextStyle(fontSize: 15),
                                    ),
                                    onChanged: (val){
                                      setState(() {
                                        inputText = val;
                                        print(inputText);
                                      });

                                    },
                                    onTap: (){
                                      setState(() {
                                        isbool=false;
                                      });
                                    },


                                  )),
                            )),
                      ]),
                    )
                ),
               SizedBox(height: 5,),
               Expanded(
                   child:isbool? Container(
                      child: StreamBuilder(
                          stream: FirebaseFirestore.instance
                              .collection("prodects")
                              .where("name",isLessThanOrEqualTo: inputText)
                              .snapshots(),
                          builder: (BuildContext context,
                              AsyncSnapshot<QuerySnapshot> snapshot) {
                            if (snapshot.hasError) {
                              return Center(
                                child: Text("يوجد خطأ"),
                              );
                            }

                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return Center(
                                child: CircularProgressIndicator(),
                              );
                            }

                            return ListView(
                              children: snapshot.data!.docs
                                  .map((DocumentSnapshot document) {
                                Map<String, dynamic> data =
                                document.data() as Map<String, dynamic>;
                                return InkWell(onTap: () {
                                  setState(() {

                                    Navigator.push(context, MaterialPageRoute(
                                        builder: (_) => Viewprodect(data)));
                                  },);
                                },child:  Card(
                                    elevation: 5,
                                    child:ListTile(
                                      subtitle:  Text(data['name']),
                                     title: Image.network(data['image'],fit: BoxFit.fitWidth),
                                  ),
                                ));
                              }).toList(),
                            );
                          }),
                    ):CircularProgressIndicator(),
                  )


                        ])
          )
        ])
    );
  }
}



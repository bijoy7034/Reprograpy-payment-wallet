import 'dart:ffi';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:untitled5/Screens/models.dart';

class History extends StatefulWidget {
  const History({Key? key}) : super(key: key);

  @override
  State<History> createState() => _HistoryState();
}

class _HistoryState extends State<History> {
  final user = FirebaseAuth.instance.currentUser;
  
  List<String> docIds =[];
  
  Future getDocId() async {
    await FirebaseFirestore.instance.collection("{user: Student}").get()
        .then((snapshot) => snapshot.docs.forEach((document) {
          print(document.reference);
          docIds.add(document.reference.id);
    }),);
  }

  @override
  // void initState(){
  //   getDocId();
  //   super.initState();
  // }
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('Track Oder'),
      ),
      body: Column(
        children: [
          Center(
            child: Padding(
              padding: const EdgeInsets.only(top :28.0),
              child: Text("Your Orders", style: TextStyle(
                fontSize: 26,
                  fontWeight: FontWeight.bold,
                color: Colors.blue
              ),),
            ),
          ),
          Image.asset("assets/images/10.png" ,width: 300,),
          Expanded(
              child: FutureBuilder(
                future: getDocId() ,
                builder: (context, snapshot){
                  return ListView.builder(
                      itemCount: docIds.length,
                      itemBuilder: (context, index){
                        return ListTile(
                          title: GetUserName(documentId: docIds[index]),
                        );
                      }
                  );
                },
              )
          )
        ],
      ),
    );
  }
}


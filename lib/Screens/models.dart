import 'dart:ffi';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class GetUserName extends StatefulWidget {

  final String documentId;

  GetUserName({required this.documentId});

  @override
  State<GetUserName> createState() => _GetUserNameState();
}

class _GetUserNameState extends State<GetUserName> {
  @override

  Future<dynamic> readData(String collectionId, String documentId) async {
    CollectionReference referanceData = FirebaseFirestore.instance.collection(collectionId);
    return referanceData
        .doc(documentId)
        .get()
        .then((DocumentSnapshot documentSnapshot) {
      if (documentSnapshot.exists) {
        if (kDebugMode) {
          print('Document data: ${documentSnapshot.data()}');
        }
      } else {
        if (kDebugMode) {
          print('Document does not exist on the database');
        }
      }
    });
  }




  // String userType =' ';
  late String userType = " ";
  void initState(){
    final user = FirebaseAuth.instance.currentUser!;
    final name = user.email.toString();
    userType =  readData('studOrTech', name) as String;
    super.initState();
  }
  Widget build(BuildContext context) {



    final user = FirebaseAuth.instance.currentUser!;


    CollectionReference users = FirebaseFirestore.instance.collection(userType);
    return FutureBuilder<DocumentSnapshot>(
      future: users.doc(widget.documentId).get(),
        builder: ((context, snapshot){
          if(snapshot.connectionState == ConnectionState.done){
            Map<String, dynamic>data = snapshot.data!.data() as  Map<String, dynamic>;
            if(data['user_id'] == user.email){
              return Card(
                borderOnForeground: true,
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 18.0),
                  child: ListTile(
                    leading: Icon(Icons.print_outlined,size: 40,),
                    title: Padding(
                      padding: const EdgeInsets.only(bottom: 8.0),
                      child: Text('Status : ${data['status']}', style: TextStyle(
                        color: Colors.green,
                        fontWeight: FontWeight.bold,
                      ),),
                    ),
                    subtitle: Text('Print Type : ${data['printType']} \nCopies : ${data['copies']}\nAddons : ${data['addons']}'),

                  ),
                ),
              );
            }
          }
          return Row(
            children: [

            ],
          );

    })
    );
  }

}


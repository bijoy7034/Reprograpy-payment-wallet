import 'dart:ffi';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:untitled5/Screens/firebase_api.dart';
import 'package:untitled5/Screens/firebase_file.dart';


class TextBooks extends StatefulWidget {
  const TextBooks({Key? key}) : super(key: key);

  @override
  State<TextBooks> createState() => _TextBooksState();
}

class _TextBooksState extends State<TextBooks> {

  Widget buildFile(BuildContext context,FirebaseFile file)=> Column(
    children: [
      ListTile(
          contentPadding: EdgeInsets.all(16.0),
        tileColor: Colors.white70,
        leading: Image.network("https://upload.wikimedia.org/wikipedia/commons/thumb/8/87/PDF_file_icon.svg/1200px-PDF_file_icon.svg.png")
        ,title: Text(
          file.name
          ,style: TextStyle(
          fontWeight: FontWeight.bold,
        color: Colors.blue
        ),
        ),
        trailing: IconButton(
          icon: Icon(Icons.download), onPressed: ()async{
          await FirebaseApi.downlaodFile(file.ref);
          final snackBar = SnackBar(content: Text('Downlaoded ${file.name}'));
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
        },
      )),
    ],
  );
  late Future<List<FirebaseFile>> futureFiles;

  @override
  void initState(){
    super.initState();

    futureFiles = FirebaseApi.listAll('textbooks/');
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text("Textbooks"),
        elevation: 0,
      ),
      body: FutureBuilder<List<FirebaseFile>>(
          future: futureFiles,
          builder: (context, snapshort) {
            switch (snapshort.connectionState) {
              case ConnectionState.waiting:
                return Center(child: CircularProgressIndicator());
              default:
                if (snapshort.hasError) {
                  return Center(child: Text("ERROR OCCURED"),);
                } else {
                  final files = snapshort.data!;

                  return Column(
                    children: [
                      Expanded(
                          child: Column(
                            children: [
                              Image.asset("assets/images/10.png" ,width: 300,),
                              Center(
                                child: Text("TEXT BOOKS", style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 17
                                ),),
                              ),
                              SizedBox(height: 10,),
                              Expanded(
                                child: ListView.builder(
                                  itemCount: files.length ,
                                  itemBuilder: (context,index){
                                    final file = files[index];
                                    return buildFile(context, file);
                                  },
                                ),
                              ),
                            ],
                          )
                      )
                    ],
                  );
                }
            }
          })
    );
}
}



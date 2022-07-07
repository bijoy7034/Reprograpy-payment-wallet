import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:untitled5/Screens/HomePage.dart';
import 'navbar.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';


class AddFile extends StatefulWidget {
  const AddFile({Key? key}) : super(key: key);

  @override

  _AddFileState createState() => _AddFileState();
}

class _AddFileState extends State<AddFile> {
  final user = FirebaseAuth.instance.currentUser!;
  PlatformFile? pickedFile;
  UploadTask? uploadTask;
  final controller = TextEditingController();

  Future uploadFile() async{
    final name = user.email!;
    final path= 'files/${pickedFile!.name}';
    final file =  File(pickedFile!.path!);
    final ref = FirebaseStorage.instance.ref().child(path);
    uploadTask = ref.putFile(file);

    final snapshot = await uploadTask!.whenComplete(() {});

    final urlDownload = await snapshot.ref.getDownloadURL();
    print('Download Link : $urlDownload');
    // createUser(name : name,);
    final docUser = FirebaseFirestore.instance.collection('users').doc(user.uid);
    final json = {
      'user_id' :  name,
      'fileUrl' : urlDownload,
      'printType' : printType,
      'addOns' : addOns,
      'papper' : paperSel,
      'copies': _n,

    };
    await docUser.set(json);
    showDialog(
      context: context,
      builder: (BuildContext context) => _buildAboutDialog(context),
    );
  }

  Future selectFile () async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();
    if(result == null) return;
    setState((){
      PlatformFile file = result.files.first;
      pickedFile = result.files.first;
      fileContent = file.name;
    });

  }
  @override
  int _n = 0;
  String? printType;
  String? addOns;
  String? paperSel;
  String? fileContent = "No file selected";
  Widget build(BuildContext context) {
    return Scaffold(
      // drawer: NavBar(),
      appBar: AppBar(
        title: const Text("Add Files"),
        elevation: 0,
        actions: [
          IconButton(onPressed: ()=>{}, icon: Icon(Icons.search))
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(left: 18.0),
          child: Column(
            children:<Widget> [
              Padding(
                padding: const EdgeInsets.all(18.0),
                child: Row(
                  children: [
                    Text("Add document to print   :   ",style: TextStyle(
                        fontSize: 16
                    ),) ,
                    ElevatedButton(
                      onPressed: selectFile,
                      child: Text("OpenFile Explorer",) ,
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 28.0),
                child: Text(fileContent!,style: TextStyle(
                    color: Colors.red
                ),),
              ),
              // Padding(
              //   padding: const EdgeInsets.all(25.0),
              //   child: Image.asset("assets/images/ad.jpg", width: 300,),
              // ),
              Row(
                children: [
                  Padding(padding: EdgeInsets.only(left: 20),
                    child: Text("Print Type : ",style: TextStyle(
                        fontSize: 16
                    ),),)
                ],
              ),
              ListTile(
                title: Text("Color"),
                leading: Radio(
                    value: "Color",
                    groupValue: printType,
                    onChanged: (value){
                      setState(() {
                        printType = value.toString();
                      });
                    }),
              ),

              ListTile(
                title: Text("Greyscale"),
                leading: Radio(
                    value: "Greyscale",
                    groupValue: printType,
                    onChanged: (value){
                      setState(() {
                        printType = value.toString();
                      });
                    }),
              ),
              Row(
                children: [
                  Padding(padding: EdgeInsets.only(left: 20, top: 19,bottom: 10),
                    child: Text("Additional features : ",style: TextStyle(
                        fontSize: 16
                    ),),)
                ],
              ),
              ListTile(
                title: Text("Hard Bind"),
                leading: Radio(
                    value: "hard",
                    groupValue: addOns,
                    onChanged: (value){
                      setState(() {
                        addOns = value.toString();
                      });
                    }),
              ),

              ListTile(
                title: Text("Soft Bind"),
                leading: Radio(
                    value: "soft",
                    groupValue: addOns,
                    onChanged: (value){
                      setState(() {
                        addOns = value.toString();
                      });
                    }),
              ),
              ListTile(
                title: Text("Spiral Bind"),
                leading: Radio(
                    value: "spiral",
                    groupValue: addOns,
                    onChanged: (value){
                      setState(() {
                        addOns = value.toString();
                      });
                    }),
              ),
              ListTile(
                title: Text("Normal"),
                leading: Radio(
                    value: "normal",
                    groupValue: addOns,
                    onChanged: (value){
                      setState(() {
                        addOns = value.toString();
                      });
                    }),
              ),
              Row(
                children: [
                  Padding(padding: EdgeInsets.only(left: 20, top: 19,bottom: 10),
                    child: Text("Paper type: ",style: TextStyle(
                        fontSize: 16
                    ),),)
                ],

              ),
              ListTile(
                title: Text("A4"),
                leading: Radio(
                    value: "a4",
                    groupValue: paperSel,
                    onChanged: (value){
                      setState(() {
                        paperSel = value.toString();
                      });
                    }),
              ),
              ListTile(
                title: Text("A3"),
                leading: Radio(
                    value: "a3",
                    groupValue: paperSel,
                    onChanged: (value){
                      setState(() {
                        paperSel = value.toString();
                      });
                    }),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Text("Number of copies : ",style: TextStyle(
                    fontSize: 16
                  ),),
                  new FloatingActionButton.small(
                    heroTag: "12",
                    elevation: 2,
                    onPressed: () {
                      setState(() {
                        _n++;
                      });
                    },
                    child: new Icon(Icons.add, color: Colors.white,),
                    backgroundColor: Colors.blue,),

                  new Text('$_n',
                      style: new TextStyle(fontSize: 25.0)),

                  new FloatingActionButton.small(
                    heroTag: "hs",
                    elevation: 2,
                    onPressed:()=>{
                      setState(() {
                        if (_n != 0)
                          _n--;
                      })
                    },
                    child: new Icon(Icons.remove,
                        color: Colors.white),
                    backgroundColor: Colors.blue,),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10,left: 20,right: 20),
                child: Column(
                  children: [
                    TextField(
                      decoration: InputDecoration(
                          hintStyle: TextStyle(color: Colors.blue.shade300),
                          hintText: "Do you want to add any printing instructions"
                      ),
                    )
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 48.0,bottom: 58),
                child: ElevatedButton(onPressed: uploadFile,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 15.0,bottom: 15,left: 45,right: 45),
                    child: Text("SUBMIT"),
                  ),),
              ),


            ],
          ),
        ),
      ),
    );


  }
}

Widget _buildAboutDialog(BuildContext context) {
  final user = FirebaseAuth.instance.currentUser!;
  return new AlertDialog(
      title: Center(child: const Text('File successfully uploaded')),
      content: new Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
      ),
      actions: <Widget>[
        Center(child: Text("Order ID : ${user.uid} ")),
        SizedBox(height: 30,),
  new FlatButton(
  onPressed: () {
    Navigator.of(context).pop();
  },
  textColor: Theme.of(context).primaryColor,
  child: const Text('OK'),
  ),
  ],
  );
}
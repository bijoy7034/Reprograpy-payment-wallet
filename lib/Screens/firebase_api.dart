import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'dart:ffi';
import 'firebase_file.dart';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseApi {
  static Future<List<String>>_getDownloadLinks(List<Reference> refs) =>
      Future.wait(refs.map((refs)=> refs.getDownloadURL()).toList());

  static Future<List<FirebaseFile>> listAll(String path) async {
    final ref = FirebaseStorage.instance.ref(path);
    final result = await ref.listAll();

    final urls = await _getDownloadLinks(result.items);
    return urls
        .asMap()
        .map((index, url){
      final ref = result.items[index];
      final name = ref.name;
      final file = FirebaseFile(ref: ref, name : name , url : url);

      return MapEntry(index, file);
    })
        .values
        .toList();

  }
  static Future downlaodFile(Reference ref) async {
    final dir = await getApplicationDocumentsDirectory();
    final file = File('${dir.path}/${ref.name}');
    
    await ref.writeToFile(file);
  }
}
import 'package:flutter/material.dart';
class SearchFiles extends StatefulWidget {
  const SearchFiles({Key? key}) : super(key: key);

  @override
  State<SearchFiles> createState() => _SearchFilesState();
}

class _SearchFilesState extends State<SearchFiles> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
       title:  Text("Search for files"),
        elevation: 0,
      ),
    );
  }
}

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
       title:  Text("Support"),
        elevation: 0,
      ),
      body: Center(
        child: Column(
          children: [
            Image.asset("assets/18.png"),
            SizedBox(
              height: 10,
            ),
            Padding(padding: const EdgeInsets.all(0.8),
              child: Text("For support contact :" , style: TextStyle(
                color: Colors.blue,
                fontSize: 16,
              ), ),
            ),
            SizedBox(
              height: 20,
            ),
          Padding(padding: const EdgeInsets.all(0.8),
            child: Text("vishak.csb1923@saintgits.org",style: TextStyle(
              fontSize: 20,
            ), ),
          ),
            Padding(padding: const EdgeInsets.all(0.8),
              child: Text("thomasm.csb1923@saintgits.org",style: TextStyle(
                fontSize: 20,
              ), ),
            ),
            Padding(padding: const EdgeInsets.all(0.8),
              child: Text("theja.csb1923@saintgits.org",style: TextStyle(
                fontSize: 20,
              ), ),
            ),
            Padding(padding: const EdgeInsets.all(0.8),
              child: Text("tom.csb1923@saintgits.org",style: TextStyle(
                fontSize: 20,
              ), ),
            ),
            SizedBox(
              height: 10,
            ),
            Padding(padding: const EdgeInsets.all(0.8),
              child: Text("+916282206426", style: TextStyle(
                fontSize: 24,
              ),),
            ),
            Padding(padding: const EdgeInsets.all(0.8),
              child: Text("+917306942256", style: TextStyle(
                fontSize: 24,
              ),),
            ),
            SizedBox(
              height: 20,
            ),

          ],
        ),
      ),
    );
  }
}

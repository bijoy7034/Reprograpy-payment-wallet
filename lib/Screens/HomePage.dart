import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'accountPage.dart';
import 'addFile.dart';
import 'history.dart';
import 'search.dart';
import 'textbook.dart';
import 'navbar.dart';
class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);


  @override
  State<HomePage> createState() => _HomePageState();

}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue,
      drawer: NavBar(),
      appBar: AppBar(
        title: Text("REPROGRAPHY", style: TextStyle(
          fontSize: 24,
          letterSpacing: 3.3,
        ),),
        actions: [
          IconButton(onPressed: ()=>{
            Navigator.push(context,
            MaterialPageRoute(builder: (context)=>AccountPage()))
          }, icon: Icon(Icons.account_circle))
        ],
        elevation: 0,
        centerTitle: false,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              width: 500,
              decoration: BoxDecoration(
                  color: Colors.blue
              ),
              child: Padding(
                padding: const EdgeInsets.only(top: 50.0, bottom: 80.0,right: 50),
                child: Column(
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(left: 46.0),
                      child: Text("Upload Documents for Printing",style: TextStyle(
                        color: Colors.white,
                      ),),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 50.0,top: 20),
                      child: FloatingActionButton.large(onPressed: ()=>{
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>AddFile()))
                      },
                        heroTag: "1",
                        child: const Icon(Icons.add,color: Colors.white,size: 50,),elevation: 5,),
                    )
                  ],
                ),
              ),
            ),
            Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(topLeft: Radius.circular(60),topRight: Radius.circular(60)),
                  color: Colors.white
              ),
              width: 440,
              child: Padding(
                padding: const EdgeInsets.only(top: 10,bottom: 230),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(bottom: 18.0, left: 16.0, top: 20),
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: [
                            Column(
                              children: [
                                FloatingActionButton(
                                  heroTag: "2",
                                  onPressed: ()=>{
                                    Navigator.push(context, MaterialPageRoute(builder: (context)=>TextBooks()))
                                  },
                                  backgroundColor: Colors.lightBlue, child: Icon(Icons.book),),
                                Padding(
                                  padding: const EdgeInsets.only( left: 18.0, top: 8.0, right: 18),
                                  child: Text("Textbooks"),
                                )
                              ],
                            ),
                            Column(
                              children: [
                                FloatingActionButton(
                                  heroTag: "3",
                                  onPressed: ()=>{
                                    Navigator.push(context,
                                    MaterialPageRoute(builder: (context)=>SearchFiles()))
                                  },
                                  backgroundColor: Colors.lightBlue, child: Icon(Icons.search_rounded),),
                                Padding(
                                  padding: const EdgeInsets.only( left: 18.0, top: 8.0, right: 18),
                                  child: Text("Serach"),
                                )
                              ],
                            ),
                            Column(
                              children: [
                                FloatingActionButton(
                                  heroTag: "4",
                                  onPressed: ()=>{Navigator.push(context, MaterialPageRoute(builder: (context)=>History()))},
                                  backgroundColor: Colors.lightBlue, child: Icon(Icons.history),),
                                Padding(
                                  padding: const EdgeInsets.only( left: 18.0, top: 8.0, right: 18),
                                  child: Text("History"),
                                )
                              ],
                            ),
                            Column(
                              children: [
                                FloatingActionButton(
                                  heroTag: "5",
                                  onPressed: ()=>{},
                                  backgroundColor: Colors.lightBlue, child: Icon(Icons.support_agent),),
                                Padding(
                                  padding: const EdgeInsets.only( left: 18.0, top: 8.0, right: 18),
                                  child: Text("Support"),
                                )
                              ],
                            ),

                          ],
                        ),
                      ),
                    ),

                    InkWell(
                      onTap: ()=>{},
                      child: Container(
                        decoration: BoxDecoration(
                            color:Colors.grey.shade200,
                            borderRadius: BorderRadius.all(Radius.circular(10))
                        ),
                        child: Padding(
                          padding: const EdgeInsets.only(left: 25.0,right: .0,top: 17,bottom: 17),
                          child: Row(
                            children: [
                              Text("Track all Your Print Orders. Get Started Now     "),
                              ElevatedButton(onPressed: ()=>{}, child: Text("Track")
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),

                    Padding(
                      padding: const EdgeInsets.all(25.0),
                      child: Image.asset("assets/images/2.png"),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}


// import 'package:flutter/material.dart';
// import 'package:reprographic/Screens/HomePage.dart';
// import 'LoginPage.dart';
// import 'signup.dart';
//
// class WelcomePage extends StatefulWidget {
//   const WelcomePage({Key? key}) : super(key: key);
//
//   @override
//   _WelcomePageState createState() => _WelcomePageState();
// }
//
// class _WelcomePageState extends State<WelcomePage> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       appBar: AppBar(
//         title: Text("REPROGRAPY", style: TextStyle(
//             color: Colors.blue,
//             fontSize: 25
//         ),),
//         backgroundColor: Colors.white,
//         centerTitle: true,
//         elevation: 0,
//       ),
//       body: Padding(
//         padding: const EdgeInsets.only(top: 100.0),
//         child: Column(
//           children: [
//             Image.asset("assets/images/8.png"),
//             Padding(
//                 padding: const EdgeInsets.only(top: 108.0,left: 30,right: 30),
//                 child: ElevatedButton(onPressed: ()=>{
//                   Navigator.push(
//                       context,
//                       MaterialPageRoute(builder: (context)=> LoginPage())
//                   )
//                 }, child: Padding(
//                   padding: const EdgeInsets.only(top: 14.0, bottom: 14.0,left: 100,right: 100),
//                   child: Text("Login",style: TextStyle(
//                       fontSize: 16
//                   ),),
//                 ),style: ButtonStyle(
//                   shape: MaterialStateProperty.all<RoundedRectangleBorder>(
//                     RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(38.0),
//                     ),
//                   ),
//                 ),)
//             ),
//             Padding(
//               padding: const EdgeInsets.only(top: 18.0),
//               child: Text("Or"),
//             ),
//             Padding(padding: EdgeInsets.only(top: 40,left: 120),
//                 child: Row(
//                   children: [
//                     Text("Create a new account ? "),
//                     InkWell(
//                       onTap: ()=>{
//                         Navigator.push(context,
//                         MaterialPageRoute(builder: (context)=>SignUp() ))
//                       },
//                       child: Text("SignUp",style: TextStyle(
//                           color: Colors.blue,
//                           fontSize: 15
//                       ),),
//                     )
//                   ],
//                 )
//             ) ],
//         ),
//       ),
//     );
//   }
// }

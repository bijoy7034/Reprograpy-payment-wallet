import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
class AccountPage extends StatefulWidget {
  const AccountPage({Key? key}) : super(key: key);

  @override
  State<AccountPage> createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {

  String emailId = "Student";
  final user = FirebaseAuth.instance.currentUser!;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        foregroundColor: Colors.blue,
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Column(
        children: [
          Center(
            child: ClipOval(
              child: Image.network(
                'https://w7.pngwing.com/pngs/766/65/png-transparent-microsoft-account-msn-google-account-windows-10-microsoft-text-trademark-account.png',
                fit: BoxFit.cover,
                width: 90,
                height: 90,
              ),
            ),
          ),
          const SizedBox(height: 20,),
          Center(
            child: Text(user.email!,style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w400
            ),),
          ),
          const SizedBox(height: 20,),
          Center(
            child: Text(emailId,style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w400
            ),),
          ),
          SizedBox(height: 400,),
        ],
      ),
    );
  }
}

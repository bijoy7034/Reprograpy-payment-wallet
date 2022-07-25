import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class NavBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser!;
    return Drawer(
      child: ListView(
        // Remove padding
        padding: EdgeInsets.zero,
        children: [
          UserAccountsDrawerHeader(
            accountName: Text(user.email!),
            accountEmail: Text("Student"),
            currentAccountPicture: CircleAvatar(
              child: ClipOval(
                child: Image.network(
                  'https://images-na.ssl-images-amazon.com/images/G/01/x-locale/cs/help/images/gateway/self-service/account._CB660668669_.png',
                  fit: BoxFit.cover,
                  width: 90,
                  height: 90,
                ),
              ),
            ),
          ),

          ListTile(
            title: Text('Logout'),
            leading: Icon(Icons.exit_to_app),
            onTap: ()=> FirebaseAuth.instance.signOut(),
          ),
          Padding(
            padding: const EdgeInsets.only(top:428.0,left:60),
            child: Text("Copyright Reserved \u00a9",style: TextStyle(
                color: Colors.black45
            ),),
          ),
        ],
      ),
    );
  }
}

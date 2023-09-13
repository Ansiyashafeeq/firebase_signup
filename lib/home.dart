import 'package:firebase_signup/authentication.dart';
import 'package:firebase_signup/login.dart';
import 'package:flutter/material.dart';
class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          child: Text('Welcome'),

        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          AuthenticationHelper().signOut().then((_) => Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>Login())));
        },
        child: Icon(Icons.logout),
        tooltip: 'Logout',
      ),
    );
  }
}

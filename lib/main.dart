import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:learnify/HomePagePackage/homepage.dart';
import 'package:learnify/login_package/loginPage.dart';

Widget _defaultHome=LoginPage();
void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  if(await FirebaseAuth.instance.currentUser != null){
    _defaultHome=HomePage();
  }
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Learnify',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: _defaultHome,

    );
  }
}
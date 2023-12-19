import 'package:flutter/material.dart';
import 'package:gradutionprojec/screens/home/home_screen.dart';

void main() /*async*/ {
  /* WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();*/
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MyRoom Deco',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomeScreen(),
    );
  }
}

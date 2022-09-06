import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:mlph_equipments/screens/login.dart';
import 'package:mlph_equipments/utils/constants.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'MonstarlabPH Equipment-Request App',
      theme: ThemeData(
        primaryColor: kprimaryColor,
        colorScheme: const ColorScheme.light(primary: kprimaryColor),       
      ),
      home: const Login(),
    );
  }
}


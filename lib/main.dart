import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:tealth_project/HomePageScreen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: HomePage(),
  ));
}

import 'package:flutter/material.dart';
import 'package:practice/homepage.dart';
import 'package:shared_preferences/shared_preferences.dart';


late SharedPreferences sharedPreferences;
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  sharedPreferences = await SharedPreferences.getInstance();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const MyHomePage(),
      routes: {
        'homepage' :(context) => const MyHomePage()
      },
    );
  }
}





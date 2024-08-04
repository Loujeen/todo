import 'dart:io';
import 'dart:js';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo/Theme.dart';
import 'package:todo/home/Home_Screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:todo/provider/list_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  if (kIsWeb) {
    print("Running on Web");
    await Firebase.initializeApp(
      options: const FirebaseOptions(
          apiKey: 'AIzaSyAZkBYKogYnYQnX6GlRCMVZ5RNi66OPNf8',
          appId: 'com.example.todo',
          messagingSenderId: '509868187928',
          projectId: 'todo-21888'
      ),
    );
  } else {
    if (Platform.isAndroid) {
      print("Running on Android");
    } else if (Platform.isIOS) {
      print("Running on iOS");
    } else if (Platform.isLinux) {
      print("Running on Linux");
    } else if (Platform.isMacOS) {
      print("Running on macOS");
    } else if (Platform.isWindows) {
      print("Running on Windows");
    } else {
      print("Running on an unknown platform");
    }

    await Firebase.initializeApp(options: const FirebaseOptions(
        apiKey: 'AIzaSyAZkBYKogYnYQnX6GlRCMVZ5RNi66OPNf8',
        appId: 'com.example.todo',
        messagingSenderId: '509868187928',
        projectId: 'todo-21888'
    ),
    );
  }await FirebaseFirestore.instance.disableNetwork();
  runApp(ChangeNotifierProvider(
      create:(context)=> ListProvider(),
      child :MyApp()));
}
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute:HomeScreen.routeName ,
      routes: {
        HomeScreen.routeName : (context)=>HomeScreen(),
      },
      theme: ThemeDatamain.lightTheme,
    );
  }
}

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:wallzy/firebase_options.dart';
import 'package:wallzy/views/components/bottomNav.dart';
import 'package:wallzy/views/screens/home.dart';
import 'package:wallzy/views/screens/user_panel/login.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Wallzy',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      // home: const UserLogin(),
      home: const BottomNav(),
    );
  }
}


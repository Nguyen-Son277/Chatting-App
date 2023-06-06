// ignore_for_file: unused_import
import 'package:chatting_app_nt109n21/features/landing/screens/landing_screen.dart';
import 'package:chatting_app_nt109n21/firebase_options.dart';
import 'package:chatting_app_nt109n21/router.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:chatting_app_nt109n21/colors.dart';
// ignore:
import 'package:chatting_app_nt109n21/screens/mobile_layout_screen.dart';
import 'package:chatting_app_nt109n21/screens/web_layout_screen.dart';
import 'package:chatting_app_nt109n21/utils/responsive_layout.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const ProviderScope(child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Chatting app',
      theme: ThemeData.dark().copyWith(
          scaffoldBackgroundColor: backgroundColor,
          appBarTheme: const AppBarTheme(color: appBarColor)),
      onGenerateRoute: (settings) => generateRoute(settings),
      home: const LandingScreen(),
    );
  }
}

import 'package:chatting_app_nt109n21/common/widgets/error.dart';
import 'package:chatting_app_nt109n21/features/auth/screens/login_screen.dart';
import 'package:chatting_app_nt109n21/features/auth/screens/otp_screen.dart';
import 'package:chatting_app_nt109n21/features/auth/screens/user_infomation_screen.dart';
// ignore: unused_import
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
// ignore: unnecessary_import
import 'package:flutter/widgets.dart';

Route<dynamic> generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case LoginScreen.routeName:
      return MaterialPageRoute(builder: (context) => const LoginScreen());
    case OTPScreen.routeName:
      final verifitionId = settings.arguments as String;
      return MaterialPageRoute(builder: (context) =>  OTPScreen(
        verificationId: verifitionId,
      ));
      case UserInfomationScreen.routeName:
      return MaterialPageRoute(builder: (context) => const UserInfomationScreen(
      ));
    default:
      return MaterialPageRoute(
        builder: (context) => const Scaffold(
          body: ErrorScreen(error: 'This page doesn\'t exit'),
        ),
      );
  }
}

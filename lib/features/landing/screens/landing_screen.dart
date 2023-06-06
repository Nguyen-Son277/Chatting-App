import 'package:chatting_app_nt109n21/common/widgets/custom_button.dart';
import 'package:chatting_app_nt109n21/features/auth/screens/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:chatting_app_nt109n21/colors.dart';

// import 'package:chat_app_nt109/common/widgets/custom_button.dart';
// import 'package:chat_app_nt109/features/auth/screens/login_screen.dart';

class LandingScreen extends StatelessWidget {
  const LandingScreen({Key? key}) : super(key: key);

  void navigateToLoginScreen(BuildContext context) {
    Navigator.pushNamed(context, LoginScreen.routeName);
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 50),
            const Text(
              'Welcome to Chatting App',
              style: TextStyle(
                fontSize: 33,
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(height: size.height / 9),
            // Image.asset(
            //   "assets/bg.png",
            //   height: 340,
            //   width: 340,
            // ),
            Container(
              height: 250,
              width: 250,
              child: Icon(
                Icons.chat,
                size: 100,
                color: tabColor,
              ),
            ),
            SizedBox(height: size.height / 9),
            const Padding(
              padding: EdgeInsets.all(15.0),
              child: Text(
                'Read our Privacy Policy. Tap "Agree and continue" to accept the Terms of Service.',
                style: TextStyle(color: greyColor),
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(height: 10),
            SizedBox(
              width: size.width * 0.75,
              child: CustomButton(
                text: 'AGREE AND CONTINUE',
                onPressed: () => navigateToLoginScreen(context),

              ),
            ),
          ],
        ),
      ),
    );
  }
}

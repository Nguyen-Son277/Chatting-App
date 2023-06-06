import 'dart:io';

import 'package:chatting_app_nt109n21/common/repositories/common_firebase_storage_repositories.dart';
import 'package:chatting_app_nt109n21/common/utils/utils.dart';
import 'package:chatting_app_nt109n21/features/auth/screens/otp_screen.dart';
import 'package:chatting_app_nt109n21/features/auth/screens/showOTPDialog.dart';
import 'package:chatting_app_nt109n21/features/auth/screens/user_infomation_screen.dart';
import 'package:chatting_app_nt109n21/models/user_model.dart';
import 'package:chatting_app_nt109n21/screens/mobile_chat_screen.dart';
import 'package:chatting_app_nt109n21/screens/mobile_layout_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final authRepositoryProvider = Provider(
  (ref) => AuthRepository(
    auth: FirebaseAuth.instance,
    firestore: FirebaseFirestore.instance,
  ),
);

class AuthRepository {
  final FirebaseAuth auth;
  final FirebaseFirestore firestore;
  AuthRepository({
    required this.auth,
    required this.firestore,
  });

  // Future<void> signInWithPhone(
  //   BuildContext context,
  //   String phoneNumber,
  // ) async {
  //   await auth.verifyPhoneNumber(
  //       phoneNumber: phoneNumber,
  //       verificationCompleted: (PhoneAuthCredential credential) async {
  //         await auth.signInWithCredential(credential);
  //       },
  //       verificationFailed: (e) {
  //         showSnackBar(context: context, content: e.message!);
  //       });
  // }

  void signInWithPhone(BuildContext context, String phoneNumber) async {
    TextEditingController codeController = TextEditingController();
    try {
      await auth.verifyPhoneNumber(
        phoneNumber: phoneNumber,
        verificationCompleted: (PhoneAuthCredential credential) async {
          await auth.signInWithCredential(credential);
        },
        verificationFailed: (e) {
          showSnackBar(context: context, content: e.message!);
        },
        codeSent: ((String verificationId, int? resendToken) async {
          // Navigator.pushNamed(
          //   context,
          //   OTPScreen.routeName,
          //   arguments: verificationId,
          // );
          showOTPDialog(
            context: context,
            codeController: codeController,
            onPressed: () async {
              PhoneAuthCredential credential = PhoneAuthProvider.credential(
                verificationId: verificationId,
                smsCode: codeController.text.trim(),
              );
              await auth.signInWithCredential(credential);
              Navigator.of(context).pop();
            },
          );
        }),
        codeAutoRetrievalTimeout: (String verificationId) {},
      );
    } on FirebaseAuthException catch (e) {
      showSnackBar(context: context, content: e.message!);
    }
  }

  void verifyOTP({
    required BuildContext context,
    required String verificationId,
    required String userOTP,
  }) async {
    try {
      PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: verificationId,
        smsCode: userOTP,
      );
      await auth.signInWithCredential(credential);
      Navigator.pushNamedAndRemoveUntil(
          context, UserInfomationScreen.routeName, (route) => false);
    } on FirebaseAuthException catch (e) {
      showSnackBar(context: context, content: e.message!);
    }
  }

  void saveUserDataToFirebase({
    required String name,
    required File? profilePic,
    required ProviderRef ref,
    required BuildContext context,
  }) async {
    try {
      String uid = auth.currentUser!.uid;
      String photoUrl =
          'https://thuthuatnhanh.com/wp-content/uploads/2020/09/hinh-nen-hoat-hinh-de-thuong-cute-nen-hong-cho-con-gai.jpg';
      if (profilePic != null) {
        photoUrl = await ref
            .read(commonFirebaseStorageRepositoryProvider)
            .storeFileFirebase('profilePic/$uid', profilePic);
      }

      var user = UserModel(
          name: name,
          uid: uid,
          profilePic: photoUrl,
          isOnline: true,
          phoneNumber: auth.currentUser!.uid,
          groupId: []);
      await firestore.collection('user').doc(uid).set(user.toMap());
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => const MobileLayoutScreen()),
          (route) => false);
    } catch (e) {
      showSnackBar(context: context, content: e.toString());
    }
  }
}

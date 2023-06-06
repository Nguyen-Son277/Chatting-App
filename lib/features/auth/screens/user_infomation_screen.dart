import 'dart:io';

import 'package:chatting_app_nt109n21/common/utils/utils.dart';
import 'package:chatting_app_nt109n21/features/auth/controller/auth_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class UserInfomationScreen extends ConsumerStatefulWidget {
  static const String routeName = '/user-infomation';
  const UserInfomationScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<UserInfomationScreen> createState() =>
      _UserInfomationScreenState();
}

class _UserInfomationScreenState extends ConsumerState<UserInfomationScreen> {
  final TextEditingController nameController = TextEditingController();
  File? image;

  @override
  void dispose() {
    super.dispose();
    nameController.dispose();
  }

  void selectImage() async {
    image = await pickImageFromGallery(context);
    setState(() {});
  }

  void storeUserData() async {
    String name = nameController.text.trim();

    if (name.isNotEmpty) {
      ref.read(authControllerProvider).saveUserDataToFirebase(
            context,
            name,
            image,
          );
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      body: SafeArea(
          child: Center(
        child: Column(children: [
          Stack(
            children: [
              image == null
                  ? const CircleAvatar(
                      backgroundImage: NetworkImage(
                          'https://thuthuatnhanh.com/wp-content/uploads/2020/09/hinh-nen-hoat-hinh-de-thuong-cute-nen-hong-cho-con-gai.jpg'),
                      radius: 64,
                    )
                  : CircleAvatar(
                      backgroundImage: FileImage(
                        image!,
                      ),
                      radius: 64,
                    ),
              Positioned(
                bottom: -10,
                left: 80,
                child: IconButton(
                  onPressed: selectImage,
                  icon: const Icon(Icons.add_a_photo),
                ),
              )
            ],
          ),
          Row(
            children: [
              Container(
                width: size.width * 0.85,
                padding: const EdgeInsets.all(20),
                child: TextField(
                  controller: nameController,
                  decoration: const InputDecoration(
                    hintText: 'Enter your name',
                  ),
                ),
              ),
              IconButton(
                onPressed: storeUserData,
                icon: Icon(Icons.done),
              ),
            ],
          )
        ]),
      )),
    );
  }
}

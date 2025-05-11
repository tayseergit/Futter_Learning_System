import 'dart:io';

import 'package:learning_project/Constant/public_constant.dart';
import 'package:learning_project/Module/Profile/Cubit/cubit/profile_cubit.dart';
import 'package:learning_project/Module/home_page/View/home_page.dart';
import 'package:learning_project/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

class UploadPage extends StatefulWidget {
  const UploadPage({super.key});

  @override
  State<UploadPage> createState() => _UploadPageState();
}

class _UploadPageState extends State<UploadPage> {
  File? _imageFile;
  final ImagePicker _picker = ImagePicker();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ProfileCubit, ProfileState>(
      listener: (context, state) {
        if (state is ProfileUploaded) {
          customSnackBar(
            context: context,
            success: 1,
            message: S.of(context).success,
          );
          pushAndRemoveUntiTo(context: context, toPage: HomePage());
        }
      },
      builder: (context, state) {
        final ProfileCubit profileCubit = ProfileCubit.get(context);
        return Scaffold(
          appBar: AppBar(title: const Text("Profile")),
          body: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(),
              GestureDetector(
                onTap: profileCubit.pickProfileImage,
                child: CircleAvatar(
                  radius: 80,
                  backgroundColor: Colors.grey[300],
                  backgroundImage:
                      profileCubit.profileImage != null
                          ? FileImage(profileCubit.profileImage!)
                          : null,
                  child:
                      _imageFile == null
                          ? const Icon(
                            Icons.add_a_photo,
                            size: 40,
                            color: Colors.grey,
                          )
                          : null,
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  profileCubit.uploadProfileImage();
                },
                child: const Text("Upload"),
              ),
            ],
          ),
        );
      },
    );
  }
}

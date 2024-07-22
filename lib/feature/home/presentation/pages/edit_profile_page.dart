import 'dart:io';

import 'package:delivery_app/core/ui/loading_page.dart';
import 'package:delivery_app/feature/home/presentation/bloc/edit_profile/edit_profile_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

class EditProfilePage extends StatefulWidget {
  const EditProfilePage({super.key});

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  final EditProfileBloc _bloc = EditProfileBloc();
  File? _image;

  final TextEditingController fullNameController = TextEditingController();
  final FocusNode fullNameFocusNode = FocusNode();
  final TextEditingController addressController = TextEditingController();
  final FocusNode addressFocusNode = FocusNode();

  Future<void> _pickImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);

    if (image != null) {
      setState(() {
        _image = File(image.path);
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _bloc.add(EditProfileInit());
  }

  @override
  void dispose() {
    fullNameController.dispose();
    addressController.dispose();
    fullNameFocusNode.dispose();
    addressFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<EditProfileBloc, EditProfileState>(
      bloc: _bloc,
      listener: (context, state) {},
      builder: (context, state) {
        switch (state) {
          case EditProfileLoading():
            {
              return const LoadingPage();
            }

          case EditProfileSuccess():
            fullNameController.text = state.profileData.fullName ?? "";
            addressController.text = state.profileData.address ?? "";
            return Scaffold(
              appBar: AppBar(
                title: const Text("Edit profile"),
                centerTitle: true,
                actions: [
                  IconButton(onPressed: () {}, icon: const Icon(Icons.save))
                ],
              ),
              body: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 8, horizontal: 24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(
                      height: 20,
                      width: double.infinity,
                    ),
                    SizedBox(
                      height: 200,
                      width: 200,
                      child: GestureDetector(
                        onTap: () {
                          _pickImage();
                        },
                        child: Stack(
                          alignment: AlignmentDirectional.bottomEnd,
                          children: [
                            ClipOval(
                              child: _image == null
                                  ? Image.asset(
                                      "assets/images/user_default.jpg")
                                  : Image.file(
                                      _image!,
                                      height: 200,
                                      width: 200,
                                      fit: BoxFit.cover,
                                    ),
                            ),
                            Container(
                              decoration: BoxDecoration(
                                color: Colors.white,
                                border: Border.all(
                                  color: Colors.grey,
                                  width: 1.0,
                                ),
                                borderRadius: BorderRadius.circular(32),
                              ),
                              height: 64,
                              width: 64,
                              child: const Icon(Icons.edit),
                            ),
                          ],
                        ),
                      ),
                    ),
                    TextField(
                      controller: fullNameController,
                      focusNode: fullNameFocusNode,
                      onTap: () {
                        fullNameFocusNode.requestFocus();
                      },
                      decoration:
                          const InputDecoration(label: Text("Full name")),
                    ),
                    const SizedBox(height: 12),
                    TextField(
                      controller: addressController,
                      focusNode: addressFocusNode,
                      onTap: () {
                        addressFocusNode.requestFocus();
                      },
                      decoration: const InputDecoration(label: Text("Address")),
                    ),
                  ],
                ),
              ),
            );

          default:
            return const SizedBox();
        }
      },
    );
  }
}

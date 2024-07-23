import 'dart:io';

import 'package:delivery_app/core/ui/loading_page.dart';
import 'package:delivery_app/feature/home/domain/entity/profile_entity.dart';
import 'package:delivery_app/feature/home/presentation/bloc/edit_profile/edit_profile_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
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

  void removeImage() {
    setState(() {
      _image = null;
    });
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
      listenWhen: (previous, current) => current is EditProfileStateListener,
      buildWhen: (previous, current) => current is! EditProfileStateListener,
      listener: (context, state) {
        switch (state) {
          case EditProfileStateSuccessfulyUpdatedListener():
            {
              removeImage();
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                  content: Center(child: Text("Successfuly updated"))));
            }

          default:
            break;
        }
      },
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
                leading: IconButton(
                  onPressed: () {
                    context.go("/home/2");
                  },
                  icon: const Icon(Icons.arrow_back_ios),
                ),
                actions: [
                  IconButton(
                    onPressed: () {
                      _bloc.add(
                        EditProfileSaveChanges(
                          image: _image,
                          profileEntity: ProfileEntity(
                            fullName: fullNameController.text,
                            address: addressController.text,
                            imageUrl: _image == null
                                ? state.profileData.imageUrl
                                : null,
                          ),
                        ),
                      );
                    },
                    icon: const Icon(Icons.save),
                  )
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
                              child: _image != null // Set selected image
                                  ? Image.file(
                                      _image!,
                                      height: 200,
                                      width: 200,
                                      fit: BoxFit.cover,
                                    )
                                  : state.profileData.imageUrl != null
                                      ? Image.network(
                                          height: 200,
                                          width: 200,
                                          state.profileData.imageUrl!,
                                          fit: BoxFit.cover,
                                        ) // Set uploaded image if exist
                                      : Image.asset(
                                          "assets/images/user_default.jpg",
                                        ), // Default image
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

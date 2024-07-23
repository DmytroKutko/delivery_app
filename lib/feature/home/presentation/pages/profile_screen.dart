import 'package:delivery_app/core/ui/loading_page.dart';
import 'package:delivery_app/feature/home/presentation/bloc/profile/profile_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final ProfileBloc _bloc = ProfileBloc();

  @override
  void initState() {
    super.initState();
    _bloc.add(ProfileInitialEvent());
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ProfileBloc, ProfileState>(
      bloc: _bloc,
      listenWhen: (previous, current) => current is ProfileStateListener,
      buildWhen: (previous, current) => current is! ProfileStateListener,
      listener: (context, state) {
        switch (state) {
          case ProfileRedirectToLoginPage():
            {
              context.go("/login");
            }

          default:
            return;
        }
      },
      builder: (context, state) {
        switch (state) {
          case ProfileLoading():
            {
              return const LoadingPage();
            }
          case ProfileSuccess():
            {
              return Scaffold(
                appBar: AppBar(
                  actions: [
                    IconButton(
                        onPressed: () {
                          context.go("/edit_profile");
                        },
                        icon: const Icon(Icons.edit))
                  ],
                ),
                body: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(height: 15),
                    SizedBox(
                      height: 200,
                      width: 200,
                      child: ClipOval(
                        child: state.profile.imageUrl != null
                            ? Image.network(
                                height: 200,
                                width: 200,
                                state.profile.imageUrl!,
                                fit: BoxFit.cover,
                              ) // Set uploaded image if exist
                            : Image.asset(
                                "assets/images/user_default.jpg",
                              ), // Default image,
                      ),
                    ),
                    const SizedBox(height: 20),
                    Text(
                      state.profile.fullName ?? "Unknown",
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Icon(Icons.pin_drop),
                        const SizedBox(width: 10),
                        Text(
                          state.profile.address ?? "No data",
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                      ],
                    ),
                    const Spacer(flex: 1),
                    Center(
                      child: ElevatedButton(
                        onPressed: () {
                          _bloc.add(ProfileSignOutEvent());
                        },
                        style: ElevatedButton.styleFrom(
                          foregroundColor: Colors.black,
                          backgroundColor:
                              Colors.white, // Color of the text and icon
                          shape: RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.circular(24.0), // Rounded corners
                            side: const BorderSide(
                                color: Colors.black,
                                width: 1.0), // Border color and width
                          ),
                          padding: const EdgeInsets.symmetric(
                              vertical: 12.0), // Button padding
                        ),
                        child: const SizedBox(
                          width: 200,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment
                                .center, // Center the row items
                            children: [
                              Icon(Icons.logout),
                              SizedBox(width: 24),
                              Text("Sign out"),
                            ],
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                  ],
                ),
              );
            }
          default:
            return const SizedBox();
        }
      },
    );
  }
}

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
                          context.push("/edit_profile");
                        },
                        icon: const Icon(Icons.edit))
                  ],
                ),
                body: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(height: 15),
                    Center(
                      child: ClipOval(
                        child: Image.network(
                          "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTSLU5_eUUGBfxfxRd4IquPiEwLbt4E_6RYMw&s",
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    Text(
                      "User User",
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
                          "Street 123",
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                      ],
                    ),
                    const Spacer(flex: 1),
                    MaterialButton(
                      onPressed: () {
                        _bloc.add(ProfileSignOutEvent());
                      },
                      child: const Text("Sign out"),
                    )
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

import 'package:delivery_app/core/ui/loading_page.dart';
import 'package:delivery_app/feature/auth/presentation/bloc/register/register_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final RegisterBloc _bloc = RegisterBloc();

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController repeatPasswordController =
      TextEditingController();

  final FocusNode emailFocusNode = FocusNode();
  final FocusNode passwordFocusNode = FocusNode();
  final FocusNode repeatPasswordFocusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    _bloc.add(RegisterInitialEvent());
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    repeatPasswordController.dispose();

    emailFocusNode.dispose();
    passwordFocusNode.dispose();
    repeatPasswordFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<RegisterBloc, RegisterState>(
      bloc: _bloc,
      listener: (context, state) {
        switch (state) {
          case RegisterRedirectToEditProfilePage():
            {
              context.go("/edit_profile");
            }
            break;
          default:
        }
      },
      builder: (context, state) {
        switch (state) {
          case RegisterLoading():
            {
              return const LoadingPage();
            }

          case RegisterSuccess():
            {
              return Scaffold(
                body: SafeArea(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 8,
                      horizontal: 24,
                    ),
                    child: Column(
                      children: [
                        const SizedBox(
                          height: 20,
                          width: double.infinity,
                        ),
                        const Spacer(flex: 1),
                        const TextField(
                          decoration: InputDecoration(
                            label: Text("Email"),
                          ),
                        ),
                        const SizedBox(height: 15),
                        const TextField(
                          decoration: InputDecoration(
                            label: Text("Password"),
                          ),
                        ),
                        const SizedBox(height: 15),
                        const TextField(
                          decoration: InputDecoration(
                            label: Text("Repeat password"),
                          ),
                        ),
                        const SizedBox(height: 25),
                        MaterialButton(
                          color: Colors.teal,
                          textColor: Colors.white,
                          padding: const EdgeInsets.all(16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(40),
                          ),
                          onPressed: () {
                            _bloc.add(
                              RegisterSignUpEvent(
                                email: emailController.text,
                                password: passwordController.text,
                              ),
                            );
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Sign Up",
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyLarge
                                    ?.copyWith(color: Colors.white),
                              ),
                            ],
                          ),
                        ),
                        const Spacer(flex: 1),
                        GestureDetector(
                          onTap: () {
                            context.go("/login");
                          },
                          child: const Text("Go to login page"),
                        ),
                        const SizedBox(height: 40),
                      ],
                    ),
                  ),
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

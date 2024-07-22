import 'package:delivery_app/core/ui/loading_page.dart';
import 'package:delivery_app/feature/auth/presentation/bloc/login/login_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final LoginBloc _bloc = LoginBloc();

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final FocusNode emailFocusNode = FocusNode();
  final FocusNode passwordFocusNode = FocusNode();

  @override
  void initState() {
    if (!mounted) return;
    _bloc.add(LoginInit());
    super.initState();
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    emailFocusNode.dispose();
    passwordFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LoginBloc, LoginState>(
      bloc: _bloc,
      listener: (context, state) {
        switch (state) {
          case LoginErrorSignIn _:
            {
              ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Center(child: Text("Error SignIn"))));
            }
          case LoginSignUp _:
            {
              context.go("/register");
            }
          case LoginRedirectToHomePage _:
            {
              context.go("/home");
            }
          default:
            break;
        }
      },
      builder: (context, state) {
        switch (state) {
          case LoginLoadingState _:
            return const LoadingPage();

          case LoginSignInState _:
            return Scaffold(
              body: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 8, horizontal: 24),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Spacer(flex: 10),
                    TextField(
                      controller: emailController,
                      focusNode: emailFocusNode,
                      onTap: () {
                        emailFocusNode.requestFocus();
                      },
                      decoration: const InputDecoration(
                        label: Text("Email"),
                      ),
                    ),
                    TextField(
                      controller: passwordController,
                      onTap: () {
                        passwordFocusNode.requestFocus();
                      },
                      focusNode: passwordFocusNode,
                      obscureText: true,
                      decoration: const InputDecoration(
                        label: Text("Password"),
                      ),
                    ),
                    const SizedBox(height: 40),
                    MaterialButton(
                      color: Colors.teal,
                      textColor: Colors.white,
                      padding: const EdgeInsets.all(16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(40),
                      ),
                      onPressed: () {
                        _bloc.add(
                          LoginSignInEvent(
                            email: emailController.text,
                            password: passwordController.text,
                          ),
                        );
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Sign In",
                            style: Theme.of(context)
                                .textTheme
                                .bodyLarge
                                ?.copyWith(color: Colors.white),
                          ),
                        ],
                      ),
                    ),
                    const Spacer(flex: 7),
                    MaterialButton(
                      onPressed: () {
                        _bloc.add(LoginContinueWithGoogle());
                      },
                      color: Colors.blue,
                      textColor: Colors.white,
                      padding: const EdgeInsets.all(12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(40),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ClipOval(
                            child: Image.asset(
                              "assets/icons/google.png",
                              width: 32.0,
                              height: 32.0,
                            ),
                          ),
                          const SizedBox(width: 16),
                          Text(
                            "Continue with Google",
                            style: Theme.of(context)
                                .textTheme
                                .bodyLarge
                                ?.copyWith(color: Colors.white),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),
                    GestureDetector(
                      onTap: () {
                        _bloc.add(LoginSignUpEvent());
                      },
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("Dont have account yet? "),
                          Text(
                            "SignUp",
                            style: TextStyle(
                              color: Colors.blue,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 80),
                  ],
                ),
              ),
            );

          case LoginErrorState _:
            return const Scaffold();

          default:
            return const SizedBox();
        }
      },
    );
  }
}

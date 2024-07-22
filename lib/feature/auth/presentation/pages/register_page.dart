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

  @override
  void initState() {
    super.initState();
    _bloc.add(RegisterInitialEvent());
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<RegisterBloc, RegisterState>(
      bloc: _bloc,
      listener: (context, state) {},
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
                  child: Column(
                    children: [
                      GestureDetector(
                        onTap: () {
                          context.go("/login");
                        },
                        child: const Text("Go to login page"),
                      ),
                    ],
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

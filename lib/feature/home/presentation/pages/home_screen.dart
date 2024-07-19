import 'package:delivery_app/core/ui/loading_page.dart';
import 'package:delivery_app/feature/home/domain/entity/menu_entity.dart';
import 'package:delivery_app/feature/home/presentation/bloc/home/home_bloc.dart';
import 'package:delivery_app/feature/cart/presentation/widgets/cart_icon.dart';
import 'package:delivery_app/feature/home/presentation/widgets/menu_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final HomeBloc _bloc = HomeBloc();

  @override
  void initState() {
    _bloc.add(HomeInitialEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeBloc, HomeState>(
      bloc: _bloc,
      listenWhen: (previous, current) => current is HomeActionListener,
      buildWhen: (previous, current) => current is! HomeActionListener,
      listener: (context, state) {},
      builder: (context, state) {
        switch (state) {
          case HomeLoading():
            return Scaffold(
              appBar: AppBar(
                title: const Text("Menu"),
              ),
              body: const LoadingPage(),
            );
          case HomeSuccess():
            return Scaffold(
              appBar: AppBar(
                title: const Text("Menu"),
                centerTitle: true,
                actions: const [CartIcon()],
              ),
              body: ListView.builder(
                itemCount: state.list.length,
                itemBuilder: (context, index) {
                  MenuEntity item = state.list[index];
                  return GestureDetector(
                    onTap: () {
                      context.push('/product/${item.type}/${item.name}');
                    },
                    child: MenuItem(
                      item: item,
                    ),
                  );
                },
              ),
            );
          case HomeError():
          default:
            return const SizedBox();
        }
      },
    );
  }
}

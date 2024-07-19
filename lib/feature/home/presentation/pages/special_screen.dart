import 'package:delivery_app/core/ui/loading_page.dart';
import 'package:delivery_app/feature/cart/presentation/provider/cart_provider.dart';
import 'package:delivery_app/feature/cart/presentation/widgets/cart_icon.dart';
import 'package:delivery_app/feature/home/presentation/bloc/special/special_bloc.dart';
import 'package:delivery_app/feature/product/domain/entity/product_entity.dart';
import 'package:delivery_app/feature/product/presentation/widgets/products_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SpecialScreen extends ConsumerStatefulWidget {
  const SpecialScreen({super.key});

  @override
  ConsumerState<SpecialScreen> createState() => _SpecialScreenState();
}

class _SpecialScreenState extends ConsumerState<SpecialScreen> {
  final SpecialBloc _bloc = SpecialBloc();

  @override
  void initState() {
    _bloc.add(SpecialInitEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final cartProvider = ref.watch(cartChangeNotifierProvider);

    void addProduct(ProductEntity product) {
      cartProvider.add(product);
    }

    void removeProduct(ProductEntity product) {
      cartProvider.delete(product);
    }

    return BlocConsumer<SpecialBloc, SpecialState>(
      bloc: _bloc,
      listener: (context, state) {},
      builder: (context, state) {
        switch (state) {
          case SpecialLoading():
            return Scaffold(
              appBar: AppBar(
                title: const Text("Specials"),
                centerTitle: true,
                actions: const [CartIcon()],
              ),
              body: const LoadingPage(),
            );

          case SpecialSuccess():
            return Scaffold(
              appBar: AppBar(
                title: const Text("Specials"),
                centerTitle: true,
                actions: const [CartIcon()],
              ),
              body: ProductsList(
                products: state.products,
                addProduct: (product) {
                  addProduct(product);
                },
                removeProduct: (product) {
                  removeProduct(product);
                },
              ),
            );

          case SpecialError():
          default:
            return const SizedBox();
        }
      },
    );
  }
}

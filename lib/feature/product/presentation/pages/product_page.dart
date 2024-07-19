import 'package:delivery_app/core/ui/loading_page.dart';
import 'package:delivery_app/feature/cart/presentation/provider/cart_provider.dart';
import 'package:delivery_app/feature/cart/presentation/widgets/cart_icon.dart';
import 'package:delivery_app/feature/product/domain/entity/product_entity.dart';
import 'package:delivery_app/feature/product/presentation/bloc/product_bloc.dart';
import 'package:delivery_app/feature/product/presentation/widgets/products_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ProductPage extends ConsumerStatefulWidget {
  final String type;
  final String title;

  const ProductPage({super.key, required this.type, required this.title});

  @override
  ConsumerState<ProductPage> createState() => _ProductPageState();
}

class _ProductPageState extends ConsumerState<ProductPage> {
  final ProductBloc bloc = ProductBloc();

  @override
  void initState() {
    bloc.add(ProductInitialEvent(type: widget.type));
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

    return BlocConsumer<ProductBloc, ProductState>(
      bloc: bloc,
      listener: (context, state) {},
      builder: (context, state) {
        switch (state) {
          case ProductLoading():
            return const LoadingPage();

          case ProductSuccess():
            return Scaffold(
                appBar: AppBar(
                  title: Text(widget.title),
                  centerTitle: true,
                  actions: const [CartIcon()],
                ),
                body: ProductsList(
                  products: state.list,
                  addProduct: (product) {
                    addProduct(product);
                  },
                  removeProduct: (product) {
                    removeProduct(product);
                  },
                ));

          case ProductError():
            return const SizedBox();

          default:
            return const SizedBox();
        }
      },
    );
  }
}

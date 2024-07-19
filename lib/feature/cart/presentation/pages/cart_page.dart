import 'package:delivery_app/feature/cart/presentation/provider/cart_provider.dart';
import 'package:delivery_app/feature/cart/presentation/widgets/empty_cart_widget.dart';
import 'package:delivery_app/feature/product/domain/entity/product_entity.dart';
import 'package:delivery_app/feature/product/presentation/widgets/product_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_sticky_header/flutter_sticky_header.dart';

class CartPage extends ConsumerStatefulWidget {
  const CartPage({super.key});

  @override
  ConsumerState<CartPage> createState() => _CartPageState();
}

class _CartPageState extends ConsumerState<CartPage> {
  @override
  Widget build(BuildContext context) {
    final cartProvider = ref.watch(cartChangeNotifierProvider);

    // Handle empty list case
    double total = cartProvider.list.isNotEmpty
        ? cartProvider.list
            .map((product) => product.price)
            .reduce((a, b) => a + b)
        : 0.0;
    String formattedTotal = total.toStringAsFixed(2);

    void addProduct(ProductEntity product) {
      cartProvider.add(product);
    }

    void removeProduct(ProductEntity product) {
      cartProvider.delete(product);
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text("Cart"),
        centerTitle: true,
      ),
      body: cartProvider.list.isNotEmpty
          ? CustomScrollView(
              slivers: [
                SliverStickyHeader(
                  header: Container(
                    height: 60.0,
                    color: Colors.blue,
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    alignment: Alignment.center,
                    child: Text(
                      "Total: \$$formattedTotal",
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                            color: Colors.white,
                          ),
                    ),
                  ),
                  sliver: SliverList(
                    delegate: SliverChildBuilderDelegate(
                      (context, index) {
                        var uniqueProducts = cartProvider.list.toSet().toList();
                        // Ensure there are items to display
                        if (uniqueProducts.isEmpty) {
                          return const Center(child: Text("No items"));
                        }
                        ProductEntity product = uniqueProducts[index];
                        return Padding(
                          padding: index == 0
                              ? const EdgeInsets.only(top: 12)
                              : const EdgeInsets.all(0),
                          child: ProductTile(
                            product: product,
                            addProductToCart: () => addProduct(product),
                            removeProductFromCart: () => removeProduct(product),
                          ),
                        );
                      },
                      childCount: cartProvider.list.toSet().length,
                    ),
                  ),
                ),
              ],
            )
          : const EmptyCartWidget(),
    );
  }
}

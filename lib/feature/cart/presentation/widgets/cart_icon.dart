import 'package:delivery_app/feature/cart/presentation/provider/cart_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class CartIcon extends ConsumerWidget {
  const CartIcon({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cartProvider = ref.watch(cartChangeNotifierProvider);

    int getAllItemsCount() {
      return cartProvider.list.length < 99 ? cartProvider.list.length : 99;
    }

    return Stack(
      clipBehavior: Clip.none,
      children: [
        IconButton(
          onPressed: () {
            context.push("/cart");
          },
          icon: const Icon(Icons.shopping_bag),
        ),
        getAllItemsCount() > 0
            ? Positioned(
                right: 4,
                top: 4,
                child: ClipOval(
                  child: Container(
                    height: 18,
                    width: 18,
                    color: Colors.redAccent,
                    alignment: Alignment.center,
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 4),
                      child: Text(
                        "${getAllItemsCount()}",
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
              )
            : const SizedBox(),
      ],
    );
  }
}

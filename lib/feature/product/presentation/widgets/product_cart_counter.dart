import 'package:delivery_app/feature/cart/presentation/provider/cart_provider.dart';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ProductCartCounter extends ConsumerWidget {
  final int id;
  final Function addProduct;
  final Function removeProduct;

  const ProductCartCounter({
    super.key,
    required this.id,
    required this.addProduct,
    required this.removeProduct,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cartProvider = ref.watch(cartChangeNotifierProvider);

    int getCount() {
      return cartProvider.list.where((item) => item.id == id).length;
    }

    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: Colors.grey[200],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          GestureDetector(
            onTap: () => removeProduct(),
            child: Container(
              padding: const EdgeInsets.all(2),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: Colors.redAccent,
              ),
              child: const Icon(Icons.remove, color: Colors.white),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4),
            child: Text(
              '${getCount()}',
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
          GestureDetector(
            onTap: () => addProduct(),
            child: Container(
              padding: const EdgeInsets.all(2),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: Colors.teal,
              ),
              child: const Icon(Icons.add, color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}

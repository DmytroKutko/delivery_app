import 'package:delivery_app/feature/product/domain/entity/product_entity.dart';
import 'package:delivery_app/feature/product/presentation/widgets/product_cart_counter.dart';
import 'package:flutter/material.dart';

class ProductTile extends StatelessWidget {
  final ProductEntity product;
  final Function addProductToCart;
  final Function removeProductFromCart;

  const ProductTile({
    super.key,
    required this.product,
    required this.addProductToCart,
    required this.removeProductFromCart,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 150,
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 8),
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Colors.white,
      ),
      child: Row(
        children: [
        const SizedBox(width: 4),
          SizedBox(
            height: 90,
            child: ClipOval(
              child: Image.network(product.url),
            ),
          ),
          const SizedBox(width: 8),
          SizedBox(
            width: 160,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  product.name,
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
                const SizedBox(height: 10),
                Text(
                  product.description,
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                  softWrap: true,
                ),
              ],
            ),
          ),
          const Spacer(flex: 1),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              product.discount > 0
                  ? Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.teal,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 4, horizontal: 12),
                        child: Text(
                          "-${product.discount}%",
                          style: const TextStyle(
                              fontWeight: FontWeight.bold, color: Colors.white),
                        ),
                      ),
                    )
                  : const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.only(right: 8),
                child: Text(
                  "\$${product.price}",
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
              ),
              const Spacer(flex: 1),
              ProductCartCounter(
                id: product.id,
                addProduct: () => addProductToCart(),
                removeProduct: () => removeProductFromCart(),
              ),
              const SizedBox(height: 12),
            ],
          ),
          const SizedBox(width: 8),
        ],
      ),
    );
  }
}

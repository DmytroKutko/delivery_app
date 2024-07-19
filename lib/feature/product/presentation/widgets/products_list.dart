import 'package:delivery_app/feature/product/domain/entity/product_entity.dart';
import 'package:delivery_app/feature/product/presentation/widgets/product_tile.dart';
import 'package:flutter/material.dart';

class ProductsList extends StatelessWidget {
  final List<ProductEntity> products;
  final Function addProduct;
  final Function removeProduct;

  const ProductsList({
    super.key,
    required this.products,
    required this.addProduct,
    required this.removeProduct,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: products.length,
      itemBuilder: (context, index) {
        ProductEntity item = products[index];
        return Padding(
          padding: index == 0
              ? const EdgeInsets.only(top: 8)
              : const EdgeInsets.all(0),
          child: ProductTile(
            product: item,
            addProductToCart: () {
              addProduct(item);
            },
            removeProductFromCart: () {
              removeProduct(item);
            },
          ),
        );
      },
    );
  }
}

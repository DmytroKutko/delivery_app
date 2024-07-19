import 'package:delivery_app/feature/product/domain/entity/product_entity.dart';

abstract class ProductRepository {
  Future<List<ProductEntity>> getProductsByType(String type);
}
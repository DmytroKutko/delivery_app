import 'package:delivery_app/feature/product/domain/entity/product_entity.dart';
import 'package:delivery_app/feature/product/domain/repository/product_repository.dart';

class GetProductsUsecase {
  final ProductRepository repository;

  GetProductsUsecase({required this.repository});

  Future<List<ProductEntity>> getProductsByType(String type) {
    return repository.getProductsByType(type);
  }
}

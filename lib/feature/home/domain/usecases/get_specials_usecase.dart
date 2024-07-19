import 'package:delivery_app/feature/home/domain/repository/home_repository.dart';
import 'package:delivery_app/feature/product/domain/entity/product_entity.dart';

class GetSpecialsUsecase {
  final HomeRepository repository;

  GetSpecialsUsecase({required this.repository});
  
  Future<List<ProductEntity>> getSpecials() {
    return repository.getSpecials();
  }
}
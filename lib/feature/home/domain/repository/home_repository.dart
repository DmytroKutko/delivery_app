import 'package:delivery_app/feature/home/domain/entity/menu_entity.dart';
import 'package:delivery_app/feature/product/domain/entity/product_entity.dart';

abstract class HomeRepository {
  Future<List<MenuEntity>> getMenuItems();

  Future<List<ProductEntity>> getSpecials();
}

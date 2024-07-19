import 'package:delivery_app/feature/home/domain/entity/menu_entity.dart';
import 'package:delivery_app/feature/home/domain/repository/home_repository.dart';

class GetMenuItemsUsecase {
  final HomeRepository repository;

  GetMenuItemsUsecase({required this.repository});

  Future<List<MenuEntity>> getMenuItems() {
    return repository.getMenuItems();
  }
}

import 'package:delivery_app/feature/home/data/remote/supabase.dart';
import 'package:delivery_app/feature/home/domain/entity/menu_entity.dart';
import 'package:delivery_app/feature/home/domain/repository/home_repository.dart';
import 'package:delivery_app/feature/product/domain/entity/product_entity.dart';

class HomeRepositoryImpl extends HomeRepository {
  final SupabaseService supabaseService;

  HomeRepositoryImpl({required this.supabaseService});

  @override
  Future<List<MenuEntity>> getMenuItems() async {
    return supabaseService.getMenuItems();
  }

  @override
  Future<List<ProductEntity>> getSpecials() {
    return supabaseService.getSpecials();
  }
}

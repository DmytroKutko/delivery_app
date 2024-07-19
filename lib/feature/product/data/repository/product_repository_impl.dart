import 'package:delivery_app/feature/home/data/remote/supabase.dart';
import 'package:delivery_app/feature/product/domain/entity/product_entity.dart';
import 'package:delivery_app/feature/product/domain/repository/product_repository.dart';

class ProductRepositoryImpl extends ProductRepository {
  final SupabaseService supabaseService;

  ProductRepositoryImpl({required this.supabaseService});

  @override
  Future<List<ProductEntity>> getProductsByType(String type) async {
    return await supabaseService.getProductsByType(type);
  }
}

import 'package:delivery_app/feature/home/data/model/menu_model.dart';
import 'package:delivery_app/feature/product/data/model/product_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseService {
  final SupabaseClient client;

  SupabaseService({required this.client});

  Future<List<MenuModel>> getMenuItems() async {
    final response = await client.from('menu').select();

    final data = response as List<dynamic>;

    return data
        .map((item) => MenuModel.fromJson(item as Map<String, dynamic>))
        .toList()
      ..sort((a, b) => a.id.compareTo(b.id));
  }

  Future<List<ProductModel>> getProductsByType(String type) async {
    final response = await client.from('products').select().eq('type', type);

    final data = response as List<dynamic>;

    return data
        .map((item) => ProductModel.fromJson(item as Map<String, dynamic>))
        .toList();
  }

  Future<List<ProductModel>> getSpecials() async {
    final response = await client.from('products').select().neq('discount', 0);

    final data = response as List<dynamic>;

    return data
        .map((item) => ProductModel.fromJson(item as Map<String, dynamic>))
        .toList();
  }
}

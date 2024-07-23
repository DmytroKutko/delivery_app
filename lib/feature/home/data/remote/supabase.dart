import 'dart:io';

import 'package:delivery_app/feature/home/data/model/menu_model.dart';
import 'package:delivery_app/feature/home/data/model/profile_model.dart';
import 'package:delivery_app/feature/home/domain/entity/profile_entity.dart';
import 'package:delivery_app/feature/product/data/model/product_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:uuid/uuid.dart';
import 'package:path/path.dart' as path; 

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

  Future<ProfileModel> getProfileData() async {
    final id = client.auth.currentUser!.id;

    final response =
        await client.from('profiles').select().eq('id', id).single();

    return ProfileModel.fromJson(response);
  }

  Future<ProfileModel> updateProfile(File? image, ProfileEntity profile) async {
    final id = client.auth.currentUser!.id;
    String? imageUrl;

    if (image != null) {
      // Ensure the client is authenticated
      if (client.auth.currentSession == null) {
        throw Exception('User not authenticated');
      }

      // Generate a unique filename using UUID
      final uuid = const Uuid().v4();
      final fileExtension = path.extension(image.path);
      final fileName = '$uuid$fileExtension';

      // Upload image to Supabase storage
      await client.storage
          .from('images')
          .upload('images/$id/$fileName', image);

      // Get public URL of the uploaded image
      imageUrl =
          client.storage.from('images').getPublicUrl('images/$id/$fileName');
    }

    // Update the user's profile with the new image URL
    final updateData = {
      'full_name': profile.fullName,
      'avatar_url':
          imageUrl ?? profile.imageUrl, // Use existing imageUrl if no new image
      'address': profile.address,
    };

    final response = await client
        .from('profiles')
        .update(updateData)
        .eq('id', id)
        .select()
        .single();

    return ProfileModel.fromJson(response);
  }
}

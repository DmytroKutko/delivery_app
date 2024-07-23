import 'dart:io';

import 'package:delivery_app/feature/home/data/remote/supabase.dart';
import 'package:delivery_app/feature/home/domain/entity/profile_entity.dart';
import 'package:delivery_app/feature/home/domain/repository/profile_repository.dart';

class ProfileRepositoryImpl extends ProfileRepository {
  final SupabaseService supabaseService;

  ProfileRepositoryImpl({required this.supabaseService});

  @override
  Future<ProfileEntity> getProfileData() {
    return supabaseService.getProfileData();
  }

  @override
  Future<ProfileEntity> updateProfileData(File? image, ProfileEntity profile) {
    return supabaseService.updateProfile(image, profile);
  }
}

import 'dart:io';

import 'package:delivery_app/feature/home/domain/entity/profile_entity.dart';
import 'package:delivery_app/feature/home/domain/repository/profile_repository.dart';

class UpdateProfileUsecase {
  final ProfileRepository repository;

  UpdateProfileUsecase({required this.repository});

  Future<ProfileEntity> updateProfile(File? image, ProfileEntity profile) async {
    return repository.updateProfileData(image, profile);
  }
}
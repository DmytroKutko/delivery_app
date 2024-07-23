import 'dart:io';

import 'package:delivery_app/feature/home/domain/entity/profile_entity.dart';

abstract class ProfileRepository {
  Future<ProfileEntity> getProfileData();
  Future<ProfileEntity> updateProfileData(File? image, ProfileEntity profile);
}

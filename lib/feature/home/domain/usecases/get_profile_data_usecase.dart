import 'package:delivery_app/feature/home/domain/entity/profile_entity.dart';
import 'package:delivery_app/feature/home/domain/repository/profile_repository.dart';

class GetProfileDataUsecase {
  final ProfileRepository repository;

  GetProfileDataUsecase({required this.repository});

  Future<ProfileEntity> getProfileData() {
    return repository.getProfileData();
  }
}

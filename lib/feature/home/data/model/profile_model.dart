import 'package:delivery_app/feature/home/domain/entity/profile_entity.dart';

class ProfileModel extends ProfileEntity {
  ProfileModel({super.imageUrl, super.fullName, super.address});

  factory ProfileModel.fromJson(Map<String, dynamic> json) {
    return ProfileModel(
      fullName: json['full_name'],
      imageUrl: json['avatar_url'],
      address: json['address'],
    );
  }
}

import 'package:delivery_app/feature/home/domain/repository/home_repository.dart';

class ProfileSignOutUsecase {
  final HomeRepository repository;

  ProfileSignOutUsecase({required this.repository});
  
  Future<void> singOut(){
    return repository.signOut();
  }
}
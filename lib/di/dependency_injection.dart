import 'package:delivery_app/feature/auth/data/repository/login_repository_impl.dart';
import 'package:delivery_app/feature/auth/domain/repository/login_repository.dart';
import 'package:delivery_app/feature/auth/domain/usecases/get_current_session_usecase.dart';
import 'package:delivery_app/feature/auth/domain/usecases/login_with_email_and_password_usecase.dart';
import 'package:delivery_app/feature/home/data/remote/supabase.dart';
import 'package:delivery_app/feature/home/data/repository/home_repository_impl.dart';
import 'package:delivery_app/feature/home/domain/repository/home_repository.dart';
import 'package:delivery_app/feature/home/domain/usecases/get_menu_items_usecase.dart';
import 'package:delivery_app/feature/home/domain/usecases/get_specials_usecase.dart';
import 'package:delivery_app/feature/home/domain/usecases/profile_sign_out_usecase.dart';
import 'package:delivery_app/feature/product/data/repository/product_repository_impl.dart';
import 'package:delivery_app/feature/product/domain/repository/product_repository.dart';
import 'package:delivery_app/feature/product/domain/usacases/get_products_usecase.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get_it/get_it.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

GetIt sl = GetIt.I;

Future<void> setupLocator() async {
  // Dotenv
  await dotenv.load();

  // Supabase
  await Supabase.initialize(
    url: dotenv.env['SUPABASE_URL']!,
    anonKey: dotenv.env['SUPABASE_ANON_KEY']!,
  );
  sl.registerSingleton<SupabaseClient>(Supabase.instance.client);

  // Network
  sl.registerSingleton<SupabaseService>(
      SupabaseService(client: sl<SupabaseClient>()));

  // Repository
  sl.registerSingleton<HomeRepository>(
      HomeRepositoryImpl(supabaseService: sl()));
  sl.registerSingleton<ProductRepository>(
      ProductRepositoryImpl(supabaseService: sl()));
  sl.registerSingleton<LoginRepository>(
      LoginRepositoryImpl(supabaseService: sl()));

  // Usecases
  sl.registerSingleton(GetMenuItemsUsecase(repository: sl()));
  sl.registerSingleton(GetProductsUsecase(repository: sl()));
  sl.registerSingleton(GetSpecialsUsecase(repository: sl()));
  sl.registerSingleton(LoginWithEmailAndPasswordUsecase(repository: sl()));
  sl.registerSingleton(GetCurrentSessionUsecase(repository: sl()));
  sl.registerSingleton(ProfileSignOutUsecase(repository: sl()));
}

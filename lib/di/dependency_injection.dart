import 'package:delivery_app/feature/home/data/remote/supabase.dart';
import 'package:delivery_app/feature/home/data/repository/home_repository_impl.dart';
import 'package:delivery_app/feature/home/domain/repository/home_repository.dart';
import 'package:delivery_app/feature/home/domain/usecases/get_menu_items_usecase.dart';
import 'package:delivery_app/feature/home/domain/usecases/get_specials_usecase.dart';
import 'package:delivery_app/feature/product/data/repository/product_repository_impl.dart';
import 'package:delivery_app/feature/product/domain/repository/product_repository.dart';
import 'package:delivery_app/feature/product/domain/usacases/get_products_usecase.dart';
import 'package:get_it/get_it.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

GetIt sl = GetIt.I;

Future<void> setupLocator() async {
  // Supabase
  await sl.registerSingleton(Supabase.initialize(
    url: 'https://inurqaacvswmfuoryrhq.supabase.co',
    anonKey:
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImludXJxYWFjdnN3bWZ1b3J5cmhxIiwicm9sZSI6ImFub24iLCJpYXQiOjE3MjA4NjQxODAsImV4cCI6MjAzNjQ0MDE4MH0.SFKYp0-dC3CegfmwRR0bi7aiPhBMj9OUB_qZeS0BSLM',
  ));
  sl.registerSingleton<SupabaseClient>(Supabase.instance.client);

  // Network
  sl.registerSingleton<SupabaseService>(SupabaseService(client: sl<SupabaseClient>()));

  // Repository
  sl.registerSingleton<HomeRepository>(HomeRepositoryImpl(supabaseService: sl()));
  sl.registerSingleton<ProductRepository>(ProductRepositoryImpl(supabaseService: sl()));

  // Usecases
  sl.registerSingleton(GetMenuItemsUsecase(repository: sl()));
  sl.registerSingleton(GetProductsUsecase(repository: sl()));
  sl.registerSingleton(GetSpecialsUsecase(repository: sl()));
}

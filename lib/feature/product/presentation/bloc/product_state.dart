part of 'product_bloc.dart';

@immutable
sealed class ProductState {}

final class ProductInitial extends ProductState {}
final class ProductLoading extends ProductState {}
final class ProductSuccess extends ProductState {
  final List<ProductEntity> list;

  ProductSuccess({required this.list});
}
final class ProductError extends ProductState {}

part of 'product_bloc.dart';

@immutable
sealed class ProductEvent {}

class ProductInitialEvent extends ProductEvent {
  final String type;

  ProductInitialEvent({required this.type});
}
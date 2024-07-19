part of 'special_bloc.dart';

@immutable
sealed class SpecialState {}

final class SpecialInitial extends SpecialState {}

final class SpecialLoading extends SpecialState {}

final class SpecialSuccess extends SpecialState {
  final List<ProductEntity> products;

  SpecialSuccess({required this.products});
}

final class SpecialError extends SpecialState {}

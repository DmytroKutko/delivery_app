part of 'home_bloc.dart';

@immutable
sealed class HomeState {}
sealed class HomeActionListener extends HomeState {}

final class HomeInitial extends HomeState {}
final class HomeLoading extends HomeState {}
final class HomeSuccess extends HomeState {
  final List<MenuEntity> list;

  HomeSuccess({required this.list});
}
final class HomeError extends HomeState {}

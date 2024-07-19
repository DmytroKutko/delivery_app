import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:delivery_app/di/dependency_injection.dart';
import 'package:delivery_app/feature/home/domain/entity/menu_entity.dart';
import 'package:delivery_app/feature/home/domain/usecases/get_menu_items_usecase.dart';
import 'package:flutter/material.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  GetMenuItemsUsecase menuItemsUsecase = sl();

  HomeBloc() : super(HomeInitial()) {
    on<HomeInitialEvent>(homeInitialEvent);
  }

  FutureOr<void> homeInitialEvent(
      HomeInitialEvent event, Emitter<HomeState> emit) async {
    emit(HomeLoading());

    var list = await menuItemsUsecase.getMenuItems();

    emit(HomeSuccess(list: list));
  }
}

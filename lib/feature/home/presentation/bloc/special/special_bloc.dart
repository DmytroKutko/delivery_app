import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:delivery_app/di/dependency_injection.dart';
import 'package:delivery_app/feature/home/domain/usecases/get_specials_usecase.dart';
import 'package:delivery_app/feature/product/domain/entity/product_entity.dart';
import 'package:flutter/material.dart';
part 'special_event.dart';
part 'special_state.dart';

class SpecialBloc extends Bloc<SpecialEvent, SpecialState> {
  final GetSpecialsUsecase specialsUsecase = sl();

  SpecialBloc() : super(SpecialInitial()) {
    on<SpecialInitEvent>(specialInitEvent);
  }

  FutureOr<void> specialInitEvent(
      SpecialInitEvent event, Emitter<SpecialState> emit) async {
    emit(SpecialLoading());

    List<ProductEntity> products = await specialsUsecase.getSpecials();

    emit(SpecialSuccess(products: products));
  }
}

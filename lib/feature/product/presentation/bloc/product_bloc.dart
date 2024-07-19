import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:delivery_app/di/dependency_injection.dart';
import 'package:delivery_app/feature/product/domain/entity/product_entity.dart';
import 'package:delivery_app/feature/product/domain/usacases/get_products_usecase.dart';
import 'package:flutter/material.dart';

part 'product_event.dart';
part 'product_state.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  final GetProductsUsecase productsUsecase = sl();

  ProductBloc() : super(ProductInitial()) {
    on<ProductInitialEvent>(productInitialEvent);
  }

  FutureOr<void> productInitialEvent(ProductInitialEvent event, Emitter<ProductState> emit) async {
    emit(ProductInitial());

    final products = await productsUsecase.getProductsByType(event.type);

    emit(ProductSuccess(list: products));
  }
}

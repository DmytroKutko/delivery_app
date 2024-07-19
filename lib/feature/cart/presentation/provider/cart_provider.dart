import 'dart:collection';
import 'package:delivery_app/feature/product/domain/entity/product_entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CartChangeNotifier extends ChangeNotifier {
  final List<ProductEntity> _list = [];

  UnmodifiableListView get list => UnmodifiableListView(_list);

  void add(ProductEntity item) {
    if (_list.where((cartItem) { return cartItem.id == item.id; }).length < 99) {
      _list.add(item);
      _list.sort((a, b) => a.id.compareTo(b.id));
      notifyListeners();
    }
  }

  void delete(ProductEntity item) {
    for (var element in _list) {
      if (element.id == item.id) {
        _list.remove(element);
        break;
      }
    }
    notifyListeners();
  }
}

final cartChangeNotifierProvider =
    ChangeNotifierProvider<CartChangeNotifier>((ref) {
  return CartChangeNotifier();
});

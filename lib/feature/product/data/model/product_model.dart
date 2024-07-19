import 'package:delivery_app/feature/product/domain/entity/product_entity.dart';

class ProductModel extends ProductEntity {
  ProductModel({
    required super.id,
    required super.name,
    required super.url,
    required super.description,
    required super.type,
    required super.price,
    required super.discount,
  });
  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      id: json['id'],
      name: json['name'],
      url: json['image_url'],
      description: json['description'],
      type: json['type'],
      price: json['price'],
      discount: json['discount'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'image_url': url,
      'type': type,
      'price': price,
      'discount': discount,
    };
  }
}

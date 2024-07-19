import 'package:delivery_app/feature/home/domain/entity/menu_entity.dart';

class MenuModel extends MenuEntity {
  MenuModel({required super.id, required super.name, required super.url, required super.type});

  factory MenuModel.fromJson(Map<String, dynamic> json) {
    return MenuModel(
      id: json['id'],
      name: json['name'],
      url: json['image_url'],
      type: json['type'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'image_url': url,
      'type': type,
    };
  }
}

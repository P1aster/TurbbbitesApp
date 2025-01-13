import 'package:turbbbites_flutter_app/models/dish_category_model.dart';

class DishModel {
  const DishModel({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.editedAt,
    required this.available,
    this.imageURL,
    this.dishCategory,
  });

  final int id;
  final String name;
  final String description;
  final double price;
  final DateTime editedAt;
  final bool available;
  final String? imageURL;
  final DishCategoryModel? dishCategory;

  factory DishModel.fromJson(Map<String, dynamic> json) {
    return DishModel(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      price: json['price'],
      editedAt: DateTime.parse(json['editedAt']),
      available: json['available'],
      imageURL: json['imageURL'],
      dishCategory: json['dishCategory'] != null
          ? DishCategoryModel.fromJson(json['dishCategory'])
          : null,
    );
  }
}

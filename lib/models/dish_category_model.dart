class DishCategoryModel {
  const DishCategoryModel({
    required this.id,
    required this.name,
  });

  final int id;
  final String name;

  factory DishCategoryModel.fromJson(Map<String, dynamic> json) {
    return DishCategoryModel(
      id: json['id'],
      name: json['name'],
    );
  }
}

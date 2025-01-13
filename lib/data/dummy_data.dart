import 'package:turbbbites_flutter_app/models/dish_category_model.dart';
import 'package:turbbbites_flutter_app/models/dish_model.dart';

const List<DishCategoryModel> dummyDishCategories = [
  DishCategoryModel(
    id: 0,
    name: "All",
  ),
  DishCategoryModel(
    id: 1,
    name: "Pizza",
  ),
  DishCategoryModel(
    id: 2,
    name: "Burger",
  ),
];

List<DishModel> dummyDishes = [
  DishModel(
    id: 1,
    name: "Margherita",
    description: "Cheese and Tomato",
    price: 10.00,
    editedAt: DateTime.now(),
    available: true,
    dishCategory: dummyDishCategories[1],
  ),
  DishModel(
    id: 2,
    name: "Pepperoni",
    description: "Cheese, Tomato, and Pepperoni",
    price: 12.00,
    editedAt: DateTime.now(),
    available: true,
    dishCategory: dummyDishCategories[1],
  ),
  DishModel(
    id: 3,
    name: "Cheeseburger",
    description: "Cheese and Beef",
    price: 8.00,
    editedAt: DateTime.now(),
    available: true,
    dishCategory: dummyDishCategories[2],
  ),
  DishModel(
    id: 4,
    name: "Hamburger",
    description: "Beef",
    price: 7.00,
    editedAt: DateTime.now(),
    available: true,
    dishCategory: dummyDishCategories[2],
  ),
];

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:turbbbites_flutter_app/core/api/controllers/dish_controller.dart';
import 'package:turbbbites_flutter_app/core/controllers/cart_controller.dart';
import 'package:turbbbites_flutter_app/models/dish_model.dart';
import 'package:turbbbites_flutter_app/views/dish/dish_view.dart';
import 'package:turbbbites_flutter_app/widgets/dish_list_item.dart';

class DishList extends StatelessWidget {
  DishList({super.key, required this.dishes, required this.total});
  final List<DishModel> dishes;
  final int total;
  final CartController cartController = CartController.controller;


  void _selectDish(BuildContext context, DishModel dish) {
    if(cartController.restaurantId == null) {
      Get.toNamed('/map', arguments: dish);
    } else {
      Get.toNamed("/dish", arguments: dish);
    }
  }

  @override
  Widget build(BuildContext context) {
    Widget content = ListView.builder(
        itemCount: dishes.length,
        itemBuilder: (ctx, index) {
          return DishListItem(
              dish: dishes[index],
              onSelected: (dish) {
                _selectDish(context, dish);
              });
        });

    if (dishes.isEmpty) {
      content = const Center(
        child: Text(
          "No dishes found",
        ),
      );
    }
    return content;
  }
}

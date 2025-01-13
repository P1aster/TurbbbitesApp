import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:turbbbites_flutter_app/core/controllers/cart_controller.dart';
import 'package:turbbbites_flutter_app/core/controllers/location_shared_preference_controller.dart';
import 'package:turbbbites_flutter_app/models/dish_model.dart';
import 'package:turbbbites_flutter_app/models/restaurant_model.dart';
import 'package:turbbbites_flutter_app/views/map/map_locations_list.dart';

class MapView extends StatelessWidget {
  final DishModel? dish;
  final LocationSharedPreferenceController locationController =
      LocationSharedPreferenceController.controller;
  final CartController cartController = CartController.controller;

  MapView({super.key, this.dish});

  void setStoreLocation(RestaurantModel restaurant) async {
    var bool = await locationController.setSharedPreferences(restaurant);
    cartController.setRestaurantId(restaurant.id);
    if(dish != null) {
      return;
    }
    if (bool) {
      Get.back();
    } else {
      Get.snackbar("Error", "Error while saving location");
    }
  }

  void _goToDish() {
    if(dish != null) {
      Get.offNamed("/dish", arguments: dish);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      bottomNavigationBar: dish != null ? BottomAppBar(
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 16),
          child: Obx(() => FilledButton.icon(
              onPressed: locationController.restaurantModel.value != null ? _goToDish : null,
              icon: const Icon(Icons.arrow_circle_right_outlined),
              iconAlignment: IconAlignment.end,
              label:  const Text("Proceed to dish"),
            ),
          ),
        ),
      ) : null,
      body: Column(
        children: [
          Container(
            height: 250,
            padding: const EdgeInsets.symmetric(vertical: 16),
            child: Obx(() => MapLocationsList(selected: locationController.restaurantModel.value, setStoreLocation: setStoreLocation)),
          ),
        ],
      ),
    );
  }
}

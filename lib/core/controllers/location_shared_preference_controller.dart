import 'dart:convert';

import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:turbbbites_flutter_app/models/restaurant_model.dart';

class LocationSharedPreferenceController extends GetxController {
  Rxn<RestaurantModel> restaurantModel = Rxn<RestaurantModel>();
  static LocationSharedPreferenceController get controller =>
      Get.find<LocationSharedPreferenceController>();

  Future<RestaurantModel?> getSharedPreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? res = prefs.getString("location");
    if (res != null) {
      var model = RestaurantModel.fromJson(jsonDecode(res));
      controller.restaurantModel.value = model;
      return model;
    }
    return null;
  }

  Future<bool> setSharedPreferences(RestaurantModel restaurant) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    restaurantModel.value = restaurant;
    return await prefs.setString(
        "location",
        jsonEncode({
          'id': restaurant.id,
          'address': restaurant.address,
          'postalCode': restaurant.postalCode,
          'city': restaurant.city,
          'registrationDate': restaurant.registrationDate.toIso8601String(),
          'description': restaurant.description,
          'contactInformation': restaurant.contactInformation,
        }).toString());
  }
}

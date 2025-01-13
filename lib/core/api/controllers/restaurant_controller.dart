import 'package:get/get.dart';
import 'package:turbbbites_flutter_app/core/api/services/restaurant_service.dart';
import 'package:turbbbites_flutter_app/models/restaurant_model.dart';

class RestaurantApiController extends GetxController {
  final service = Get.put(RestaurantApiService());
  static RestaurantApiController get controller =>
      Get.find<RestaurantApiController>();
  RxBool get isLoading => service.isLoading;
  RxBool get isError => service.isError;
  RxBool get isSuccess => service.isSuccess;
  RxString get error => service.error;
  RxString get message => service.message;

  Future<List<RestaurantModel>?> getAllRestaurants() async {
    final response = await service.getAll();
    if (response.isSuccess) {
      return response.data;
    }
    return null;
  }
}

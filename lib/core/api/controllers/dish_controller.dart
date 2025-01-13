import 'package:get/get.dart';
import 'package:turbbbites_flutter_app/core/api/services/dish_service.dart';
import 'package:turbbbites_flutter_app/models/pagination_model.dart';
import 'package:turbbbites_flutter_app/models/dish_model.dart';

class DishApiController extends GetxController {
  final service = Get.put(DishApiService());
  static DishApiController get controller => Get.find<DishApiController>();
  RxBool get isLoading => service.isLoading;
  RxBool get isError => service.isError;
  RxBool get isSuccess => service.isSuccess;
  RxString get error => service.error;
  RxString get message => service.message;

  Future<PaginationResponseModel<DishModel>?> getAllDishes(
      int? categoryId) async {
    final response = await service.getAll(categoryId);
    if (response.isSuccess) {
      return response.data;
    }
    return null;
  }
}

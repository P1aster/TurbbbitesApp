import 'package:get/get.dart';
import 'package:turbbbites_flutter_app/core/api/services/dish_category_service.dart';
import 'package:turbbbites_flutter_app/models/dish_category_model.dart';

class DishCategoryApiController extends GetxController {
  final service = Get.put(DishCategoryApiService());
  static DishCategoryApiController get controller => Get.find<DishCategoryApiController>();

  RxBool get isLoading => service.isLoading;
  RxBool get isError => service.isError;
  RxBool get isSuccess => service.isSuccess;
  RxString get error => service.error;
  RxString get message => service.message;

  Future<List<DishCategoryModel>?> getAllCategories() async {
    final response = await service.getAll();
    if (response.isSuccess) {
      return response.data;
    }
    return null;
  }
}

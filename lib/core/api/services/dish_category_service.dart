import 'package:turbbbites_flutter_app/core/api/base_api_controller.dart';
import 'package:turbbbites_flutter_app/models/dish_category_model.dart';
import 'package:turbbbites_flutter_app/core/api/base_api_service.dart';

class DishCategoryApiService extends BaseApiService with BaseApiController {
  Future<ApiResponse<List<DishCategoryModel>>> getAll() async {
    return await get<List<DishCategoryModel>>(
        endpoint: '/api/dishCategory',
        fromJson: (json) {
          return (json as List)
              .map((item) => DishCategoryModel.fromJson(item))
              .toList();
        });
  }
}

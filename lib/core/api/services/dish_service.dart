import 'package:turbbbites_flutter_app/core/api/base_api_controller.dart';
import 'package:turbbbites_flutter_app/core/api/base_api_service.dart';
import 'package:turbbbites_flutter_app/models/pagination_model.dart';
import 'package:turbbbites_flutter_app/models/dish_model.dart';

class DishApiService extends BaseApiService with BaseApiController {
  Future<ApiResponse<PaginationResponseModel<DishModel>>> getAll(
      int? categoryId) async {
    return await get<PaginationResponseModel<DishModel>>(
        endpoint: '/api/dish',
        queryParams: categoryId != null ? {'categoryId': categoryId} : null,
        fromJson: (json) {
          return PaginationResponseModel<DishModel>.fromJson(json, (data) {
            return DishModel.fromJson(data);
          });
        });
  }
}

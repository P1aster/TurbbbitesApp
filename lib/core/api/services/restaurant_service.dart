import 'package:turbbbites_flutter_app/core/api/base_api_controller.dart';
import 'package:turbbbites_flutter_app/core/api/base_api_service.dart';
import 'package:turbbbites_flutter_app/models/restaurant_model.dart';

class RestaurantApiService extends BaseApiService with BaseApiController {
  Future<ApiResponse<List<RestaurantModel>>> getAll() async {
    return await get<List<RestaurantModel>>(
        endpoint: '/api/restaurant',
        fromJson: (json) {
          return (json as List)
              .map((item) => RestaurantModel.fromJson(item))
              .toList();
        });
  }
}

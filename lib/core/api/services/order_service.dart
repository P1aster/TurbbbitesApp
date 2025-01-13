import 'package:turbbbites_flutter_app/models/cart_model.dart';
import 'package:turbbbites_flutter_app/models/order_model.dart';
import 'package:turbbbites_flutter_app/core/api/base_api_controller.dart';
import 'package:turbbbites_flutter_app/core/api/base_api_service.dart';
import 'package:turbbbites_flutter_app/models/pagination_model.dart';

class OrderService extends BaseApiService with BaseApiController {
  Future<ApiResponse<PaginationResponseModel<OrderModel>>> getAll() async {
    return await get<PaginationResponseModel<OrderModel>>(
        endpoint: '/api/order',
        fromJson: (json) {
          return PaginationResponseModel<OrderModel>.fromJson(json, (data) {
            return OrderModel.fromJson(data);
          });
        });
  }

  Future<ApiResponse<OrderModel>> postOrder(CartModel cart) async {
    return await post<OrderModel>(
        endpoint: '/api/order',
        data: cart.toJson(),
        fromJson: (json) {
          return OrderModel.fromJson(json);
        },
        );
  }
}

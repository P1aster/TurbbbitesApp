
import 'package:get/get.dart';
import 'package:turbbbites_flutter_app/core/api/services/order_service.dart';
import 'package:turbbbites_flutter_app/models/cart_model.dart';
import 'package:turbbbites_flutter_app/models/order_model.dart';
import 'package:turbbbites_flutter_app/models/pagination_model.dart';

class OrderApiController extends GetxController {
  final service = Get.put(OrderService());
  static OrderApiController get controller => Get.find<OrderApiController>();
  RxBool get isLoading => service.isLoading;
  RxBool get isError => service.isError;
  RxBool get isSuccess => service.isSuccess;
  RxString get error => service.error;
  RxString get message => service.message;

  Future<PaginationResponseModel<OrderModel>?> getAllOrders() async {
    final response = await service.getAll();
    if (response.isSuccess) {
      return response.data;
    }
    return null;
  }

  Future<OrderModel?> addOrder(CartModel cart) async {
    final response = await service.postOrder(cart);
    if (response.isSuccess) {
      return response.data;
    }
    return null;
  }
}
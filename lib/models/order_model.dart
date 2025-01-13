import 'package:turbbbites_flutter_app/models/dish_model.dart';

enum OrderStatus {
  pending,
completed,
collected,
cancelled,
waitingPayment,
}

class OrderItemModel {
  const OrderItemModel({
    required this.quantity,
    required this.orderId,
    required this.dishId,
    required this.dish
  });

  final int quantity;
  final int orderId;
  final int dishId;
  final DishModel dish;

  factory OrderItemModel.fromJson(Map<String, dynamic> json) {
    return OrderItemModel(
      quantity: json['quantity'],
      orderId: json['orderId'],
      dishId: json['dishId'],
      dish: DishModel.fromJson(json['dish']),
    );
  }
}

class OrderModel {
  const OrderModel({
    required this.id,
    required this.status,
    required this.createdAt,
    required this.editedAt,
    required this.totalPrice,
    this.orderItems,

});
  final int id;
  final OrderStatus status;
  final DateTime createdAt;
  final DateTime editedAt;
  final double totalPrice;
  final List<OrderItemModel>? orderItems;


  factory OrderModel.fromJson(Map<String, dynamic> json) {
    var rawTotalPrice = json['totalPrice'].runtimeType == double ? json['totalPrice'] : double.parse(json['totalPrice']);
    return OrderModel(
      id: json['id'],
      totalPrice: rawTotalPrice,
      status: OrderStatus.pending, // OrderStatus.values[json['status']],
      createdAt: DateTime.parse(json['createdAt']),
      editedAt: DateTime.parse(json['editedAt']),
    );
  }


}
